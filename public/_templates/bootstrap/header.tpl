{if $CURRENT_PAGE == 'page-unavailable' || $CURRENT_PAGE == 'job-unavailable'}
	{php}header("HTTP/1.0 404 Not Found");{/php}
{/if}
<!DOCTYPE html>
<html lang="en">
<head>
    <title>{if $seo_title}{$seo_title}{else}{$html_title}{/if}</title>
    <meta name="description" content="{if $seo_desc}{$seo_desc}{else}{$meta_description}{/if}">
    <meta name="keywords" content="{if $seo_keys}{$seo_keys}{else}{$meta_keywords}{/if}">
	<meta name="generator" content="Jobberbase v{$smarty.const.JOBBERBASE_VERSION}">
    <meta charset="utf-8">
	<link rel="shortcut icon" href="{$BASE_URL}favicon.ico" type="image/x-icon">
	{if $CURRENT_PAGE == '' || $CURRENT_PAGE != 'jobs'}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{$BASE_URL}rss/all/">
	{else}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{$BASE_URL}rss/{$current_category}/">
	{/if}
	<!--[if !IE]><script src="{$BASE_URL}js/jquery.history.js" type="text/javascript"></script><![endif]-->
	<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	
	<link href="{$BASE_URL}_templates/{$THEME}/css/bootstrap.css" rel="stylesheet">
	<link href="{$BASE_URL}_templates/{$THEME}/css/custom.css" rel="stylesheet">
	<script type="text/javascript" src="{$BASE_URL}js/jquery-1.7.min.js"></script>
	<script src="{$BASE_URL}js/jquery.form.js" type="text/javascript"></script>
	<script src="{$BASE_URL}js/cmxforms.js" type="text/javascript"></script>
	<script src="{$BASE_URL}js/jquery.metadata.js" type="text/javascript"></script>
	<script src="{$BASE_URL}js/jquery.validate.min.js" type="text/javascript"></script>
	<script src="{$BASE_URL}js/functions.js" type="text/javascript"></script>
	<script type="text/javascript">
		Jobber.I18n = {$translationsJson};
	</script>
	
</head>

<body>
		{if $smarty.session.status neq ''}
			<div id="status">
				{$smarty.session.status}
			</div><!-- #status -->
		{/if}
	<div class="topbar">
      <div class="fill">
        <div class="container">
          <a class="brand" href="{$BASE_URL}"><h1>{$translations.header.name}</h1></a>
          <ul class="nav">
            <li><a href="{$BASE_URL}">Home</a></li>
            <li class="dropdown" data-dropdown="dropdown">
                <a href="#" class="menu">{$translations.footer.column_use}</a>
                <ul class="menu-dropdown">
                {if $navigation.footer1 != ''}
					{section name=tmp loop=$navigation.footer1}
						{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.footer1[tmp].url != 'post')}
							<li><a href="{if $navigation.footer1[tmp].outside != 1}{$BASE_URL}{/if}{$navigation.footer1[tmp].url}/" title="{$navigation.footer1[tmp].title}" >{$navigation.footer1[tmp].name}</a></li>
						{/if}
					{/section}
				{/if}
                </ul>
            </li>
			<li class="dropdown" data-dropdown="dropdown">
                <a href="#" class="menu">{$translations.footer.column_find}</a>
                <ul class="menu-dropdown">
                {if $navigation.footer2 != ''}
					{section name=tmp loop=$navigation.footer2}
						{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.footer2[tmp].url != 'post')}
							<li><a href="{if $navigation.footer2[tmp].outside != 1}{$BASE_URL}{/if}{$navigation.footer2[tmp].url}/" title="{$navigation.footer2[tmp].title}" >{$navigation.footer2[tmp].name}</a><li>
						{/if}
					{/section}
				{/if}
                </ul>
            </li>
			<li class="dropdown" data-dropdown="dropdown">
                <a href="#" class="menu">{$translations.footer.column_misc}</a>
                <ul class="menu-dropdown">
                {if $navigation.footer3 != ''}
					{section name=tmp loop=$navigation.footer3}
						{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.footer3[tmp].url != 'post')}
							<li><a href="{if $navigation.footer3[tmp].outside != 1}{$BASE_URL}{/if}{$navigation.footer3[tmp].url}/" title="{$navigation.footer3[tmp].title}" >{$navigation.footer3[tmp].name}</a></li>
						{/if}
					{/section}
				{/if}
                </ul>
            </li>
          </ul>
		  
		  <ul class="customnav">
		  <li class="dropdown" data-dropdown="dropdown">
                <a href="#" class="menu">Help and Support</a>
                <ul class="menu-dropdown">
                {if $navigation.primary != ''}
					{section name=tmp loop=$navigation.primary}
						{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.primary[tmp].url != 'post')}
							<li><a href="{if $navigation.primary[tmp].outside != 1}{$BASE_URL}{/if}{$navigation.primary[tmp].url}/" title="{$navigation.primary[tmp].title}" >{$navigation.primary[tmp].name}</a></li>
							{assign var=i value=1}
						{/if}
					{/section}
				{/if}
                </ul>
            </li>
		  </ul>
        </div>
      </div>
    </div>
	
	<div class="container">
	<div class="content">
		  <div class="page-header">
			{if $smarty.const.ENABLE_NEW_JOBS}		  
			<div class="coll">
				<a href="{$BASE_URL}post/" class="btn large danger">{$translations.search.submit}</a>
			</div>
			{/if}
			<div class="colr">
				<form method="post" action="{$BASE_URL}search/">
				<fieldset>
					<input class="span12" type="text" name="keywords" placeholder="{$translations.search.example} and Press Enter" />
				</fieldset>	
				</form>
			</div>	
        </div>
