<?php
	define('NUMBER_OF_MOST_APPLIED_TO_JOBS_TO_GET', $settings['most_applied_jobs']);
	define('NUMBER_OF_LATEST_JOBS_TO_GET', $settings['latest_jobs']);
	define('NUMBER_OF_SPOTLIGHT_JOBS_TO_GET', $settings['spotlight_jobs']);

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

	$smarty->assign('latest_jobs', $job->GetJobs(0, 0, NUMBER_OF_LATEST_JOBS_TO_GET, 0, 0));

	$smarty->assign('current_category', 'home');

	$smarty->assign('seo_title', htmlspecialchars($settings['html_title']));
	$smarty->assign('seo_desc', htmlspecialchars($settings['meta_description']));
	$smarty->assign('seo_keys', htmlspecialchars($settings['meta_keywords']));
	
	$template = 'index.tpl';
?>
