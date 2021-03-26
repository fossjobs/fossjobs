<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="{if $seo_desc}{$seo_desc}{else}{$meta_description}{/if}">
		<meta name="keywords" content="{if $seo_keys}{$seo_keys}{else}{$meta_keywords}{/if}">
		<meta name="generator" content="Jobberbase v{$smarty.const.JOBBERBASE_VERSION}">
		<title>{if $seo_title}{$seo_title}{else}{$html_title}{/if}</title>
		<link rel="shortcut icon" href="{$BASE_URL}favicon.svg" type="image/svg+xml">

		<link rel="stylesheet" href="{$BASE_URL}_templates/{$THEME}/css/bulma.0.9.1.min.css" />
		<link rel="stylesheet" type="text/css" href="{$BASE_URL}_templates/{$THEME}/css/forum.css">
	{if $CURRENT_PAGE == '' || $CURRENT_PAGE != 'jobs'}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{$BASE_URL}rss/all/">
	{else}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="{$BASE_URL}rss/{$current_category}/">
	{/if}
	</head>
	<body>
		<nav class="navbar is-white" aria-label="main">
			<div class="container">
				<div class="navbar-brand" tabindex="-1" aria-hidden="true">
					<a class="navbar-item" href="{$BASE_URL}">
						<img src="{$BASE_URL}logo.svg" alt="" height="28" width="41" >
					</a>
					<a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="topNav">
						<span aria-hidden="true"></span>
						<span aria-hidden="true"></span>
						<span aria-hidden="true"></span>
					</a>
				</div>
				<div id="topNav" class="navbar-menu">
					<div class="navbar-start">
					{if $navigation.primary != ''}
					{section name=tmp loop=$navigation.primary}
						{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.primary[tmp].url != 'post')}
						<a class="navbar-item" href="{$navigation.primary[tmp].url}" title="{$navigation.primary[tmp].title}" >{$navigation.primary[tmp].name}</a>
						{assign var=i value=1}
						{/if}
					{/section}
					{/if}
					</div>
				</div>
				<div class="navbar-end">
					<div class="navbar-item is-expanded">
					<form method="post" action="{$BASE_URL}search/" role="search">
					<fieldset>
						<label for="siteSearch" class="is-hidden">Search</label>
						<input class="input" type="search" name="keywords" id="siteSearch" placeholder="{$translations.search.example} and Press Enter" />
					</fieldset>
					</form>
					</div>
				</div>
			</div>
		</nav>

