<?php
	$category_var_name = $id;
	$category = get_category_by_var_name($category_var_name);
	
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

	$smarty->assign("pages", $paginator->pages_link);
	
	$smarty->assign('jobs', $the_jobs);
	$smarty->assign('jobs_count', $jobsCount);
	$smarty->assign('types', get_types());
	$smarty->assign('current_category', $category_var_name);
	$smarty->assign('current_category_name', $category['name']);

	$smarty->assign('seo_title', $category['title']);
	$smarty->assign('seo_desc', $category['description']);
	$smarty->assign('seo_keys', $category['keywords']);

	$template = 'category.tpl';
?>