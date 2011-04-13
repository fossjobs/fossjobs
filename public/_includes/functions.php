<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * Misc functions
 */

function add_single_quotes($arg) 
{
	/* single quote and escape single quotes and backslashes */ 
	return "'" . addcslashes($arg, "'\\") . "'"; 
}

function get_cities_cloud()
{
	global $db;
	$city_array = array();
 
	$sql = 	'SELECT c.id, c.name, c.ascii_name, COUNT(*) AS nr
			 FROM '.DB_PREFIX.'cities c 
			 INNER JOIN '.DB_PREFIX.'jobs j ON (j.city_id = c.id ) 
			 WHERE j.is_active = 1 
			 GROUP BY c.name';
 
	$cities = $db->QueryArray($sql);
 
	foreach ($cities as $city)
	{
		$numberOfJobs = $city['nr'];
 
		$city_array[] = array('name' => $city['name'],
		                     'varname' => $city['ascii_name'],
		                     'count' => $numberOfJobs,
		                     'tag_height' => get_cloud_tag_height($numberOfJobs));
	}
 
	return $city_array;
}

function get_cloud_tag_height($numberOfItems)
{
	if ($numberOfItems < 2)
	{
		$tag_height = 1;
	}
	else if ($numberOfItems >= 2 && $numberOfItems < 3)
	{
		$tag_height = 2;
	}
	else if ($numberOfItems >= 3 && $numberOfItems < 4)
	{
		$tag_height = 3;
	}
	else if ($numberOfItems >= 4 && $numberOfItems < 5)
	{
		$tag_height = 4;
	}
	else if ($numberOfItems >= 5 && $numberOfItems < 6)
	{
		$tag_height = 5;
	}
	else if ($numberOfItems >= 6)
	{
		$tag_height = 6;
	}
	
	return $tag_height;
}

function get_categories()
{
    global $db;
    $categories = array();
    $sql = 'SELECT *
                   FROM '.DB_PREFIX.'categories
                   ORDER BY category_order ASC';
    $result = $db->query($sql);
    while ($row = $result->fetch_assoc())
    {
        $categories[] = array('id' => $row['id'], 'name' => $row['name'], 'var_name' => $row['var_name'], 'title' => $row['title'], 'description' => $row['description'], 'keywords' => $row['keywords']);
    }
    return $categories;
}

function get_articles()
{
	global $db;
	$articles = array();
	$sql = 'SELECT id, title, page_title, url 
	               FROM '.DB_PREFIX.'pages
	               ORDER BY title ASC';
	$result = $db->query($sql);
	while ($row = $result->fetch_assoc())
	{
		$articles[$row['url']] = $row;
	}
	return $articles;
}

function get_navigation($menu = false)
{
	global $db;
	
	$conditions = '';
	
	if (isset($menu) && ($menu == 'primary' || $menu == 'secondary' || $menu == 'footer1' || $menu == 'footer2' || $menu == 'footer3'))
		$conditions = ' WHERE menu = \''.$menu.'\'';
	
	$navigation = array();

	$sql = 'SELECT id, url, name, title, menu
				FROM '.DB_PREFIX.'links
				' . $conditions . '
				ORDER BY link_order ASC';

	$result = $db->query($sql);
	while ($row = $result->fetch_assoc())
	{
		$url_check = substr($row['url'], 0, 4);
		if ($url_check == 'http' || $url_check == 'www.') $outside = 1; else $outside = 0; 
		
		$navigation[$row['menu']][] = array(
								'id' => $row['id'],
								'url' => $row['url'],
								'name' => $row['name'],
								'title' => $row['title'],
								'menu' => $row['menu'],
								'outside' => $outside);
	}
	return $navigation;
}

function get_cities()
{
	global $db;
	
	$cities = array();
	
	$sql = 'SELECT id, name, ascii_name
	               FROM '.DB_PREFIX.'cities
	               ORDER BY name ASC';
	
	$result = $db->query($sql);
	
	while ($row = $result->fetch_assoc())
	{
		$cities[] = array('id' => $row['id'], 'name' => $row['name'], 'ascii_name' => $row['ascii_name']);
	}
	
	return $cities;
}

function get_categ_id_by_varname($var_name)
{
	global $db;
	$sql = 'SELECT id FROM '.DB_PREFIX.'categories WHERE var_name = "' . $var_name . '"';
	$result = $db->query($sql);
	$row = $result->fetch_assoc();
	return $row['id'];
}

function get_categ_name_by_varname($var_name)
{
    global $db;
    $sql = 'SELECT name FROM '.DB_PREFIX.'categories WHERE var_name = "' . $var_name . '"';
    $result = $db->query($sql);
    $row = $result->fetch_assoc();
    return $row['name'];
}

function get_city_id_by_asciiname($ascii_name)
{
	global $db;
	
	$city = null;
	
	$sql = 'SELECT id, name
	               FROM '.DB_PREFIX.'cities
	               WHERE ascii_name = "' . $ascii_name . '"';

	$result = $db->query($sql);
	$row = $result->fetch_assoc();
	
	if ($row)
		$city = array('id' => $row['id'], 'name' => $row['name']);
		
	return $city;
}

/**
* Converts the multidimensional array that results after calling parse_ini_file (filePath, processSections = true)
* to a JSON string.
* The resulting JSON string will look something like this:
* {"sectionOne": {"messageKeyOne": "messageTextOne", "messageKeyTwo": "messageTextTwo"}, "sectionTwo": {....},....}
*
* @author putypuruty
*/
function iniSectionsToJSON($iniSections)
{
	$translationsJson = "{";
	$sectionsCount = 0;
		
	foreach ($iniSections as $section => $sectionMessages)
	{
		$translationsJson = $translationsJson . "\"" . $section . "\": {";
		$sectionMessagesCount = 0;
		
		foreach ($sectionMessages as $messageKey => $messageText)
		{
			$translationsJson = $translationsJson . "\"".$messageKey . "\":\"" . preg_replace("/\r?\n/", "\\n", addslashes($messageText)) . "\"";
			
			$sectionMessagesCount++;
			
			if ($sectionMessagesCount < count($sectionMessages))
				$translationsJson .= ",";
		}
		$translationsJson .= "}";
		
		$sectionsCount++;

		if ($sectionsCount < count($iniSections))
			$translationsJson .= ",";
	}
	
	$translationsJson = $translationsJson."}";
	
	return $translationsJson;
}

/**
 * Returns the city with the specified ID or null
 * if the city was not found.
 *
 * @param $cityID
 * @return 
 */
function get_city_by_id($cityID)
{
	global $db;
	
	$city = null;
	
	$sql = 'SELECT id, name
	               FROM '.DB_PREFIX.'cities
	               WHERE id = ' . $cityID;
	$result = $db->query($sql);
	
	$row = $result->fetch_assoc();
	
	if ($row)
		$city = array('id' => $row['id'], 'name' => $row['name']);
		
	return $city;  
}

function get_types()
{
	global $db;
	$sql = 'SELECT id, name, var_name 
		FROM '.DB_PREFIX.'types ';
	$result = $db->query($sql);
	$types = array();
	while($row = $result->fetch_assoc())
	{
		$types[] = array('id' => $row['id'], 'name' => $row['name'], 'var_name' => $row['var_name']);
	}
	return $types;
}

function get_type_id_by_varname($var_name)
{
	global $db;
	$sql = 'SELECT id FROM '.DB_PREFIX.'types WHERE 
		var_name = "'.$var_name.'"';
	$result = $db->query($sql);
	$row = $result->fetch_assoc();
	
	if ($row)
		return $row['id'];
	return false;
}

function get_type_varname_by_id($id)
{
	global $db;
	$sql = 'SELECT var_name FROM '.DB_PREFIX.'types WHERE 
		id = '.$id;
	$result = $db->query($sql);
	$row = $result->fetch_assoc();
	
	if ($row)
		return $row['var_name'];
	return false;
}

function get_category_by_var_name($var_name)
{
	global $db;
	$category = null;
	
	$sql = 'SELECT *
	               FROM '.DB_PREFIX.'categories
	               WHERE var_name = "' . $var_name . '"';
	
	$result = $db->query($sql);
	$row = $result->fetch_assoc();
	
	if ($row)
		$category = build_category_from_result_set_row($row);
	
	return $category;
}

function get_category_by_id($id)
{
	global $db;
	$category = null;
	
	$sql = 'SELECT *
	               FROM '.DB_PREFIX.'categories
	               WHERE id = ' . $id;
	
	$result = $db->query($sql);
	$row = $result->fetch_assoc();
	
	if ($row)
		$category = build_category_from_result_set_row($row);
	
	return $category;
}

function build_category_from_result_set_row($row)
{
	return array('id' => $row['id'], 'name' => $row['name'], 'var_name' => $row['var_name'], 
			     'title' => $row['title'], 'description' => $row['description'],
			     'keywords' => $row['keywords'], 'category_order' => $row['category_order']);
}

function generate_sitemap($type)
{
    global $db;
    $sanitizer = new Sanitizer;

    // Get all links
    $result = $db->query('SELECT url FROM '.DB_PREFIX.'links');
    while ($row = $result->fetch_assoc()) if (!strstr($row['url'], 'http://')) $sitemap[BASE_URL . $row['url'] . '/'] = 1;
    
    // Get all custom pages
    $result = $db->query('SELECT url FROM '.DB_PREFIX.'pages');
    while ($row = $result->fetch_assoc()) $sitemap[BASE_URL . $row['url'] . '/'] = 1; 
    
    // Get all categories
    $categories = get_categories();
    $i = 0; while($i < count($categories)) { $sitemap[BASE_URL . URL_JOBS . '/' . $categories[$i]['var_name'] . '/'] = 1; $i++; }
    
    // Get all cities
    $cities = get_cities();
    $i = 0; while($i < count($cities)) { $sitemap[BASE_URL . URL_JOBS_IN_CITY . '/' . $cities[$i]['ascii_name'] . '/'] = 1; $i++; }

    // Get all companies
    $result = $db->query('SELECT company FROM '.DB_PREFIX.'jobs WHERE is_temp = 0 AND is_active = 1 GROUP BY company');
    while ($row = $result->fetch_assoc()) $sitemap[BASE_URL . URL_JOBS_AT_COMPANY . '/' . $sanitizer->sanitize_title_with_dashes($row['company']) . '/'] = 1;
        
    // Get all active Jobs
    $result = $db->query('SELECT id, title, company FROM '.DB_PREFIX.'jobs WHERE is_active = 1 AND is_temp = 0');
    while ($row = $result->fetch_assoc()) $sitemap[BASE_URL . URL_JOB . '/' . $row['id'] . '/' . $sanitizer->sanitize_title_with_dashes($row['title'])] = 1;
    
    // Generate output
    if ($type == 'xml')
    {
        header('Content-Type: text/xml; charset="utf-8"');
        
        echo '<?xml version="1.0" encoding="UTF-8"?>';
        echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
        
        foreach ($sitemap as $url => $value)
        {
            echo '<url><loc>'.$url.'</loc></url>';
        }
        echo '</urlset>';
    }
    else
    {
        foreach ($sitemap as $url => $value)
        {
            echo $url.'<br />';
        }        
    }

}
?>