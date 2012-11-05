{foreach item=job from=$jobs}

	<div class="row"><!-- Start job /-->
		<div class="span2">
			<span class="label {$job.type_var_name}">{$job.type_name}</span>
		</div>
		<div class="span10">
			<h5><a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a></h5>
			<span>{$job.created_on} - {$translations.homepage.at} {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else}</span>
			<span>{$translations.homepage.in}</span> {$job.location}{/if}
		</div>
					
	</div><!-- End job /-->
{/foreach}
