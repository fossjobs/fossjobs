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
		$numberOfJobsInOtherCities = $job->GetNumberOfJobsInOtherCities();
		
		$smarty->assign('jobs_count_in_other_cities', $numberOfJobsInOtherCities);
		$smarty->assign('hide_other_cities_in_sidebar', $numberOfJobsInOtherCities < SIDEBAR_ONLY_CITIES_WITH_AT_LEAST_NUMBER_OF_JOBS);
		
		$jobsCountPerCity = $job->GetJobsCountPerCity();
		
		// exclude the cities that don't have at least the specified number of jobs 
		foreach ($jobsCountPerCity as $index => $jobsPerCity)
		{
			if ($jobsPerCity['jobs_in_city'] < SIDEBAR_ONLY_CITIES_WITH_AT_LEAST_NUMBER_OF_JOBS)
				unset($jobsCountPerCity[$index]);
		}
		
		$smarty->assign('jobs_count_per_city', $jobsCountPerCity);
	}

	$smarty->assign('most_applied_to_jobs', $job->GetMostAppliedToJobs(NUMBER_OF_MOST_APPLIED_TO_JOBS_TO_GET));

	$smarty->assign('latest_jobs', $job->GetJobs(0, 0, NUMBER_OF_LATEST_JOBS_TO_GET, 0, 0));

	$smarty->assign('spotlight_jobs', $job->GetJobs(0, 0, NUMBER_OF_SPOTLIGHT_JOBS_TO_GET, 1, 0, 0, 0, 0, 1));

	$smarty->assign('current_category', 'home');

	$smarty->assign('seo_title', htmlspecialchars($settings['html_title']));
	$smarty->assign('seo_desc', htmlspecialchars($settings['meta_description']));
	$smarty->assign('seo_keys', htmlspecialchars($settings['meta_keywords']));
	
	$template = 'index.tpl';
?>