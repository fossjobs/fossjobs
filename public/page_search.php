<?php
	if (isset($_GET['p'])) $start_page = $_GET['p'];
	else $start_page = 1;
 
	if ($id != '')
	{
		$tmp = explode('|', $id);
 
		if (isset($tmp[1])) $url_query = trim($tmp[1]);
		else $url_query = $id;
 
		$id = urldecode($id);
	}
	 
	if (strstr($id, '%7C'))
	{
		$id = str_replace('%7C', '|', $id);
	}
	
	if (key_exists('keywords', $_POST)) {
		$requestKeywords = str_replace('"', '', urldecode($_POST['keywords']));
		$url_query = trim($_POST['keywords']);
	}

	if ($id != '' && !strstr($id, '|'))
	{
		$keywords = $db->real_escape_string(trim($id));
	}
	else
	{
		if (!empty($requestKeywords) && $requestKeywords != $translations['search']['default'])
		{
			$keywords = $db->real_escape_string(trim($requestKeywords));
		}
		else if (strstr($id, '|'))
		{
			$tmp = explode('|', $id);
			$categ = trim($tmp[0]);
			$keywords = trim($tmp[1]);
			$keywords = str_replace('"', '', urldecode($keywords));
			// clicked on a city on the map
			if (isset($tmp[2]) && $tmp[2] == 'map')
			{
				$city = get_city_id_by_asciiname($keywords);
				$keywords = $city['name'];
			}
		}
		else
		{
			redirect_to(BASE_URL);
			exit;
		}
	}
	
	// record search keywords
	$_SESSION['search_keywords'] = $keywords;
	
	$is_home = false;

	if ($keywords == '' || $keywords == ' ')
	{
		if ($categ == '')
		{
			$smarty->assign('no_categ', 1);
		}
		else if ($categ == 'home')
		{
			$is_home = true;
			$smarty->assign('is_home', 1);
		}
		$smarty->assign('jobs', $job->GetJobs(0, $categ, 0, 0, 0));
	}
	else
	{
		$keywords = trim($keywords);
		$smarty->assign('jobs', $job->Search($keywords, $url_query, $start_page));
	}
	// if user hit enter after entering a search query, we know this causes a 
	// synchronous HTTP redirect, so apply a different template
	if ($is_home)
	{
		$template = 'home.tpl';
	}
	if (!empty($requestKeywords))
	{
		// save recorded keywords, if available
		if ($_SESSION['search_keywords'])
		{
			$search = new SearchKeywords($_SESSION['search_keywords']);
			$search->Save();
			unset($_SESSION['search_keywords']);
		}
		$smarty->assign('keywords', stripslashes(htmlentities($requestKeywords, ENT_QUOTES, 'UTF-8')));
		$template = 'search.tpl';
	}
	else if ($id != '' && !strstr($id, '|'))
	{
		$smarty->assign('keywords', stripslashes(htmlentities($id, ENT_QUOTES, 'UTF-8')));
		$template = 'search.tpl';
	}
	else
	{
		$smarty->assign('keywords', stripslashes($keywords));
		$template = 'posts-loop.tpl';
	}
	
	if (isset($_SESSION['search_pagination']))
	{
		$smarty->assign('pages', $_SESSION['search_pagination']);
	}
?>