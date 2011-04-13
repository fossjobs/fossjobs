<?php
	$uri = '';
	
	if ($id)
	{
		$uri = $id;
	}
	
	$allJobsRequested = false;
	$jobsPerCategoryRequested = false;
	
	if ($uri == '')
	{
		$allJobsRequested = true;
	}
	else
	{
		$category = get_category_by_var_name($uri);
		
		if ($category)
		{
			$jobsPerCategoryRequested = true;
		}
		else
		{
			$type_id = get_type_id_by_varname($uri);
			
			if ($type_id)
			{
				$allJobsRequested = true;
			}
		}
	}
	
	if ($allJobsRequested)
	{
		require_once 'page_all_jobs.php';
	}
	elseif ($jobsPerCategoryRequested)
	{
		require_once 'page_category.php';
	}
	else
	{
		redirect_to(BASE_URL . 'page-unavailable/');
		exit;
	}
?>