<?php
	if ($id != '' && !is_numeric($id))
	{
		$feed = new Feed($id);
		if ($feed->mCategoryId != '')
		{
			$feed->Display();
			exit;
		}
		else
		{
			redirect_to(BASE_URL);
		}
	}
	else
	{
	
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

		$template = 'rss.tpl';
	}
?>