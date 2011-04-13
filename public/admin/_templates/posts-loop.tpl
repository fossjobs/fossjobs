{if $jobs}

<div class="list">

{foreach item=job from=$jobs name=tmp}
	<div id="item{$job.id}" class="row {cycle values='odd,even'}">
		<div class="icons">
			<a href="{$BASE_URL_ADMIN}edit-post/{$job.id}/" title="Edit this job"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="edit" /></a>
			{if $job.is_spotlight == 0}
				<a id="activateSpotlight{$job.id}" href="javascript:void(0);" onclick="Jobber.SpotlightActivate('{$BASE_URL_ADMIN}activate-spotlight/', {$job.id});" title="Turn spotlight on"><img src="{$BASE_URL_ADMIN}_templates/img/star_off.png" alt="activate" /></a>
			{else}
				<a id="deactivateSpotlight{$job.id}" href="javascript:void(0);" onclick="Jobber.SpotlightDeactivate('{$BASE_URL_ADMIN}deactivate-spotlight/', {$job.id});" title="Turn spotlight off"><img src="{$BASE_URL_ADMIN}_templates/img/star_on.png" alt="deactivate" /></a>
			{/if}&nbsp;
			{if $job.is_active == 0}
				<a id="activateLink{$job.id}" href="javascript:void(0);" onclick="Jobber.Activate('{$BASE_URL_ADMIN}activate/', {$job.id}, {if $CURRENT_PAGE == ''}1{else}0{/if});" title="Active this job"><img src="{$BASE_URL_ADMIN}_templates/img/switch_off.png" alt="activate" /></a>
			{else}
				<a id="deactivateLink{$job.id}" href="javascript:void(0);" onclick="Jobber.Deactivate('{$BASE_URL_ADMIN}deactivate/', {$job.id});" title="Deactive this job"><img src="{$BASE_URL_ADMIN}_templates/img/switch.png" alt="deactivate" /></a>
			{/if}&nbsp;
				<a href="javascript:void(0);" onclick="Jobber.Delete('{$BASE_URL_ADMIN}delete/', {$job.id});" title="Delete this job"><img src="{$BASE_URL_ADMIN}_templates/img/bin.png" alt="delete" /></a>
		</div>
		<div class="time">{$job.created_on}</div>

		<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
		<a href="{$BASE_URL_ADMIN}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a> <span class="light">at</span> {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else} <span class="light">in</span> {$job.location}{/if}
		<div>viewed {$job.views_count} times{if $statisticalData[$job.id]}, {$statisticalData[$job.id].numberOfApplications} applicants, last application on {$statisticalData[$job.id].lastApplicationOn}{/if}{if $spamReportStatisticalData[$job.id]},<span class="spam"> reported as spam {$spamReportStatisticalData[$job.id].numberOfSpamReports} times, last time on {$spamReportStatisticalData[$job.id].lastSpamReportOn}</span>{/if}</div>
	</div>
{/foreach}
</div>

<div class="pagination">{$pages}</div>

{else}
	<div id="no-ads">
		No jobs, yet.
	</div>
{/if}