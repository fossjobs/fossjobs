<?php
	require_once '_includes/class.CityDAO.php';
	
	class CitiesPage
	{
		private $template = '';
		private $smarty;
		
		private $cityDAO;
		
		public function __construct()
		{
			$this->cityDAO = CityDAO::getInstance();	
		}
			
		public function processRequest($action, $cityID, $smarty)
		{
			$this->smarty = $smarty;
			
			$this->smarty->assign('current_category', 'cities');
			
			switch ($action)
			{
				case '':
					
					$this->prepareDisplayCities();
					break;
					
				case 'prepare-add':
					
					$city = array('name' => '', 'ascii_name' => '');
					
					$this->smarty->assign('action', 'add');
					$this->smarty->assign('city', $city);
					
					$this->template = 'city_edit.tpl';
					
					break;
					
				case 'add':
					
					escape($_POST);
					
					$errors = array();
					
					if (isset($GLOBALS['name']) && isset($GLOBALS['ascii_name']))
					{
						$name = trim($GLOBALS['name']);
						$asciiName = trim($GLOBALS['ascii_name']);
						
						$this->validateCity($name, $asciiName, $errors);
						
						if (count($errors) == 0)
						{
							$cityByAsciiName = $this->getCityByAsciiName($asciiName);
							
							if ($cityByAsciiName)
								$errors['asciiName'] = 'Ascii name not unique';
							else
							{
								$this->createCity($name, $asciiName);
								
								$this->prepareDisplayCities();
							}
						}
						
						// there are errors
						if (count($errors))
						{
							$city['name'] = $_POST['name'];
							$city['ascii_name'] = $_POST['ascii_name'];
							
							$this->smarty->assign('action', 'add');
							$this->smarty->assign('city', $city);
							$this->smarty->assign('errors', $errors);
							
							$this->template = 'city_edit.tpl';
						}
					}
					else
						$this->prepareDisplayCities();
					
					break;
					
				case 'prepare-edit':
					
					if (isset($cityID) && $cityID != '')
					{
						$city = $this->getCityByID($cityID);
						
						if ($city)
						{
							$this->smarty->assign('action', 'edit');
							$this->smarty->assign('city', $city);
							
							$this->template = 'city_edit.tpl';
						}
						else
							$this->prepareDisplayCities();
					}
					else
						$this->prepareDisplayCities();
						
					break;
					
				case 'edit':
					
					escape($_POST);
					
					$errors = array();
					
					if (isset($GLOBALS['name']) && isset($GLOBALS['ascii_name']))
					{
						$name = trim($GLOBALS['name']);
						$asciiName = trim($GLOBALS['ascii_name']);
						
						$cityID = $GLOBALS['id'];
						$city = $this->getCityByID($cityID);	
						
						$this->validateCity($name, $asciiName, $errors);
						
						if (count($errors) == 0)
						{
							// if the user has changed the ascii name
							if (strcasecmp($city['ascii_name'], $asciiName))
							{
								$cityByAsciiName = $this->getCityByAsciiName($asciiName);
								
								if ($cityByAsciiName)
									$errors['asciiName'] = 'Ascii name not unique';
							}
							
							if (count($errors) == 0)
							{
								$city['name'] = $name;
								$city['ascii_name'] = $asciiName;
								
								$this->updateCity($city);
								
								$this->prepareDisplayCities();
							}
						}
						
						// there are errors
						if (count($errors))
						{
							$city['name'] = $_POST['name'];
							$city['ascii_name'] = $_POST['ascii_name'];
							
							$this->smarty->assign('action', 'edit');
							$this->smarty->assign('city', $city);
							$this->smarty->assign('errors', $errors);
							
							$this->template = 'city_edit.tpl';
						}
					}
					else
						$this->prepareDisplayCities();
					
					break;
					
				case 'delete':
					if (isset($_POST['cityID']))
					{
						$cityID = $_POST['cityID'];
						
						$city = $this->getCityByID($cityID);
						
						if ($city)
						{
							$this->updateJobsForCityDeletion($city);
							
							$this->deleteCity($city);
							
							echo 1;
						}
						else
							echo 0;
						
						exit;
					}
					else
						$this->prepareDisplayCities();
						
					break;
					
				case 'list': ; // do nothing, just fall through 
				default:
					$this->prepareDisplayCities();
			}
			
			return $this->template;
		}
		
		private function getCityByID($cityID)
		{
			return $this->cityDAO->getCityByID($cityID);
		}
		
		private function prepareAddCity()
		{
			$city = array('name' => '', 'ascii_name' => '');
					
			$this->smarty->assign('action', 'add');
			$this->smarty->assign('city', $city);
		}
		
		private function prepareDisplayCities()
		{
			$cities = $this->getCities();
				
			$this->smarty->assign('cities', $cities);
								
			$this->template = 'cities.tpl';
		}
		
		private function getCities()
		{
			return $this->cityDAO->getCities();
		}
		
		private function getCityByAsciiName($asciiName)
		{
			return $this->cityDAO->getCityByAsciiName($asciiName);
		}
		
		private function updateCity($city)
		{
			$this->cityDAO->updateCity($city);
		}
		
		/**
		 * Validates the name and asciiName and puts the error messages (if any)
		 * in the $errors array.
		 * @param $name
		 * @param $asciiName
		 * @param $errors
		 * @return void
		 */
		private function validateCity($name, $asciiName, &$errors)
		{
			if ($name == '')
				$errors['name'] = 'City name';
			
			if ($asciiName == '')
				$errors['asciiName'] = 'Ascii name';
			else
				if (preg_match('/([^a-z0-9\-_]+?)/i', $asciiName))
					$errors['asciiName'] = 'Ascii name must contain only alphanumerical characters, dashes and underscores';
		}
		
		private function createCity($name, $asciiName)
		{
			$city = array('name' => $name, 'ascii_name' => $asciiName);
			
			$this->cityDAO->insertCity($city);
		}
		
		private function updateJobsForCityDeletion($city)
		{
			global $db;
			
			$query = 'UPDATE '.DB_PREFIX.'jobs SET
					  city_id = NULL,
					  outside_location = "'. $db->real_escape_string($city['name']) .'" 
					  WHERE 
					  city_id = ' . $city['id'];
			
			$db->query($query);
		}
		
		private function deleteCity($city)
		{
			$this->cityDAO->deleteCity($city);
		}
	}
?>