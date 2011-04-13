<?php
	$category_var_name = $id;
	$category = get_category_by_var_name($category_var_name);
	
	if ($category)
	{
		$category_id = $category['id'];
		
		$type_var_name = $extra;
		$type_id = get_type_id_by_varname($type_var_name);
		
		$jobsCount = 0;
		
		if ($type_id)
		{
			$jobsCount =  $job->CountJobs($id, $type_id);
		}
		else
		{
			$jobsCount =  $job->CountJobs($id);
		}
		
		$paginatorLink = BASE_URL . URL_JOBS . "/$category_var_name";
	
		if (isset($type_var_name))
			$paginatorLink .= "/$type_var_name";
			
		$paginator = new Paginator($jobsCount, JOBS_PER_PAGE, @$_REQUEST['p']);
		$paginator->setLink($paginatorLink);
		$paginator->paginate();
		
		$firstLimit = $paginator->getFirstLimit();
		$lastLimit = $paginator->getLastLimit();
		
		$the_jobs = $job->GetPaginatedJobsForCategory($category_id, $firstLimit, JOBS_PER_PAGE, $type_id);
		
		$statisticalData = array();
		$spamReportStatisticalData = array();
		
		if (count($the_jobs))
		{
			$jobIDs = array();
			
			foreach ($the_jobs as $index => $aJob)
				$jobIDs[] = $aJob['id'];
			
			$statisticalData = $job->GetApplicationsStatistics($jobIDs);
			$spamReportStatisticalData = $job->GetSpamReportStatistics($jobIDs);
		}

		$smarty->assign("pages", $paginator->pages_link);
		
		$smarty->assign('statisticalData', $statisticalData);
		$smarty->assign('spamReportStatisticalData', $spamReportStatisticalData);
		$smarty->assign('jobs', $the_jobs);
		$smarty->assign('jobs_count', $jobsCount);
		$smarty->assign('types', get_types());
		$smarty->assign('current_category', $category_var_name);
		$smarty->assign('current_category_name', $category['name']);
	
		$template = 'category.tpl';
	}
	else
	{
		redirect_to(BASE_URL . 'page-unavailable/');
		exit;
	}

	$template = 'category.tpl';
?>