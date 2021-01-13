<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta name="description" content="{if $seo_desc}{$seo_desc}{else}{$meta_description}{/if}">
    	<meta name="keywords" content="{if $seo_keys}{$seo_keys}{else}{$meta_keywords}{/if}">
		<meta name="generator" content="Jobberbase v{$smarty.const.JOBBERBASE_VERSION}">
		<title>{if $seo_title}{$seo_title}{else}{$html_title}{/if}</title>
		<link rel="shortcut icon" href="{$BASE_URL}favicon.ico" type="image/x-icon">
<!--
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
-->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
		<!-- Bulma Version 0.9.0-->
		<link rel="stylesheet" href="{$BASE_URL}_templates/{$THEME}/css/bulma.0.9.1.min.css" />
		<link rel="stylesheet" type="text/css" href="{$BASE_URL}_templates/{$THEME}/css/forum.css">
	{if $CURRENT_PAGE == '' || $CURRENT_PAGE != 'jobs'}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{$BASE_URL}rss/all/">
	{else}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{$BASE_URL}rss/{$current_category}/">
	{/if}
		</head>
	<body>
		<nav class="navbar is-white topNav" role="navigation" aria-label="dropdown navigation">
			<div class="container">
				<div class="navbar-brand">
					<a class="navbar-item" href="{$BASE_URL}">
						<img src="{$BASE_URL}logo.svg" height="28"> 
					</a>
					<div class="navbar-burger burger" data-target="topNav">
						<span></span>
						<span></span>
						<span></span>
					</div>
				</div>
				<div id="topNav" class="navbar-menu">
					{if $navigation.primary != ''}
					{section name=tmp loop=$navigation.primary}
						{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.primary[tmp].url != 'post')}
						<a class="navbar-item" href="{$navigation.primary[tmp].url}" title="{$navigation.primary[tmp].title}" >{$navigation.primary[tmp].name}</a>
						{assign var=i value=1}
						{/if}
					{/section}
					{/if}		
				</div>
				<div class="navbar-end">
					<div class="navbar-item">
					<form method="post" action="{$BASE_URL}search/">
					<fieldset>
						<input class="input" type="search" name="keywords" placeholder="{$translations.search.example} and Press Enter" />
					</fieldset>	
					</form>			
					</div>
				</div>
			</div>
		</nav>
