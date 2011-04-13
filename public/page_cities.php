<?php
/**
 * jobber job board platform
 *
 * @author     Chronos <http://chronoscripts.com> <chronos@chronoscripts.com>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 */
 
	$city_array = get_cities_cloud();
	$smarty->assign('cities_overview', $city_array);
	
	$numberOfJobsInOtherCities = $job->GetNumberOfJobsInOtherCities();
	$smarty->assign('jobs_count_in_other_cities', $numberOfJobsInOtherCities);
	$smarty->assign('jobs_count_in_other_cities_tag_height', get_cloud_tag_height($numberOfJobsInOtherCities));
	
	$totalNumberOfJobs = 0;
	
	foreach ($city_array as $city_job_data)
	{
		$totalNumberOfJobs += $city_job_data['count'];
	}
	
	$totalNumberOfJobs += $numberOfJobsInOtherCities;
	
	$smarty->assign('total_number_of_jobs', $totalNumberOfJobs);
	
	$html_title = $translations['jobscity']['page_title'];
	$template = 'cities.tpl';
?>