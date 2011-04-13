{include file="header.tpl"}
		
		<div id="content">
			<div id="job-listings">
				{if $jobs}
				<div id="sort-by-type">
				{$translations.category.display_only}&nbsp;
					{section name=job_type loop=$types}
						<a href="{$BASE_URL}jobs-in-other-cities/{$types[job_type].var_name}/" title="{$current_category} {$types[job_type].name}"><img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$types[job_type].var_name}.png" alt="{$types[job_type].name}" /></a>
					{/section}
				</div><!-- #sort-by-type -->
				{/if}
				<h2>
					{$translations.jobscity.jobs_in_other_cities}
				</h2>
				{if $jobs}
					{include file="jobs-list.tpl"}
				{else}
					<div id="no-ads">
						{$translations.jobscity.no_jobs_in_other_cities}
						{if $smarty.const.ENABLE_NEW_JOBS}
							<br /><a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a>
						{/if}
					</div><!-- #no-ads -->
				{/if}
				
			</div><!-- #job-listings -->
		</div><!-- #content -->

{include file="footer.tpl"}