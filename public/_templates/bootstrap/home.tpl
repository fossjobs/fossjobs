		<div class="span12">
		{if $spotlight_jobs}
			<div class="spotlight-jobs zebra-striped"><!-- Spotlight Jobs /-->
				<h6>{$translations.homepage.spotlight_jobs}</h6>
				{foreach item=job from=$spotlight_jobs}
				<div class="row"><!-- Start job /-->
					<div class="span2">
						<span class="label {$job.type_var_name}">{$job.type_name}</span>
					</div>
					<div class="span10">
						<h5><a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a></h5>
						<span class="spanuser">{$translations.homepage.at} {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else}</span>
						<span class="spanuser">{$translations.homepage.in} {$job.location}{/if}</span>
					</div>
					
				</div><!-- End job /-->
				{/foreach}
			</div><!-- End Spotlight Jobs /-->
		{/if}
		
		{if $latest_jobs}
			<div class="recent-jobs zebra-striped"><!-- Recent Jobs /-->
				<h6>{$translations.homepage.recent_jobs} <small><a href="{$BASE_URL}{$URL_JOBS}/">{$translations.homepage.view_all_jobs}</a></small></h6>
				{foreach item=job from=$latest_jobs}
				<div class="row"><!-- Start job /-->
					<div class="span2">
						<span class="label {$job.type_var_name}">{$job.type_name}</span>
					</div>
					<div class="span10">
						<h5><a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a></h5>
						<span>{$job.created_on} - {$translations.homepage.at} {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else}</span>
						<span>{$translations.homepage.in} {$job.location}{/if}</span>
					</div>
				</div><!-- End job /-->
				{/foreach}
			</div><!-- End Recent Jobs /-->
		{/if}
		
		{if $most_applied_to_jobs}
			<div class="applied-jobs zebra-striped"><!-- Recent Jobs /-->
				<h6>{$translations.homepage.popular_jobs}</h6>
				{foreach item=job from=$most_applied_to_jobs}
				<div class="row"><!-- Start job /-->
					<div class="span2">
						<span class="label {$job.type_var_name}">{$job.type_name}</span>
					</div>
					<div class="span10">
						<h5><a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a></h5>
						<span>{$job.apps} {$translations.homepage.applicants} - {$translations.homepage.at} {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else}</span>
						<span>{$translations.homepage.in} {$job.location}{/if}</span>
					</div>
					
				</div><!-- End job /-->
				{/foreach}
			</div><!-- End Recent Jobs /-->
		{/if}	
          </div>
		  