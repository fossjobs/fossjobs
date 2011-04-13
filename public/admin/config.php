<?php
/**
 * jobber job board platform - admin panel
 *
 * @author     Lavinia Creivean <links_clm@yahoo.com>
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original authors ;)
 *             (see license.txt).
 */

	require_once '../_config/config.php';
	require_once '_includes/class.Types.php';
	
	$currentDirectoryNames = explode('/', dirname($_SERVER['PHP_SELF']));
	
	define('CURRENT_DIRECTORY', end($currentDirectoryNames));
	$smarty->template_dir = APP_PATH . CURRENT_DIRECTORY. '/_templates/';
	$smarty->compile_dir = APP_PATH . CURRENT_DIRECTORY. '/_templates/_cache/';

	define('BASE_URL_ORIG', APP_URL);
	define('BASE_URL', APP_URL . 'admin/');
	
	$page = (isset($_app_info['params'][0]) ? $db->real_escape_string($_app_info['params'][0]) : '');
	$id = (isset($_app_info['params'][1]) ? $db->real_escape_string($_app_info['params'][1]) : 0);
	$extra = (isset($_app_info['params'][2]) ? $db->real_escape_string($_app_info['params'][2]) : '');
	
?>