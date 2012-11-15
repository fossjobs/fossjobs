<?php
/**
 * jobber job board platform
 *
 * @author     Chronos <http://chronoscripts.com> <chronos@chronoscripts.com>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 */
 
	$country_array = get_countries_cloud();
	$smarty->assign('countries_overview', $country_array);
	
	$numberOfJobsInOtherCountries = $job->GetNumberOfJobsInOtherCountries();
	$smarty->assign('jobs_count_in_other_countries', $numberOfJobsInOtherCountries);
	$smarty->assign('jobs_count_in_other_countries_tag_height', get_cloud_tag_height($numberOfJobsInOtherCountries));
	
	$totalNumberOfJobs = 0;
	
	foreach ($country_array as $country_job_data)
	{
		$totalNumberOfJobs += $country_job_data['count'];
	}
	
	$totalNumberOfJobs += $numberOfJobsInOtherCountries;
	
	$smarty->assign('total_number_of_jobs', $totalNumberOfJobs);
	
	$html_title = $translations['jobscountry']['page_title'];
	$template = 'countries.tpl';
?>
