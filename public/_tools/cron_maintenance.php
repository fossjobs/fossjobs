<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 */

	require_once '../_config/config.php';
	require_once APP_PATH . '_includes/class.Maintenance.php';

	$janitor = new Maintenance();

	// delete temporary posts older than 2 days
	$janitor->DeleteTemporaryJobs();
?>