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

<div>
<img src="/fossjobs.logo.svg" width="200" style="float:right; margin-left:15px;" alt="">
<h2>Welcome to fossjobs.net</h2>
<div style="margin:5px">
<p>This is a job board exclusively for free &amp; open source jobs: <b>We only list jobs at organizations that improve and involve FOSS or open hardware projects. Merely _using_ open source is not enough.</b></p>
<p>You can also send us job links to <i>submit [(at)] fossjobs [dot] net</i>.</p>
<br/><p><a href="https://fosstodon.org/@fossjobs">Mastodon</a> &bull; <a href="https://twitter.com/fossjobs_net">Twitter</a> &bull; <a href="ircs://chat.freenode.net/#fossjobs">IRC</a> &bull; <a href="https://www.facebook.com/fossjobs.net">Facebook</a> &bull; <a href="https://www.fossjobs.net/rss/">RSS Feeds</a> &bull; <a href="https://github.com/fossjobs/">Github</a></p>
<hr/></div>	
</div>

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
		  
