<?php
	$the_jobs = array();
	
	$jobCount = $job->getInactiveJobCount();
	
	$paginator = new Paginator($jobCount, JOBS_PER_PAGE, @$_REQUEST['p']);
	$paginator->setLink(BASE_URL.'home');
	$paginator->paginate();
	
	$firstLimit = $paginator->getFirstLimit();
	$lastLimit = $paginator->getLastLimit();
	
	$the_jobs = $job->GetInactiveJobs($firstLimit, JOBS_PER_PAGE);
	
	$smarty->assign("pages",$paginator->pages_link);

	$smarty->assign('jobs', $the_jobs);
	
	$template = 'index.tpl';
?>