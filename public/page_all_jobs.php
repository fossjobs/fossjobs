<?php
	$type_var_name = '';
	$type_id = 0;
	
	if ($id)
	{
		$type_var_name = $id;
	}
	
	if ($type_var_name != '')
	{
		$type_id = get_type_id_by_varname($type_var_name);
	}
	
	if ($type_id)
	{
		$jobsCount =  $job->CountJobsOfType($type_id);
	}
	else
	{
		$jobsCount =  $job->CountJobs();
	}
	
	$smarty->assign('jobs_count', $jobsCount);
	
	$paginatorLink = BASE_URL . URL_JOBS ;
	
	if (!empty($type_var_name))
		$paginatorLink .= "/$type_var_name";
		
	$paginator = new Paginator($jobsCount, JOBS_PER_PAGE, @$_REQUEST['p']);
	$paginator->setLink($paginatorLink);
	$paginator->paginate();
	
	$firstLimit = $paginator->getFirstLimit();
	$lastLimit = $paginator->getLastLimit();
	
	$the_jobs = $job->GetPaginatedJobs($firstLimit, JOBS_PER_PAGE, $type_id);
	$smarty->assign("pages", $paginator->pages_link);

	$smarty->assign('jobs', $the_jobs);
	$smarty->assign('types', get_types());

	$smarty->assign('seo_title', 'All jobs');
	$smarty->assign('seo_desc', '');
	$smarty->assign('seo_keys', '');
	
	$template = 'all-jobs-header.tpl';
?>