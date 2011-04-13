<?php
	$companies = array();
	$sanitizer = new Sanitizer();
	
	$sql = 'SELECT company, count(id) AS nr
			FROM '.DB_PREFIX.'jobs
			WHERE is_temp = 0 AND is_active = 1
			GROUP BY company
			ORDER BY company ASC';
	
	$comps = $db->QueryArray($sql);
	
	foreach ($comps as $company)
	{
		$nr = $company['nr'];
		$tag_height = get_cloud_tag_height($nr);
		
		$companies[] = array('name' => $company['company'], 
		                     'varname' => $sanitizer->sanitize_title_with_dashes($company['company']), 
		                     'count' => $nr, 
		                     'tag_height' => $tag_height);
	}
	$smarty->assign('companies', $companies);
	$smarty->assign('companies_count', count($comps));
	$html_title = $translations['companies']['page_title'];
	$template = 'companies.tpl';
?>