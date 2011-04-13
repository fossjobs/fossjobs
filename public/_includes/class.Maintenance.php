<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * Maintenance class handles site/database maintenance operations
 */

class Maintenance
{
	
	function __construct()
	{ }
	
	// delete temporary posts older than 2 days
	public function DeleteTemporaryJobs()
	{
		global $db;
		$sql = 'DELETE FROM '.DB_PREFIX.'jobs WHERE created_on < DATE_SUB(NOW(), INTERVAL 1 DAY) AND is_temp = 1 AND is_active = 0';
		$db->Execute($sql);
	}
}
?>