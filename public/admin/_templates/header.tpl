<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>{$html_title}</title>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="description" content="{$meta_description}" />
	<meta name="keywords" content="{$meta_keywords}" />
	<link rel="shortcut icon" href="{$BASE_URL}favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="{$BASE_URL_ADMIN}_templates/css/screen.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="{$BASE_URL_ADMIN}_templates/css/jquery.fancybox-1.2.6.css" type="text/css" media="screen" />
 
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.min.js"></script>
 
	<script src="{$BASE_URL_ADMIN}_templates/js/jquery.bgiframe.min.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/jquery.validate.min.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/functions.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/main.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/categories.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/hoverIntent.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/links.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/messages.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/overlay.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/superfish.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/supersubs.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/types.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/jquery.fancybox-1.2.6.pack.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/jquery.easing.1.3.js" type="text/javascript"></script>
	{if $editor}
	<script src="{$BASE_URL_ADMIN}_templates/js/tiny_mce/tiny_mce.js" type="text/javascript"></script>
	<script src="{$BASE_URL_ADMIN}_templates/js/editor.js" type="text/javascript"></script>
	<script type="text/javascript">
	{literal}
	 tinyMCE_GZ.init({
	 plugins : 'style,layer,table,save,advhr,advimage,advlink,media,searchreplace,contextmenu,paste,directionality,nonbreaking,xhtmlxtras',
	 themes : 'advanced',
	 languages : 'en',
	 disk_cache : true,
	 debug : false
	 });
	{/literal}
	</script>
	{/if}
	<script type="text/javascript">
	 Jobber.I18n = {$translationsJson};
	</script>

	<link rel="stylesheet" type="text/css" media="screen" href="{$BASE_URL_ADMIN}_templates/css/superfish.css" /> 
	<link rel="stylesheet" type="text/css" media="screen" href="{$BASE_URL_ADMIN}_templates/css/superfish-navbar.css" />  
	{literal}
	<script type="text/javascript"> 
	 $(document).ready(function(){ 
	 $("ul.sf-menu").superfish({ 
	 animation: {height:'show'},
	 delay:     1500
	 }); 
	 }); 
	</script>
	{/literal}
</head>

<body>
	<div id="wrap">
	<div id="top_nav">
	 <a href="{$BASE_URL}">&larr; Back to site</a>
	 {if $isAuthenticated == 1}
	 <span class="version"><a href="http://www.jobberbase.com/" title="Open source job board software">Jobberbase</a> {$smarty.const.JOBBERBASE_VERSION}</span>
	 {else}

	 {/if}
	</div>
	{if $isAuthenticated == 1}
	 {if $smarty.session.status neq ''}
	 <div id="status">
	 {$smarty.session.status}
	 </div><!-- #status -->
	 {/if}
	{/if}

	 <h1>Jobberbase Administration</h1>

	{if $isAuthenticated == 1}
	 <ul class="sf-menu sf-navbar">
	 <li><a {if $CURRENT_PAGE == ''}class="selected"{/if} href="{$BASE_URL_ADMIN}">Home</a></li>
	 <li><a {if $CURRENT_PAGE == 'edit-post'}class="selected"{/if} href="{$BASE_URL_ADMIN}edit-post/">Post a job</a></li>
	 <li><a {if $CURRENT_PAGE == 'pages'}class="selected"{/if} href="{$BASE_URL_ADMIN}pages/">Pages</a></li>
	 <li><a {if $CURRENT_PAGE == 'categories'}class="selected"{/if}{if $CURRENT_PAGE == 'jobs'}class="selected"{/if} href="{$BASE_URL_ADMIN}categories/">Categories</a>
	 <ul>
	 {section name=tmp loop=$categories}
	 <li id="{$categories[tmp].var_name}"><a href="{$BASE_URL_ADMIN}{$URL_JOBS}/{$categories[tmp].var_name}/">{$categories[tmp].name}</a></li>
	 {/section}
	    	  </ul>
	 </li>
	 <li><a {if $CURRENT_PAGE == 'stats'}class="selected"{/if} href="{$BASE_URL_ADMIN}stats/">Stats</a></li>
	 <li><a {if $CURRENT_PAGE == 'countries'}class="selected"{/if} href="{$BASE_URL_ADMIN}countries/list/">Countries</a></li>
	 <li><a {if $CURRENT_PAGE == 'types'}class="selected"{/if} href="{$BASE_URL_ADMIN}types/">Job types</a></li>
	 <li><a {if $CURRENT_PAGE == 'links'}class="selected"{/if} href="{$BASE_URL_ADMIN}links/">Links</a>
	 <ul>
	 <li><a href="{$BASE_URL_ADMIN}links/primary/">Primary Menu</a></li>
	 <li><a href="{$BASE_URL_ADMIN}links/secondary/">Secondary Menu</a></li>
	 <li><a href="{$BASE_URL_ADMIN}links/footer1/">Footer Column 1</a></li>
	 <li><a href="{$BASE_URL_ADMIN}links/footer2/">Footer Column 2</a></li>
	 <li><a href="{$BASE_URL_ADMIN}links/footer3/">Footer Column 3</a></li>
	 </ul>
	 </li>
	 <li><a {if $CURRENT_PAGE == 'settings'}class="selected"{/if} href="{$BASE_URL_ADMIN}settings/">Settings</a>
	 <ul>
	 {section name=index loop=$settings_categories}
	 <li><a href="{$BASE_URL_ADMIN}settings/{$settings_categories[index].var_name}/">{$settings_categories[index].name}</a></li>
	 {/section}
	 </ul>
	 </li>
	 <li><a {if $CURRENT_PAGE == 'password'}class="selected"{/if} href="{$BASE_URL_ADMIN}password/">Change password</a></li>
	 <li class="right bold"><a href="{$BASE_URL_ADMIN}logout/">Logout</a></li>
	 </ul>
	
	<a style="float: right" class="iframe" href="http://www.evertsemeijn.nl/help/administration/{if $CURRENT_PAGE == ''}home/{/if}{if $CURRENT_PAGE == 'edit-post'}post-a-job/{/if}{if $CURRENT_PAGE == 'pages'}pages/{/if}{if $CURRENT_PAGE == 'categories'}categories/{/if}{if $CURRENT_PAGE == 'jobs'}categories/{/if}{if $CURRENT_PAGE == 'stats'}stats/{/if}{if $CURRENT_PAGE == 'countries'}countries/{/if}{if $CURRENT_PAGE == 'types'}job-types/{/if}{if $CURRENT_PAGE == 'links'}links/{/if}{if $CURRENT_PAGE == 'settings'}settings/{/if}{if $CURRENT_PAGE == 'password'}change-password/{/if}"><img src="{$BASE_URL_ADMIN}_templates/img/help.png" /></a>
	
	{/if}
