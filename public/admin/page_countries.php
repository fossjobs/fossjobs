<?php
	require_once '_includes/class.CountryDAO.php';
	
	class CountriesPage
	{
		private $template = '';
		private $smarty;
		
		private $countryDAO;
		
		public function __construct()
		{
			$this->countryDAO = CountryDAO::getInstance();	
		}
			
		public function processRequest($action, $countryID, $smarty)
		{
			$this->smarty = $smarty;
			
			$this->smarty->assign('current_category', 'countries');
			
			switch ($action)
			{
				case '':
					
					$this->prepareDisplayCountries();
					break;
					
				case 'prepare-add':
					
					$country = array('name' => '', 'ascii_name' => '');
					
					$this->smarty->assign('action', 'add');
					$this->smarty->assign('country', $country);
					
					$this->template = 'country_edit.tpl';
					
					break;
					
				case 'add':
					
					escape($_POST);
					
					$errors = array();
					
					if (isset($GLOBALS['name']) && isset($GLOBALS['ascii_name']))
					{
						$name = trim($GLOBALS['name']);
						$asciiName = trim($GLOBALS['ascii_name']);
						
						$this->validateCountry($name, $asciiName, $errors);
						
						if (count($errors) == 0)
						{
							$countryByAsciiName = $this->getCountryByAsciiName($asciiName);
							
							if ($countryByAsciiName)
								$errors['asciiName'] = 'Ascii name not unique';
							else
							{
								$this->createCountry($name, $asciiName);
								
								$this->prepareDisplayCountries();
							}
						}
						
						// there are errors
						if (count($errors))
						{
							$country['name'] = $_POST['name'];
							$country['ascii_name'] = $_POST['ascii_name'];
							
							$this->smarty->assign('action', 'add');
							$this->smarty->assign('country', $country);
							$this->smarty->assign('errors', $errors);
							
							$this->template = 'country_edit.tpl';
						}
					}
					else
						$this->prepareDisplayCountries();
					
					break;
					
				case 'prepare-edit':
					
					if (isset($countryID) && $countryID != '')
					{
						$country = $this->getCountryByID($countryID);
						
						if ($country)
						{
							$this->smarty->assign('action', 'edit');
							$this->smarty->assign('country', $country);
							
							$this->template = 'country_edit.tpl';
						}
						else
							$this->prepareDisplayCountries();
					}
					else
						$this->prepareDisplayCountries();
						
					break;
					
				case 'edit':
					
					escape($_POST);
					
					$errors = array();
					
					if (isset($GLOBALS['name']) && isset($GLOBALS['ascii_name']))
					{
						$name = trim($GLOBALS['name']);
						$asciiName = trim($GLOBALS['ascii_name']);
						
						$countryID = $GLOBALS['id'];
						$country = $this->getCountryByID($countryID);	
						
						$this->validateCountry($name, $asciiName, $errors);
						
						if (count($errors) == 0)
						{
							// if the user has changed the ascii name
							if (strcasecmp($country['ascii_name'], $asciiName))
							{
								$countryByAsciiName = $this->getCountryByAsciiName($asciiName);
								
								if ($countryByAsciiName)
									$errors['asciiName'] = 'Ascii name not unique';
							}
							
							if (count($errors) == 0)
							{
								$country['name'] = $name;
								$country['ascii_name'] = $asciiName;
								
								$this->updateCountry($country);
								
								$this->prepareDisplayCountries();
							}
						}
						
						// there are errors
						if (count($errors))
						{
							$country['name'] = $_POST['name'];
							$country['ascii_name'] = $_POST['ascii_name'];
							
							$this->smarty->assign('action', 'edit');
							$this->smarty->assign('country', $country);
							$this->smarty->assign('errors', $errors);
							
							$this->template = 'country_edit.tpl';
						}
					}
					else
						$this->prepareDisplayCountries();
					
					break;
					
				case 'delete':
					if (isset($_POST['countryID']))
					{
						$countryID = $_POST['countryID'];
						
						$country = $this->getCountryByID($countryID);
						
						if ($country)
						{
							$this->updateJobsForCountryDeletion($country);
							
							$this->deleteCountry($country);
							
							echo 1;
						}
						else
							echo 0;
						
						exit;
					}
					else
						$this->prepareDisplayCountries();
						
					break;
					
				case 'list': ; // do nothing, just fall through 
				default:
					$this->prepareDisplayCountries();
			}
			
			return $this->template;
		}
		
		private function getCountryByID($countryID)
		{
			return $this->countryDAO->getCountryByID($countryID);
		}
		
		private function prepareAddCountry()
		{
			$country = array('name' => '', 'ascii_name' => '');
					
			$this->smarty->assign('action', 'add');
			$this->smarty->assign('country', $country);
		}
		
		private function prepareDisplayCountries()
		{
			$countries = $this->getCountries();
				
			$this->smarty->assign('countries', $countries);
								
			$this->template = 'countries.tpl';
		}
		
		private function getCountries()
		{
			return $this->countryDAO->getCountries();
		}
		
		private function getCountryByAsciiName($asciiName)
		{
			return $this->countryDAO->getCountryByAsciiName($asciiName);
		}
		
		private function updateCountry($country)
		{
			$this->countryDAO->updateCountry($country);
		}
		
		/**
		 * Validates the name and asciiName and puts the error messages (if any)
		 * in the $errors array.
		 * @param $name
		 * @param $asciiName
		 * @param $errors
		 * @return void
		 */
		private function validateCountry($name, $asciiName, &$errors)
		{
			if ($name == '')
				$errors['name'] = 'Country name';
			
			if ($asciiName == '')
				$errors['asciiName'] = 'Ascii name';
			else
				if (preg_match('/([^a-z0-9\-_]+?)/i', $asciiName))
					$errors['asciiName'] = 'Ascii name must contain only alphanumerical characters, dashes and underscores';
		}
		
		private function createCountry($name, $asciiName)
		{
			$country = array('name' => $name, 'ascii_name' => $asciiName);
			
			$this->countryDAO->insertCountry($country);
		}
		
		private function updateJobsForCountryDeletion($country)
		{
			global $db;
			
			$query = 'UPDATE '.DB_PREFIX.'jobs SET
					  country_id = NULL,
					  city = "'. $db->real_escape_string($country['name']) .'" 
					  WHERE 
					  country_id = ' . $country['id'];
			
			$db->query($query);
		}
		
		private function deleteCountry($country)
		{
			$this->countryDAO->deleteCountry($country);
		}
	}
?>
