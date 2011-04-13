<?php

	// Check if a valid category id is given
	$settings_category_id = $jobber_settings->GetSettingsCategoryIdByVarname($id);
	
	// Get setting names from a category OR show available categories
	if (isset($settings_category_id) && is_numeric($settings_category_id))
	{
		$settings_form = $jobber_settings->GetSettingsByCategory($settings_category_id, true);
		$smarty->assign('category_name', $jobber_settings->GetSettingsCategoryNameById($settings_category_id));
		$smarty->assign('settings_form', $settings_form);
	}
	else $smarty->assign('settings_categories', $jobber_settings->GetSettingsCategories());
	
	// Process a form (if given) to save the settings
	if (!empty($_POST))
	{
		escape($_POST);
		
		$fv = new FormValidator();
		$setting_array = array();
		
		// Looping all given fields and values
		foreach ($settings_form as $setting)
		{
			// If field value is an array, convert it to a string for DB storage
			if (is_array($GLOBALS[$setting['name']]))
			{
				$a = 0; $new_value = '';
				while($a < count($GLOBALS[$setting['name']]))
				{
					if ($GLOBALS[$setting['name']][$a] != '_hidden' && $new_value == '') $new_value .= $GLOBALS[$setting['name']][$a];
					elseif ($GLOBALS[$setting['name']][$a] != '_hidden' ) $new_value .= '|' . $GLOBALS[$setting['name']][$a];
					$a++;
				}
				$GLOBALS[$setting['name']] = $new_value;
			}
			
			// Validate the fields if needed
			if (!empty($setting['validation']))
			{
				$a = 0; while($a < count($setting['validation']))
				{
					if ($setting['validation'][$a] == 'not_empty')
						$fv->isEmpty($setting['name']);
					if ($setting['validation'][$a] == 'is_number' || $setting['data_type'][$a] == 'integer')
						$fv->isNumber($setting['name']);
					if ($setting['validation'][$a] == 'is_url_string')
						$fv->isUrlString($setting['name']);
					if ($setting['validation'][$a] == 'is_email')
						$fv->isEmailAddress($setting['name']);
					$a++;
				}
			}
			if ($setting['data_type'] == 'integer') $fv->isNumber($setting['name']);

			$setting_array[] = array('name'=> $setting['name'], 'value' => $GLOBALS[$setting['name']]);
		}
		
		if ($fv->isError())
		{
			// Give the fields their changed input, so the user doesn't need to type it in again
			foreach ($settings_form as $setting)
			{
				if ($setting['input_type'] == 'checkbox')
				{
					$new_value = explode('|', $GLOBALS[$setting['name']]);
					$settings_form[$setting['name']]['value'] = $new_value;
				}
				else
				{
					$settings_form[$setting['name']]['value'] = $GLOBALS[$setting['name']];
				}
			}
			
			// Assign error list to SMARTY and load template
			$errors = $fv->getErrorList();
			$smarty->assign('errors', $errors);
			$smarty->assign('settings_form', $settings_form);
			$template = 'settings.tpl';
		}
		else
		{
			$jobber_settings->UpdateSettings($setting_array);
			redirect_to(BASE_URL.'settings/'. $id . '/');
		}
	} 
	
	$smarty->assign('current_category', 'settings');
	$template = 'settings.tpl';
	
?>