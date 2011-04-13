<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 */
	
	// config
	if(!file_exists('_config/config.php')) 
	{
	   die('[index.php] _config/config.php not found');
	}
	
	require_once '_config/config.php';

	define('BASE_URL', APP_URL);
	
	$translator = new Translator(LANG_CODE);
	$translations = $translator->getTranslations();
	
	$smarty->assign('translator', $translator);
	$smarty->assign('translations', $translations);
	
	// create a JSON string from the translations array, but only for the "js" section
	$smarty->assign('translationsJson', iniSectionsToJSON(array("js" => $translations['js'])));
	
	$flag = 0;
	
	$job = new Job();
	
	$meta_description = '';
	$meta_keywords = '';
	
	if(!isset($_SERVER['HTTP_REFERER'])) 
	{
	   $_SERVER['HTTP_REFERER'] = '';
	}
	
	switch($page)
	{
		// home
		case '':
			require_once 'page_home.php';
			$flag = 1;
			break;
			
		// cities
		case URL_CITIES:
			require_once 'page_cities.php';
			$flag = 1;
			break;
	
		// per category
		case URL_JOBS:
			require_once 'page_jobs.php';
			$flag = 1;
			break;
			
		// per company
		case URL_JOBS_AT_COMPANY:
			require_once 'page_company.php';
			$flag = 1;
			break;
			
		// per city
		case URL_JOBS_IN_CITY:
			require_once 'page_city.php';
			$flag = 1;
			break;
			
		case 'jobs-in-other-cities':
			require_once 'page_other_cities.php';
			$flag = 1;
			break;
			
		// search results
		case 'search':
			require_once 'page_search.php';
			$flag = 1;
			break;
						
		// job post page, with the job's details
		case URL_JOB:
			require_once 'page_job.php';
			$flag = 1;
			break;
	
		case 'send-to-friend':
			require_once 'page_sendtofriend.php';
			$flag = 1;
			break;
			
		case 'apply-online':
			require_once 'page_apply.php';
			$flag = 1;
			break;
		
		case 'report-spam':
			require_once 'page_reportspam.php';
			$flag = 1;
			break;
			
		// create/edit a job post
		case 'post':
			if(!ENABLE_NEW_JOBS) { redirect_to(BASE_URL); exit; }
			require_once 'page_write.php';
			$flag = 1;
			break;
		
		// verify the posted job
		case 'verify':
			if(!ENABLE_NEW_JOBS) { redirect_to(BASE_URL); exit; }
			require_once 'page_verify.php';
			$flag = 1;
			break;
	
		// actually publish the job post
		case 'publish':
			if(!ENABLE_NEW_JOBS) { redirect_to(BASE_URL); exit; }
			require_once 'page_publish.php';
			$flag = 1;
			break;
			
		case 'confirm':
			if(!ENABLE_NEW_JOBS) { redirect_to(BASE_URL); exit; }
			$flag =1;
			$job = new Job($id);
			$job_title = BASE_URL . URL_JOB .'/' . $job->mId . '/' . $job->mUrlTitle . '/';
			$smarty->assign('auth', $job->GetAuth());
			$smarty->assign('job_url', $job_title);
			$smarty->assign('postRequiresModeration', $extra);
			$template = 'publish-confirmation.tpl';
			break;
			
		// deactivate a post
		case 'deactivate':
			require_once 'page_deactivate.php';
			$flag = 1;
			break;
			
		// activate a post
		case 'activate':
			require_once 'page_activate.php';
			$flag = 1;
			break;
			
		case 'rss':
			require_once 'page_rss.php';
			$html_title = 'RSS Feeds for ' . SITE_NAME;
			$flag = 1;
			break;
			
		case 'sitemap':
			$html_title = 'Sitemap';
			$template = 'sitemap.tpl';
			$flag = 1;
			break;
			
		case 'widgets':
			$html_title = 'Widgets - ' . SITE_NAME;
			$template = 'widgets.tpl';
			$flag = 1;
			break;		
		
		// companies
		case URL_COMPANIES:
			require_once 'page_companies.php';
			$flag = 1;
			break;
			
		case 'get-companies':
			require_once 'page_getcompanies.php';
			$flag = 1;
			break;
			
		case 'job-unavailable':
			$html_title = 'Unavailable job / ' . SITE_NAME;
			$template = 'no-job.tpl';
			$flag = 1;
			break;

        case 'sitemap.xml':
            generate_sitemap('xml');
            $flag = 1;
            break;

        case 'sitemap.txt':
            generate_sitemap('txt');
            $flag = 1;
            break;
		
		// 404 etc. error page
		case 'page-unavailable':
			// TO-DO: add suggestion if no trailing slash supplied
			$html_title = 'Page unavailable / ' . SITE_NAME;
			$template = 'error.tpl';
			$flag = 1;
			break;
		
		default: 
			$result = $db->query('
				SELECT 
					* 
				FROM 
					'.DB_PREFIX.'pages 
				WHERE 
					url = "' . $db->real_escape_string($page) . '"
			');
			$pageData = $result->fetch_assoc();
			if (is_array($pageData)) {
				require_once 'page_page.php';
				$html_title = $pageData['page_title'] . ' - ' . SITE_NAME;
				$meta_keywords = $pageData['keywords'];
				$meta_description = $pageData['description'];
				$template = 'page.tpl';
				$flag = 1;
			} else {
				$flag = 0;
			}
			break;
	}
	// if page not found
	if ($flag == 0)
	{
		redirect_to(BASE_URL . 'page-unavailable/', '404');
	}
	
	// get job categories and cities
	$smarty->assign('categories', get_categories());
	$smarty->assign('articles', get_articles());
	$smarty->assign('navigation', get_navigation());
	
	$smarty->assign('THEME', $settings['theme']);
	$smarty->assign('CURRENT_PAGE', $page);
	$smarty->assign('CURRENT_ID', $id);
	$smarty->assign('BASE_URL', BASE_URL);
	$smarty->assign('HTTP_REFERER', $_SERVER['HTTP_REFERER']);

	//Add the dynamic URL defitions to SMARTY
	$smarty->assign('URL_JOB', URL_JOB);
	$smarty->assign('URL_JOBS', URL_JOBS);
	$smarty->assign('URL_CITIES', URL_CITIES);
	$smarty->assign('URL_COMPANIES', URL_COMPANIES);
	$smarty->assign('URL_JOBS_IN_CITY', URL_JOBS_IN_CITY);
	$smarty->assign('URL_JOBS_AT_COMPANY', URL_JOBS_AT_COMPANY);
	
	if (isset($html_title) && $html_title != '')
		$smarty->assign('html_title', $html_title);
	if (isset($meta_description) && $meta_description != '')
		$smarty->assign('meta_description', $meta_description);
	if (isset($meta_keywords) && $meta_keywords != '')
		$smarty->assign('meta_keywords', $meta_keywords);

	if (isset($template) && $template != '')
		$smarty->display($template);
?>