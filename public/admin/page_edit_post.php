<?php
/**
 * @author putypuruty
 * 
 * Business logic for editing a post.
 */
	
	//Note: $id is a job ID
	
if ($id != 0)
	{
		$job = new Job($id);
	}
	else
	{
		$job = new Job();
	}
	
	$jobToEdit = $job->GetInfo();
	$smarty->assign_by_ref('job', $jobToEdit);
	
	$smarty->assign('show_preview', false);
	
	if (!empty($_POST))
	{
		// validation
		$errors = array();
		
        if (!isset($_POST['type_id']) || !is_numeric($_POST['type_id']))
        {
            $errors['input_id'] = $translations['jobs']['type_error']; $_POST['type_id'] = 0;
        }
        if ($_POST['company'] == '')
			$errors['company'] = $translations['jobs']['name_error'];
		
		if ($_POST['title'] == '')
			$errors['title'] = $translations['jobs']['title_error'];
		
		if ($_POST['description'] == '')
			$errors['description'] = $translations['jobs']['description_error'];
		
		if ($_POST['poster_email'] == '')
			$errors['poster_email'] = $translations['jobs']['email_error'];
		
		if (!validate_email($_POST['poster_email']))
			$errors['poster_email'] = $translations['jobs']['email_invalid'];
		
		if (isset($_POST['apply_online']) && $_POST['apply_online'] == 'on')
		{
			$_POST['apply_online'] = 1;
		}
		else
		{
			$_POST['apply_online'] = 0;
		}

		$isCountrySelected = false;

		// we didn't receive a country (when the countries combo is disabled)
		if (!isset($_POST['country_id']))
			$country_id = 0;
		else
		{
			$country_id = $_POST['country_id'];
			$isCountrySelected = true;
		}
				
		$jobToEdit['company'] = $_POST['company'];
		$jobToEdit['url'] = $_POST['url'];
		$jobToEdit['title'] = $_POST['title'];
		$jobToEdit['country_id'] = $country_id;
		$jobToEdit['city'] = $_POST['city'];
		$jobToEdit['category_id'] = $_POST['category_id'];
		$jobToEdit['type_id'] = $_POST['type_id'];
		$jobToEdit['description'] = $_POST['description'];
		$jobToEdit['apply'] = '';
		$jobToEdit['poster_email'] = $_POST['poster_email'];
		$jobToEdit['apply_online'] = $_POST['apply_online'];
		$jobToEdit['type_var_name'] = get_type_varname_by_id($_POST['type_id']);
		$jobToEdit['type_id'] = $_POST['type_id'];
		
		$jobToEdit['textiledDescription'] = $textile->TextileThis($_POST['description']);
		
		$is_location_anywhere = $jobToEdit['country_id'] == 0;
		$jobToEdit['is_location_anywhere'] = $is_location_anywhere;
		
		if (!$is_location_anywhere)
		{
			if ($isCountrySelected)
			{
				$country = get_country_by_id($country_id);
				$jobToEdit['country'] = $country['name'];
			}
		}

		// no errors
		if (empty($errors))
		{
			if ($_POST['show_preview'] == 'true')
				$smarty->assign('show_preview', true);
			else
			{
				escape($_POST);	
				
				$data = array('company' => $company,
				          	  'url' => $url,
				              'title' => $title,
				              'country_id' => $country_id,
				              'category_id' => $category_id,
				              'type_id' => $type_id,
				              'description' => $description,
					      'city' => $city,
				              'apply' => '',
				              'poster_email' => $poster_email,
				              'apply_online' => $apply_online);
				
				if ($id != 0)
				{
					$job->Edit($data);
				}
				else
				{
					// a job posted by the admin is active from the beginning
					$data['is_temp'] = 0;
					$data['is_active'] = 1;
					$data['spotlight'] = 0;
					
					$job->Create($data);
				}
				
				$category = get_category_by_id($category_id);
				
				redirect_to(BASE_URL . URL_JOBS . '/' . $category['var_name'] . '/');
				exit;
			}
		}
		else
			$smarty->assign('errors', $errors);
	}
		
	$smarty->assign('categories', get_categories());
	$smarty->assign('types', get_types());
	$smarty->assign('countries', get_countries());
	
	$html_title = $translations['jobs']['title_edit'] . ' / ' . SITE_NAME;
	
	$template = 'edit-post.tpl';
?>
