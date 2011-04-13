<!-- Jobs from the same company -->
{if count($compjobs) > 1}
<strong>{$translations.jobs.recent_jobs} <a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$jobsat}/">{$job.company}</a></strong><br />
{foreach item=compjob from=$compjobs}
{if $compjob.id != $job.id }
	<div class="{cycle values='row,row-alt'}">
		<span class="row-info">
			<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$compjob.type_var_name}.png" alt="{$compjob.type_name}" />
			<a href="{$BASE_URL}{$URL_JOB}/{$compjob.id}/{$compjob.url_title}/" title="{$compjob.title}">{$compjob.title}</a> <span class="la">{$translations.homepage.at}</span> {$compjob.company}{if $compjob.is_location_anywhere}, {$translations.jobs.location_anywhere}{else} <span class="la">{$translations.homepage.in}</span> {$compjob.location}{/if}
		</span>
		<span class="time-posted"><img src="{$BASE_URL}_templates/{$THEME}/img/clock.gif" alt="" /> {$compjob.created_on}</span>			
	</div>
{/if}
{/foreach}
<br />
{/if}
<!-- Jobs from the same company -->