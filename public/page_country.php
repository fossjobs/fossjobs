<?php
	$type_id = get_type_id_by_varname($extra);
	
	$country_ascii_name = urldecode($id);
	
	$country = get_country_id_by_asciiname($country_ascii_name);
	
	if ($country)
	{
		$country_id = $country['id'];
		
		$jobCount =  $job->GetJobsCountForCountry($country_id, $type_id);
		$smarty->assign('jobs_count', $jobCount);
	}
	else
	{
		redirect_to(BASE_URL . 'page-unavailable/');
		exit;
	}
	
	$paginatorLink = BASE_URL . URL_JOBS_IN_COUNTRY . "/$country_ascii_name";
	
	if (isset($extra))
		$paginatorLink .= "/$extra";
		
	$paginator = new Paginator($jobCount, JOBS_PER_PAGE, @$_REQUEST['p']);
	$paginator->setLink($paginatorLink);
	$paginator->paginate();
	
	$firstLimit = $paginator->getFirstLimit();
	$lastLimit = $paginator->getLastLimit();
	
	$the_jobs = array();
	$the_jobs = $job->GetPaginatedJobsForCountry($country_id, $firstLimit, JOBS_PER_PAGE, $type_id);
	$smarty->assign("pages",$paginator->pages_link);

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

		
	$smarty->assign('jobs', $the_jobs);
	$smarty->assign('types', get_types());
	$smarty->assign('country_name', $country['name']);
	$smarty->assign('country_ascii_name', $country_ascii_name);

	$smarty->assign('seo_title', 'Jobs in ' . $country['name']);
	$smarty->assign('seo_desc', '');
	$smarty->assign('seo_keys', '');
	
	$template = 'country-jobs-header.tpl';
?>
