{include file="header.tpl"}
		
		<div id="content">
			<div id="job-listings"></div><!-- #job-listings -->
			<h3 class="page-heading">{$translations.companies.title}</h3>
			{section name=tmp loop=$companies}
			<span class="company-tag-{$companies[tmp].tag_height}">
				<a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$companies[tmp].varname}/">{$companies[tmp].name} ({$companies[tmp].count})</a>
			</span>
			{/section}
			<br /><br />
			<p>
				{$translations.companies.total}: <strong>{$companies_count}</strong> {$translations.companies.companies}
			</p>
		</div><!-- /content -->

{include file="footer.tpl"}