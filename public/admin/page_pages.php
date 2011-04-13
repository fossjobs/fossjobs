<?php

	$smarty->assign('current_category', 'pages');
	
	$result = $db->query('
		SELECT 
			url, title, page_title 
		FROM 
			'.DB_PREFIX.'pages 
		ORDER BY 
			title ASC
	');
	$pages = array();
	while ($row = $result->fetch_assoc())
	{
		$pages[] = $row;
	}
	$smarty->assign('pages', $pages);
	
	$isPage = false;
	if (key_exists(1,$_app_info['params'])) {
		if (key_exists(2,$_app_info['params'])) {
			$result = $db->query('
				SELECT 
					* 
				FROM 
					'.DB_PREFIX.'pages 
				WHERE 
					url = \'' . $db->real_escape_string(strip_tags($_app_info['params'][2])) . '\'
			');
			$row = $result->fetch_assoc();
			if (!empty($row)) {
				$isPage = true;
				$smarty->assign('current_page', $row);
			}
		}
		if ($_app_info['params'][1] == 'delete') {
			$db->query('
				DELETE FROM 
					'.DB_PREFIX.'pages 
				WHERE 
					`id` = ' . $row['id'] . '
			');
			header('Location: ' . BASE_URL . 'pages/');
			exit();
		}
		$defaults = array();
		$errors = array();
		if ($_SERVER['REQUEST_METHOD'] == 'POST') {
			$reserved = array(
				'post',
				'rss',
				'companies',
				'search',
				'admin'
			);
			$categories = get_categories();
			foreach ($categories as $category) {
				$reserved[] = $category['var_name'];
			}
			$defaults = $_POST;
			foreach ($defaults as $key => $value) {
				$defaults[$key] = trim(stripcslashes($value));
			}
			$url = $defaults['page_url'];
			if (empty($url)) {
				$errors['page_url'] = 'Please fill in the URL';
			} elseif(preg_match('/([^a-z0-9\-_]+?)/i', $url)) {
				$errors['page_url'] = 'The URL must contain only alphanumerical characters, dashed and underscores';
			} else {
				$result = $db->query('
					SELECT 
						* 
					FROM 
						'.DB_PREFIX.'pages 
					WHERE 
						url = \'' . $db->real_escape_string($url) . '\' ' .
						( $isPage ? '
						and 
						id != ' . $row['id'] : '' 
						) . '
				');
				$isDuplicate = $result->fetch_assoc();
				if (!empty($isDuplicate) ||  in_array($url, $reserved)) {
					$errors['page_url'] = 'The URL is already in use. Please select another URL';
				}
			}
			
			if (empty($defaults['page_title'])) {
				$errors['page_title'] = 'Please fill in the title';
			}
			
			if (count($errors) == 0) {
				$db->query('
					REPLACE INTO
						'.DB_PREFIX.'pages 
					VALUES
						(
							' . ($isPage ? $row['id'] : 'NULL') . ',
							\'' . $db->real_escape_string($url) . '\',
							\'' . $db->real_escape_string($defaults['page_page_title']) . '\',
							\'' . $db->real_escape_string($defaults['page_keywords']) . '\',
							\'' . $db->real_escape_string($defaults['page_description']) . '\',
							\'' . $db->real_escape_string($defaults['page_title']) . '\',
							\'' . $db->real_escape_string($defaults['page_content']) . '\',
							\'' . (empty($defaults['page_has_form']) ? '0' : '1') . '\',
							\'' . $db->real_escape_string($defaults['page_form_message']) . '\'
						)
				');
				header('Location: ' . BASE_URL . 'pages/');
				exit();
			}
		} else if ($isPage) {
			$defaults = array(
				'page_url' => $row['url'],
				'page_page_title' => $row['page_title'],
				'page_keywords' => $row['keywords'],
				'page_description' => $row['description'],
				'page_title' => $row['title'],
				'page_content' => $row['content'],
				'page_has_form' => $row['has_form'],
				'page_form_message' => $row['form_message']
			);
		}
		$smarty->assign('defaults', $defaults);
		$smarty->assign('errors', $errors);
		$html_title = $isPage ? 'Editing page ' . $row['title'] . ' / ' : '';
		$html_title .= SITE_NAME;
		$smarty->assign('editor', true);
		$template = 'page_edit.tpl';
		$js[] = 'editor';
	} else {
		$smarty->assign('list_pages', true);
		$html_title = 'Pages / ' . SITE_NAME;
		$template = 'pages.tpl';
	}
		
?>