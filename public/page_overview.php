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

	$companies = array();
	$sanitizer = new Sanitizer();
	
	$sql = 'SELECT company, count(id) AS nr
			FROM '.DB_PREFIX.'jobs
			WHERE is_temp = 0 AND is_active = 1
			GROUP BY company
			ORDER BY company ASC';
	
	$comps = $db->QueryArray($sql);
	
	foreach ($comps as $company)
	{
		$nr = $company['nr'];
		$tag_height = get_cloud_tag_height($nr);
		
		$companies[] = array('name' => $company['company'], 
		                     'varname' => $sanitizer->sanitize_title_with_dashes($company['company']), 
		                     'count' => $nr, 
		                     'tag_height' => $tag_height);
	}
	$smarty->assign('companies', $companies);
	$smarty->assign('companies_count', count($comps));

		// get jobs
		$smarty->assign('jobs_count_all', $job->CountJobs());

		if (SIDEBAR_SHOW_WHAT == 'categories')
		{
			$smarty->assign('jobs_count_all_categs', $job->GetJobsCountForAllCategs());
		}
		else
		{
			$numberOfJobsInOtherCountries = $job->GetNumberOfJobsInOtherCountries();
			
			$smarty->assign('jobs_count_in_other_countries', $numberOfJobsInOtherCountries);
			$smarty->assign('hide_other_countries_in_sidebar', $numberOfJobsInOtherCountries < SIDEBAR_ONLY_COUNTRIES_WITH_AT_LEAST_NUMBER_OF_JOBS);
			
			$jobsCountPerCountry = $job->GetJobsCountPerCountry();
			
			// exclude the countries that don't have at least the specified number of jobs 
			foreach ($jobsCountPerCountry as $index => $jobsPerCountry)
			{
				if ($jobsPerCountry['jobs_in_country'] < SIDEBAR_ONLY_COUNTRIES_WITH_AT_LEAST_NUMBER_OF_JOBS)
					unset($jobsCountPerCountry[$index]);
			}
			
			$smarty->assign('jobs_count_per_country', $jobsCountPerCountry);
		}
	

	$template = 'overview.tpl';
?>
