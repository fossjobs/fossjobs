<?php
/**
 * General settings
 *
 */

// jobberBase version
define('JOBBERBASE_VERSION', '1.9');

// Global settings definitions
define('SITE_NAME', $settings['site_name']);
define('THEME', $settings['theme']);
define('NOTIFY_EMAIL', $settings['notify_email']);
define('ADMIN_EMAIL', $settings['admin_email']);
define('MAX_CV_SIZE', $settings['max_cv_size']);
define('FILE_UPLOAD_DIR', $settings['file_upload_dir']);
define('MINUTES_BETWEEN_APPLY_TO_JOBS_FROM_SAME_IP', $settings['apply_delay']);
define('OLD_JOB_NOTIFY', $settings['old_job_notify']);
define('ENABLE_NEW_JOBS', $settings['enable_new_jobs']);
define('JOBS_PER_PAGE', $settings['jobs_per_page']);
define('SIDEBAR_SHOW_WHAT', $settings['sidebar_show_what']);
define('SIDEBAR_ONLY_CITIES_WITH_AT_LEAST_NUMBER_OF_JOBS', $settings['sidebar_only_cities_with_at_least_number_of_jobs']);
define('DATE_FORMAT', $settings['date_format']);
define('DATE_TIME_FORMAT', $settings['date_time_format']);
define('ENABLE_NEW_POST_MODERATION', $settings['enable_new_post_moderation']);
define('URL_JOB', $settings['url_job']);
define('URL_JOBS', $settings['url_jobs']);
define('URL_CITIES', $settings['url_cities']);
define('URL_COMPANIES', $settings['url_companies']);
define('URL_JOBS_IN_CITY', $settings['url_jobs_in_city']);
define('URL_JOBS_AT_COMPANY', $settings['url_jobs_at_company']);
define('SEARCH_METHOD', $settings['search_method']);
define('SEARCH_RESULTS_PER_PAGE', $settings['jobs_per_search']);
define('SEARCH_AMOUNT_PAGES', '8'); //Max. pages to display (must be an even number!)
define('ENABLE_RECAPTCHA', $settings['enable_recaptcha']);
define('CAPTCHA_PUBLIC_KEY', $settings['captcha_public_key']);
define('CAPTCHA_PRIVATE_KEY', $settings['captcha_private_key']);
define('REPORT_POST_AGAIN_AFTER', $settings['report_post_after']);
define('REPORT_POST_NOTIFY_ON', $settings['post_notify_on']);
define('ENABLE_CAPTCHA_ON_POST_PAGE', $settings['captcha_enable_on_post_page']);
define('ENABLE_CAPTCHA_ON_APPLY_PAGE', $settings['captcha_enable_on_apply_page']);
define('ENABLE_CAPTCHA_ON_CONTACT_PAGE', $settings['captcha_enable_on_contact_page']);
// default language code, useful if you with to quickly switch between translation files later
define('LANG_CODE', 'en');
?>