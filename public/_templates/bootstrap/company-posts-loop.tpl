<!-- Jobs from the same company -->
{if count($compjobs) > 1}
				<h6>{$translations.jobs.recent_jobs} <small><a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$jobsat}/">{$job.company}</a></small></h6>
				{foreach item=compjob from=$compjobs}
				{if $compjob.id != $job.id }
				<div class="row"><!-- Start job /-->
					<div class="span2">
						<span class="label {$job.type_var_name}">{$compjob.type_name}</span>
					</div>
					<div class="span10">
						<h5><a href="{$BASE_URL}{$URL_JOB}/{$compjob.id}/{$compjob.url_title}/" title="{$compjob.title}">{$compjob.title}</a></h5>
						<span>{$translations.homepage.at}</span> {$compjob.company}{if $compjob.is_location_anywhere}, {$translations.jobs.location_anywhere}{else} <span>{$translations.homepage.in}</span> {$compjob.location}{/if}
					</div>
					
				</div><!-- End job /-->
			{/if}
{/foreach}
<br />
{/if}
<!-- Jobs from the same company -->
