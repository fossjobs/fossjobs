<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST' && key_exists('action', $_POST)) {
	switch ($_POST['action']) {
		case 'saveOrder':
			$categories = explode(',', $_POST['order']);
			$values = '';
			foreach ($categories as $key => $category) {
				if (!empty($values)) {
					$values .= ',';
				}
				$values .= '(' . $category . ', ' . $key . ')';
			}
			$db->query('
				INSERT INTO
					'.DB_PREFIX.'categories
					(id, category_order) 
				VALUES
					' . $values . ' 
				ON DUPLICATE KEY UPDATE 
					category_order = VALUES(category_order)
			');
			break;
		case 'newCategory':
			$result = $db->query('
				SELECT 
					category_order 
				FROM 
					'.DB_PREFIX.'categories 
				ORDER BY 
					category_order DESC 
				LIMIT 1
			');
			$last = $result->fetch_assoc();
            $db->query('
                INSERT INTO 
                    '.DB_PREFIX.'categories 
                VALUES (
                    NULL,
                    \'enter a name\',
                    \'custom url\',
                    \'SEO Title\',
                    \'SEO Description\',
                    \'SEO Keywords\',
                    ' . (intval($last['category_order']) + 1) . '
                )
            ');
			$result = $db->query('
				SELECT 
					id 
				FROM 
					'.DB_PREFIX.'categories 
				ORDER BY 
					category_order DESC 
				LIMIT 1
			');
			$last = $result->fetch_assoc();
			echo $last['id'];
			break;
		case 'deleteCategory':
			$result = $db -> query('
				SELECT 
					COUNT(id) as total 
				FROM 
					'.DB_PREFIX.'jobs 
				WHERE 
					category_id = ' . intval($_POST['category']) . '
			');
			$row = $result->fetch_assoc();
			if ($row['total'] > 0) {
				echo 'You can not delete this category because there are jobs in this category!';
			} else {
				$result = $db->query('
					DELETE FROM 
						'.DB_PREFIX.'categories 
					WHERE id = ' . intval($_POST['category']) . '
					LIMIT 1
				');
			}
			break;
		case 'getCategoriesList':
			$categories = get_categories();
			$html = '';
			foreach ($categories as $category) {
				$html .= '<li id="' . $category['var_name'] . '"><a title="'.$category['var_name'].'" href="'.BASE_URL . URL_JOBS . '/' . $category['var_name'] . '/"><span>' . $category['name'] . '</span><span class="cnr">&nbsp;</span></a></li>';
			}
			echo $html;
			break;
		case 'saveCategory':
			$result = $db -> query('
                UPDATE  
                    '.DB_PREFIX.'categories 
                SET 
                    var_name = "' . $_POST['url'] . '",
                    name = "' . $_POST['name'] . '",
                    title = "' . $_POST['title'] . '",
                    description = "' . $_POST['description'] . '",
                    keywords = "' . $_POST['keywords'] . '" 
                WHERE 
                    id = ' . intval($_POST['category']) . '
            ');
             break;
	}
	exit();
}
	
$template = 'categories.tpl';
$js[] = 'categories';

$smarty->assign('current_category', 'categories');