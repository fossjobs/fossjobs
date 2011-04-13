<?php
 class CAdmin
 {
 	private $userId;
 	private $username;
 	private $email;
 	
 	public function __construct(){}
 	
 	public function login($username, $password)
 	{
 		global $db;
		$md5password = md5($password);
		$sql = 'SELECT id FROM '.DB_PREFIX.'admin WHERE username="'.$username.'" AND password="'.$md5password.'"';
		$result = $db->query($sql);
		$row = $result->fetch_assoc();
		if (!empty($row))
		{
			$this->userId = $row['id']; 
			return true;
		}
		return false;
 	}
 	
 	public function getId()
 	{
 		return $this->userId;
 	}
 }
?>