<?php
	$sanitizer = new Sanitizer();
	
	$sql = 'SELECT DISTINCT company FROM '.DB_PREFIX.'jobs';
	$comps = $db->QueryArray($sql);
	foreach ($comps as $comp)
	{
		if ($sanitizer->sanitize_title_with_dashes($comp['company']) == $id)
		{
			$company = $comp['company'];
			break;
		}
	}
	$smarty->assign('jobs', $job->ApiGetJobsByCompany($company, false, false));
	$smarty->assign('current_company', $company);

	$html_title = $translations['companies']['are_you_looking'] . ' ' . $company . '?';
	$meta_description = $translations['companies']['meta_part1'] . ' ' . $company . '! ' . $translations['companies']['meta_part2'];
	$template = 'company.tpl';
?>