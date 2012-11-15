<?php

class CountryDAO
{
	private static $instance;
	
	public static function getInstance()
	{
		if (self::$instance == null)
			self::$instance = new CountryDAO();
		
		return self::$instance;
	}
	
	public function updateCountry($country)
	{
		global $db;
		
		$sql = 'UPDATE '.DB_PREFIX.'countries
				SET name = "' . $country['name'] . '"
				WHERE id = ' . $country['id'];
		
		$db->query($sql);
	}
	
	public function deleteCountry($country)
	{
		global $db;
		
		$sql = 'DELETE FROM '.DB_PREFIX.'countries
				WHERE id = ' . $country['id'];
		
		$db->query($sql);
	}
	
	public function getCountryByID($countryID)
	{
		global $db;
		
		$country = null;
		
		$sql = 'SELECT id, name
		               FROM '.DB_PREFIX.'countries
		               WHERE id = ' . $countryID;
		
		$result = $db->query($sql);
		
		$row = $result->fetch_assoc();
		
		if ($row)
			$country = array('id' => $row['id'], 'name' => $row['name'], 'ascii_name' => str_replace(' ', '-', $row['name']));
			
		return $country;  
	}
	
	public function getCountryByAsciiName($ascii_name)
	{
		global $db;
		
		$country = null;
		
		$sql = 'SELECT id, name
		               FROM '.DB_PREFIX.'countries
		               WHERE name = "' . str_replace('-', ' ', $name) . '"';
	
		$result = $db->query($sql);
		$row = $result->fetch_assoc();
		
		if ($row)
			$country = array('id' => $row['id'], 'name' => $row['name']);
			
		return $country;
	}
	
	public function insertCountry($country)
	{
		global $db;
		
		$sql = 'INSERT INTO '.DB_PREFIX.'countries SET name = "' . $country['name'] . '"';
		
		$db->query($sql);
	}
	
	function getCountries()
	{
		global $db;
		
		$countries = array();
		
		$sql = 'SELECT id, name
		               FROM '.DB_PREFIX.'countries
		               ORDER BY name ASC';
		
		$result = $db->query($sql);
		
		while ($row = $result->fetch_assoc())
		{
			$countries[] = array('id' => $row['id'], 'name' => $row['name'], 'ascii_name' => str_replace(' ', '-', $row['name']));
		}
		
		return $countries;
	}
}
?>
