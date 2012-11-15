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

	$smarty->assign('jobs', $the_jobs);
	$smarty->assign('types', get_types());
	$smarty->assign('country_name', $country['name']);
	$smarty->assign('country_ascii_name', $country_ascii_name);

	$smarty->assign('seo_title', 'Jobs in ' . $country['name']);
	$smarty->assign('seo_desc', '');
	$smarty->assign('seo_keys', '');
	
	$template = 'country-jobs-header.tpl';
?>
