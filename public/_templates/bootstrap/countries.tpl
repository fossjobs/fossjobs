{include file="header.tpl"}

		<div class="row jobmain">
			{include file="sidebar.tpl"}
			
			<div class="span12">
			<!-- #job-listings -->
			<h6>{$translations.jobscountry.title}</h6>
			{section name=tmp loop=$countries_overview}
			<span class="company-tag-{$countries_overview[tmp].tag_height}">
				<a href="{$BASE_URL}{$URL_JOBS_IN_COUNTRY}/{$countries_overview[tmp].varname}">{$countries_overview[tmp].name} ({$countries_overview[tmp].count})</a>
			</span>
			{/section}
			{if $jobs_count_in_other_countries > 0}
				<span class="company-tag-{$jobs_count_in_other_countries_tag_height}">
				<a href="{$BASE_URL}jobs-worldwide/">{$translations.jobscountry.other_countries} ({$jobs_count_in_other_countries})</a>
			</span>
			{/if}
			<br /><br />
			<p>
			{$translations.jobscountry.total}: <strong>{$total_number_of_jobs}</strong> {$translations.jobscountry.jobs}
			</p>
			</div>

		</div><!-- #content -->
 
{include file="footer.tpl"}
