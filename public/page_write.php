<?php

	$captcha_enabled = ENABLE_RECAPTCHA && ENABLE_CAPTCHA_ON_POST_PAGE;

	$smarty->assign('ENABLE_RECAPTCHA', $captcha_enabled);
	
	if ($captcha_enabled)
	{
		$smarty->assign('the_captcha', recaptcha_get_html(CAPTCHA_PUBLIC_KEY));
	}
	
	$later_edit = false;
	if ($id != 0)
	{
		$j = new Job($id);
	}
	
	// if auth code used, check it and allow editing
	if ($id != 0 && $extra != '' && $extra == $j->GetAuth())
	{
		
		$later_edit = true;
		$_SESSION['later_edit'] = $extra;
	}
	else
	{
		if ($id != 0 && isset($_SESSION['later_edit']) && $_SESSION['later_edit'] == $j->GetAuth() && $j->GetAuth() != '')
		{
			$later_edit = true;
		}
	}

	// security: prevent later editing, by forced redirection
	if (!$later_edit && $id != 0)
	{
		$j = new Job($id);
		if ($j->GetTempStatus() != 1 || $j->GetActiveStatus() != 0)
		{
			redirect_to(BASE_URL . URL_JOB .'/' . $id . '/');
			exit;
		}
	}
	
	// this branch executes when returning to edit a post
	if (($_SERVER['HTTP_REFERER'] == BASE_URL . 'verify/' . $id . '/' && $id != 0) || $later_edit)
	{
		$_SESSION['referer'] = BASE_URL . 'post/';
		$job = new Job($id);
		$jobs = $job->GetInfo();

		$jobs['description'] = $textile->noTextile($jobs['description']);
		
		if (strstr($jobs['url'], 'http://'))
		{
			$jobs['url'] = substr($jobs['url'], 7, strlen($jobs['url']));
		}
		$smarty->assign('job', $jobs);
	}

	// this branch executes after first writing a post and hitting the submit button
	if (!empty($_POST['action']) && $_POST['action'] == 'publish')
	{
		escape($_POST);
		$errors = array();
		
		$_SESSION['user_ip'] = $_SERVER['REMOTE_ADDR'];
		$_SESSION['referer'] = BASE_URL . 'post/';
		
		// validation
		if ($captcha_enabled)
		{
			$resp = recaptcha_check_answer(CAPTCHA_PRIVATE_KEY,
			$_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"],
			$_POST["recaptcha_response_field"]);
			if (!$resp->is_valid) $errors['captcha'] = $translations['captcha']['captcha_error'];
		}

        if (!isset($type_id) || !is_numeric($type_id))
        {
            $errors['input_id'] = $translations['jobs']['type_error'];
        }
        
        if ($company == '')
		{
			$errors['company'] = $translations['jobs']['name_error'];
		}
		if ($title == '')
		{
			$errors['title'] = $translations['jobs']['title_error'];
		}
		if ($description == '')
		{
			$errors['description'] = $translations['jobs']['description_error'];
		}
		if ($poster_email == '')
		{
			$errors['poster_email'] = $translations['jobs']['email_error'];
		}
		if (!validate_email($poster_email))
		{
			$errors['poster_email'] = $translations['jobs']['email_invalid'];
		}
		
		if (isset($apply_online) && $apply_online == 'on')
		{
			$apply_online = 1;
		}
		else
		{
			$apply_online = 0;
		}

		// no errors, go to review page
		if (empty($errors))
		{
			if (!strstr($url, 'http://'))
			{
				$url = 'http://' . $url;
			}
			if (!isset($city_id))
			{
				$city_id = 0;
			}
			else
			{
				// if a city is selected, we must clear the 'other' location
				$location_outside_ro_where = '';
			}
			
			$data = array('company' => $company,
			              'url' => $url,
			              'title' => $title,
			              'city_id' => $city_id,
			              'category_id' => $category_id,
			              'type_id' => $type_id,
			              'description' => $description,
			  			  'location_outside_ro_where' => $location_outside_ro_where,
			  			  'is_temp' => 1,
			  			  'is_active' => 0,
			              'apply' => '',
			              'poster_email' => $poster_email,
			              'apply_online' => $apply_online,
			              'spotlight' => 0);
			
			$id = $job->Create($data);
			
			redirect_to(BASE_URL . 'verify/' . $id . '/');
			exit;
		}
		// if errors exist, go back and edit the post
		else
		{
			$smarty->assign('errors', $errors);
		}
	}
	else if (!empty($_POST['action']) && $_POST['action'] == 'edit' /*&& $_SERVER['REMOTE_ADDR'] == $_SESSION['user_ip']*/)
	{
		escape($_POST);
		$errors = array();
		
		$_SESSION['referer'] = BASE_URL . 'post/';
		
		// validation
		if ($captcha_enabled)
		{
			$resp = recaptcha_check_answer(CAPTCHA_PRIVATE_KEY,
			$_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"],
			$_POST["recaptcha_response_field"]);
			if (!$resp->is_valid) $errors['captcha'] = $translations['captcha']['captcha_error'];
		}
        if (!isset($type_id) || !is_numeric($type_id))
        {
            $errors['input_id'] = $translations['jobs']['type_error'];
        }
		if ($company == '')
		{
			$errors['company'] = $translations['jobs']['company_error'];
		}
		if ($title == '')
		{
			$errors['title'] = $translations['jobs']['job_title_error'];
		}
		if ($description == '')
		{
			$errors['description'] = $translations['jobs']['job_description_error'];
		}
		if ($poster_email == '')
		{
			$errors['poster_email'] = $translations['jobs']['job_email_error'];
		}
		
		if (isset($apply_online) && $apply_online == 'on')
		{
			$apply_online = 1;
		}
		else
		{
			$apply_online = 0;
		}
		
		// no errors, go to review page
		if (empty($errors))
		{
			$job = new Job($job_id);
			
			if (!strstr($url, 'http://'))
			{
				$url = 'http://' . $url;
			}
			
			if (!isset($city_id))
			{
				$city_id = 0;
			}
			else
			{
				// if a city is selected, we must clear the 'other' location
				$location_outside_ro_where = '';
			}

			$data = array('company' => $company,
			              'url' => $url,
			              'title' => $title,
			              'city_id' => $city_id,
			              'category_id' => $category_id,
			              'type_id' => $type_id,
			              'description' => $description,
			              'location_outside_ro_where' => $location_outside_ro_where,
			              'apply' => '',
			              'poster_email' => $poster_email,
			              'apply_online' => $apply_online);

			$job->Edit($data);
			//where is set $auth ?
			if (!empty($auth))
			{ 
				$add = $auth . '/';
			}
			else
			{
				$add = '';
			}
			redirect_to(BASE_URL . 'verify/' . $job_id . '/' . $add);
			exit;
		}
		// if errors exist, go back and edit the post
		else
		{
			$smarty->assign('errors', $errors);
		}
	}
	
	// check referer and set the job category, if exists
	if (strstr($_SERVER['HTTP_REFERER'], 'jobs'))
	{
		$tmp = explode('/', $_SERVER['HTTP_REFERER']);
		$count = count($tmp);
		$categ = $tmp[$count - 2];
		if ($categ != '')
		{
			$smarty->assign('default_categ_id', get_categ_id_by_varname($categ));
		}
	}
	
	$smarty->assign('categories', get_categories());
	$smarty->assign('types', get_types());
	$smarty->assign('cities', get_cities());
	
	if ($later_edit)
	{
		$html_title = $translations['jobs']['title_edit'] . ' / ' . SITE_NAME;
	}
	else
	{
		$html_title = $translations['jobs']['title_new'] . ' / ' . SITE_NAME;
	}
	
	if (isset($apply_online))
	{
		$smarty->assign('is_apply', $apply_online);
	}
	$template = 'publish-write.tpl';
?>