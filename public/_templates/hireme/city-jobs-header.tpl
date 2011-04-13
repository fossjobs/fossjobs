{include file="header.tpl"}
		
		<div id="content">
			<div id="job-listings">
				{if $jobs}
				<div id="sort-by-type">
				{$translations.category.display_only}&nbsp; 
					{section name=tmp loop=$types}
						<!--Doesn't seem to be type-support for cities yet-->
						<a href="{$BASE_URL}{$URL_JOBS_IN_CITY}/{$city_ascii_name}/{$types[tmp].var_name}/" title="{$current_category} {$types[tmp].name}"><img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$types[tmp].var_name}.png" alt="{$types[tmp].name}" /></a>
					{/section}
				</div><!-- #sort-by-type -->
				{/if}
				<h2>
					{$translations.jobscity.jobs_in} {$city_name}
				</h2>
				{if $jobs}
					{include file="jobs-list.tpl"}
				{else}
					<div id="no-ads">
						{$translations.jobscity.no_jobs_in} <strong>{$city_name}</strong>.
						{if $smarty.const.ENABLE_NEW_JOBS}
							<br /><a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a>
						{/if}
					</div><!-- #no-ads -->
				{/if}
			</div><!-- #job-listings -->
		</div><!-- #content -->

{include file="footer.tpl"}