{include file="header.tpl"}
		
<section class="container">
<div class="columns">
	<div class="column is-9">
		<div class="box content">

		<h4>{$translations.companies.title}</h4>
		
		{section name=tmp loop=$companies}
		<span class="company-tag-{$companies[tmp].tag_height}">
			<a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$companies[tmp].varname}/">{$companies[tmp].name} ({$companies[tmp].count})</a>
		</span>
		{/section}
		<br /><br />
		<p>
			{$translations.companies.total}: <strong>{$companies_count}</strong> {$translations.companies.companies}
		</p>

		</div>
	</div>
	{include file="sidebar.tpl"}
</div>
</section>

{include file="footer.tpl"}
