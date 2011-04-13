<?php

	// Check if a valid menu name is given
	if ($id == 'primary' || $id == 'secondary' || $id == 'footer1' || $id == 'footer2' || $id == 'footer3') $menu = $id;
	
	// If _POST is set, do the requested action
	if ($_SERVER['REQUEST_METHOD'] == 'POST' && key_exists('action', $_POST)) {
		switch ($_POST['action']) {
			case 'saveOrder':
				$links = explode(',', $_POST['order']);
				foreach ($links as $key => $link) {$sql = 'UPDATE '.DB_PREFIX.'links SET link_order = '.$key.' WHERE id = '.$link; $db->query($sql);}
				break;
			case 'newLink':
				if ($id == 'primary' || $id == 'secondary' || $id == 'footer1' || $id == 'footer2' || $id == 'footer3')	$menu_id = $id; else $menu_id = 'primary'; 
				$result = $db->query('SELECT link_order FROM '.DB_PREFIX.'links ORDER BY link_order DESC LIMIT 1');
				$last = $result->fetch_assoc();
				$db->query('INSERT INTO '.DB_PREFIX.'links VALUES (NULL, "http://", "New Link", "" , "'.$menu_id.'",' . (intval($last['link_order']) + 1) . ')');
				$result = $db->query('SELECT id	FROM '.DB_PREFIX.'links ORDER BY link_order DESC LIMIT 1');
				$last = $result->fetch_assoc();
				echo $last['id'];
				break;
			case 'deleteLink':
				$result = $db->query('DELETE FROM '.DB_PREFIX.'links WHERE id = ' . intval($_POST['link']) . ' LIMIT 1');
				break;
			case 'saveLink':
				$result = $db -> query('UPDATE '.DB_PREFIX.'links SET url = "' . $_POST['url'] . '", name = "' . $_POST['name'] . '", title = "' . $_POST['title'] . '" WHERE id = ' . intval($_POST['link']) );
	             break;
		}
		exit();
	}
		
	// If a valid menu is given, load it's settings
	if (isset($menu) && $menu != '0')
	{
		$links = get_navigation($menu);	$js[] = 'links';
		if ($menu == 'primary') $menu_name = 'Primary Menu';
		elseif ($menu == 'secondary') $menu_name = 'Secondary Menu';
		elseif ($menu == 'footer1') $menu_name = 'Footer Column 1';
		elseif ($menu == 'footer2') $menu_name = 'Footer Column 2';
		elseif ($menu == 'footer3') $menu_name = 'Footer Column 3';
		
		$smarty->assign('menu_id', $menu);
		$smarty->assign('menu_name', $menu_name);
		$smarty->assign('links', $links);
	}
	
	$smarty->assign('current_category', 'links');
	$template = 'links.tpl';
?>