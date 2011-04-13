<!-- Jobs from the same company -->
{if count($compjobs) > 1}
<h2>{$translations.jobs.recent_jobs} <a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$jobsat}/">{$job.company}</a></h2>
<ul class="joblisting">
	{foreach item=compjob from=$compjobs}
		
		{if $compjob.id != $job.id }
			<li>
				<a href="{$BASE_URL}{$URL_JOB}/{$compjob.id}/{$compjob.url_title}/" title="{$compjob.title}">
					<span class="jobtype">
						<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$compjob.type_var_name}.png" alt="{$compjob.type_name}" />
					</span>
					<span class="date">{$compjob.created_on|date_format:"%d %b"}</span>
					<span class="jobtitle">{$compjob.title}</span><br />
					<span class="company_name">
						{$compjob.company}, <br />
						{if $compjob.is_location_anywhere}{$translations.jobs.location_anywhere}{else}{$compjob.location}{/if}
					</span>
				</a>
			</li>
		{/if}
	{/foreach}
</ul>
<br />
{/if}
<!-- Jobs from the same company -->