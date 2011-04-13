<?php
	class Installer
	{
		private $m_szNeededPhpVersion = "5.0.0";
		private $m_szNeededMySQLVersion = "4.1";
		private $m_szLastError;
		
		function __construct()
		{
		}
		
		public function CheckPhpVersion()
		{
			return phpversion() >= $this->m_szNeededPhpVersion;
		}
		
		public function CheckMySQLiInterface($szDbHost, $szDbName, $szDbUser, $szDbPass)
		{
			//Let's try MySQLi first
			require_once '_includes/class.Db.php';
			try 
			{
				$db = new Db($szDbHost, $szDbUser, $szDbPass, $szDbName);
				$db->Execute('SET CHARSET UTF8');
			}
			catch(ConnectException $exception) 
			{
				//The server doesn't support the mysqli extension, try again with mysql
				$this->m_szLastError = $exception->getMessage();
				return false;
			}
			return true;
		}
		
		public function CheckMySQLInterface($szDbHost, $szDbName, $szDbUser, $szDbPass)
		{
			//The server doesn't not have the MySQLi extension installed. Fall back to MySQL
			require_once '_includes/class.Db.MySql.php';
			
			try
			{
				$db = new Db($szDbHost, $szDbUser, $szDbPass, $szDbName);
				$db->Execute('SET CHARSET UTF8');
			}
			catch(ConnectException $exception) 
			{
				$this->m_szLastError = $exception->getMessage();
				return false;
			}
			return true;
		}
		
		public function CheckMySQLVersion()
		{
			global $db;
			
			preg_match('@[0-9]+\.[0-9]+\.[0-9]+@', $db->GetServerInfo(), $szVerArray);
			$szMySQLVersion = $szVerArray[0];
			
			return $szMySQLVersion >= $this->m_szNeededMySQLVersion;
		}
		
		//Check to see whether the cache folder has write rights
		public function CheckCachePermissions()
		{
			return (fileperms('_templates/_cache') & 0x0002) != 0;
		}
		
		//Check to see if the uploads folder has write rights
		public function CheckUploadPermissions()
		{
			return (fileperms('uploads') & 0x0002) != 0;
		}
		
		public function WriteConfigFile($szDbHost, $szDbName, $szDbUser, $szDbPassword, $bUsingMySQLi)
		{
			//Read the default configuration file
			$hDefaultConfig = fopen('config_default.php', 'r+');
			if (!$hDefaultConfig)
			{
				$this->m_szLastError = "Could not find default configuration file (config_default.php)";
				return false;
			}
			
			$dConfigFileSize = filesize("config_default.php");
			$szConfigFile = fread($hDefaultConfig, $dConfigFileSize + 1);
			fclose($hDefaultConfig);
			
			//Replace the default values with local settings
			$szConfigFile = str_replace('[[DB_HOST]]', $szDbHost, $szConfigFile);
			$szConfigFile = str_replace('[[DB_USER]]', $szDbUser, $szConfigFile);
			$szConfigFile = str_replace('[[DB_PASS]]', $szDbPassword, $szConfigFile);
			$szConfigFile = str_replace('[[DB_NAME]]', $szDbName, $szConfigFile);
			if ($bUsingMySQLi)
				$szConfigFile = str_replace('[[DB_FILE]]', 'Db', $szConfigFile);
			else
				$szConfigFile = str_replace('[[DB_FILE]]', 'Db.MySql', $szConfigFile);
			
			//Write the new configuration file
			$hConfigFile = fopen('config.php', 'w+');
			if (!$hConfigFile)
			{
				$this->m_szLastError = "Could not open configuration file (config.php) for writing.";
				return false;
			}
			
			fwrite($hConfigFile, $szConfigFile, strlen($szConfigFile));
			fclose($hConfigFile);
			
			return true;
		}
		
		public function SetUpDb()
		{
			global $db;
			$dSqlFileSize = filesize("__db/jobberbase.sql");
			$hSqlFile = fopen("__db/jobberbase.sql", "rt");
			
			if (!$hSqlFile)
			{
				$this->m_szLastError = "The jobberbase.sql file seems to be missing";
				return false;
			}
			$szSqlContent = fread($hSqlFile, $dSqlFileSize + 1);
			fclose($hSqlFile);
			
			if (!$db->ExecuteMultiple($szSqlContent))
			{
				$this->m_szLastError = "Could not create database entries";
				return false;
			}
			
			return true;
		}
		
		public function GetLastError()
		{
			return $this->m_szLastError;
		}
	}
?>