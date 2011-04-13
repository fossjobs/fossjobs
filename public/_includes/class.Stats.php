<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * Stats class provides some useful stats about the site's usage (number of applications and searched keywords)
 */

class Stats
{
	const MAKE_STATS_ON_MAX_NUMBER_OF_APPLICATIONS = 50;
	const MAKE_STATS_ON_MAX_NUMBER_OF_SEARCHES = 50;
	 
	function __construct()
	{ }
	
	public function Applications()
	{
		global $db;
		
		$sql = 'SELECT count(a.job_id) AS totalNumberOfApplications
		                        FROM '.DB_PREFIX.'job_applications a, '.DB_PREFIX.'jobs b
		                        WHERE a.job_id = b.id';
		$result = $db->query($sql);
		$row = $result->fetch_assoc();
		
		$totalNumberOfApplications = $row['totalNumberOfApplications'];
		
		$sql = 'SELECT DATE_FORMAT(a.created_on, "' . DATE_TIME_FORMAT . '") AS date, b.title AS title, b.company AS company, a.job_id AS job_id
		                        FROM '.DB_PREFIX.'job_applications a, '.DB_PREFIX.'jobs b
		                        WHERE a.job_id = b.id
		                        ORDER BY a.created_on DESC limit ' . self::MAKE_STATS_ON_MAX_NUMBER_OF_APPLICATIONS;
		$result = $db->query($sql);
		
		$stats = '';
		while ($row = $result->fetch_assoc())
			$stats .= '<div>' . $row['date'] . ' <a href="' . BASE_URL . URL_JOB .'/' . $row['job_id'] . '/">' . $row['title'] . ' la ' . $row['company'] . '</a></div>';
		
		$apps_per_day = array();
		$sql = 'SELECT count(id) AS nr FROM '.DB_PREFIX.'job_applications WHERE created_on > DATE_SUB(NOW(), INTERVAL 8 DAY) GROUP BY DATE_FORMAT(created_on, "%Y-%m-%d")';
		$result = $db->query($sql);
		
		while ($row = $result->fetch_assoc())
			$apps_per_day[] = $row['nr'];
		
		$avg = 0;	
		$maxNumberOfApplications = 0;
		$numberOfApplications = array_sum($apps_per_day);
		$numberOfDaysWithApplications = count($apps_per_day);
		
		if ($numberOfDaysWithApplications > 0)
		{
			$avg = ceil(array_sum($apps_per_day) / count($apps_per_day));
			$maxNumberOfApplications = max($apps_per_day);
		}
		
		return array('stats' => $stats, 'count' => $totalNumberOfApplications, 'avg' => $avg, 'max' => $maxNumberOfApplications);
	}
	
	public function Keywords()
	{
		global $db;
		
		$sql = 'SELECT count(id) AS totalNumberOfSearches FROM '.DB_PREFIX.'searches';
		$result = $db->query($sql);
		$row = $result->fetch_assoc();
		
		$totalNumberOfSearches = $row['totalNumberOfSearches'];
		
		$sql = 'SELECT created_on, keywords
		                        FROM '.DB_PREFIX.'searches
		                        ORDER BY created_on DESC limit ' . self::MAKE_STATS_ON_MAX_NUMBER_OF_SEARCHES;
		$result = $db->query($sql);
		
		$stats = '';
		while ($row = $result->fetch_assoc())
			$stats .= '<div>' . $row['created_on'] . ' <strong>' . htmlspecialchars($row['keywords']) . '</strong></div>';
		
		$numberOfSearchesPerDay = array();
		$sql = 'SELECT count(id) AS nr FROM '.DB_PREFIX.'searches WHERE created_on > DATE_SUB(NOW(), INTERVAL 8 DAY) GROUP BY DATE_FORMAT(created_on, "%Y-%m-%d")';
		$result = $db->query($sql);

		while ($row = $result->fetch_assoc())
			$numberOfSearchesPerDay[] = $row['nr'];
		
		$avg = 0;
		$maxNumberOfSearches = 0;
		$numberOfSearches = array_sum($numberOfSearchesPerDay);
		$numberOfDaysWithSearches = count($numberOfSearchesPerDay);
		
		if ($numberOfDaysWithSearches > 0)
		{
			$avg = ceil($numberOfSearches / $numberOfDaysWithSearches);
			$maxNumberOfSearches = max($numberOfSearchesPerDay);
		}	
		
		return array('stats' => $stats, 'count' => $totalNumberOfSearches, 'avg' => $avg, 'max' => $maxNumberOfSearches);
	}
}
?>