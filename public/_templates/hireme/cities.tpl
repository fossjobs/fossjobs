{include file="header.tpl"}

		<div id="content">
			<!-- #job-listings -->
			<h3 class="page-heading">{$translations.jobscity.title}</h3>
			{section name=tmp loop=$cities_overview}
			<span class="company-tag-{$cities_overview[tmp].tag_height}">
				<a href="{$BASE_URL}{$URL_JOBS_IN_CITY}/{$cities_overview[tmp].varname}">{$cities_overview[tmp].name} ({$cities_overview[tmp].count})</a>
			</span>
			{/section}
			{if $jobs_count_in_other_cities > 0}
				<span class="company-tag-{$jobs_count_in_other_cities_tag_height}">
				<a href="{$BASE_URL}jobs-in-other-cities/">{$translations.jobscity.other_cities} ({$jobs_count_in_other_cities})</a>
			</span>
			{/if}
			<br /><br />
			<p>
			{$translations.jobscity.total}: <strong>{$total_number_of_jobs}</strong> {$translations.jobscity.jobs}
			</p>
		</div>
		<!-- /content -->
 
{include file="footer.tpl"}