<?php
/**
 * Define environments
 *
 */

// local (http://localhost/jobberbase/public)
$__instances['local'] = array(
	// should be a unique part of the url (or the entire url if you wish)
	'prefix' => 'localhost',
	// mysql credentials
	'db_host' => 'localhost',
	'db_port' => 3306,
	'db_user' => 'root',
	'db_password' => '',
	'db_name' => 'jobberbase',
	'db_prefix' => '',
	// your site's full url
	'app_url' => 'http://localhost/jobberbase/trunk/public/',
	// error reporting
	'ini_error_reporting' => E_ALL,
	'ini_display_errors' => 'On',
	// environment setting 1 (use 'local' for localhost/testing OR 'online' for live, production environment)
	'location' => 'local',
	// environment setting 2 (use 'dev' together with 'local' in the previous setting OR 'prod' with 'online')
	'environment' => 'dev',
	//'apache_mod_rewrite', 'iis_url_rewrite' -microsoft URL Rewrite module, 'iis_isapi_rewrite'
	'rewrite_mode' => 'apache_mod_rewrite'
);

// live (http://www.yourjobberbasedomain.com)
$__instances['live'] = array(
	'prefix' => 'yourjobberbasedomain.com',
	'db_host' => 'localhost',
	'db_port' => 3306,
	'db_user' => 'root',
	'db_password' => '',
	'db_name' => 'jobberbase',
	'db_prefix' => '',
	'app_url' => 'http://www.yourjobberbasedomain.com/',
	'ini_error_reporting' => E_ALL,
	'ini_display_errors' => 'Off',
	'location' => 'online',
	'environment' => 'prod',
	'rewrite_mode' => 'apache_mod_rewrite'
);


// setup current instance
foreach ($__instances as $__instance)
{
	// http requests
	if (isset($_SERVER['HTTP_HOST']))
	{
		$_compare_to = $_SERVER['HTTP_HOST'];
	}

	if (strstr($_compare_to, $__instance['prefix']))
	{
		define('DB_HOST', $__instance['db_host']);
		define('DB_PORT', $__instance['db_port']);
		define('DB_USER', $__instance['db_user']);
		define('DB_PASS', $__instance['db_password']);
		define('DB_NAME', $__instance['db_name']);
		define('DB_PREFIX', $__instance['db_prefix']);

		// values kind of redundant, they indicate wether this is a live/production or dev/testing environment
		define('LOCATION', $__instance['location']);
		define('ENVIRONMENT', $__instance['environment']);
		
		// base url of the app
		define('APP_URL', $__instance['app_url']);
		define('REWRITE_MODE', $__instance['rewrite_mode']);
		// error reporting
		ini_set('error_reporting', $__instance['ini_error_reporting']);
		ini_set('display_errors', $__instance['ini_display_errors']);
		
		break;
	}
}
?>