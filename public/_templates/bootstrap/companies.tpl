{include file="header.tpl"}

		<div class="row jobmain">
			{include file="sidebar.tpl"}
			
			<div class="span12">
			<!-- #job-listings -->
			<h6>{$translations.companies.title}</h6>
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

		</div><!-- #content -->

{include file="footer.tpl"}