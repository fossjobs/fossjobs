<div id="left-content">
	
	
		<div class="domtab">
			<ul id="nav" class="domtabs clearfix">
				<li class="selected"><a href="#spotlight_jobs" title="" id="alljobs"><span></span>{$translations.homepage.spotlight_jobs}</a></li>
				<li class="selected"><a href="#latest_jobs" title="" id="alljobs"><span></span>{$translations.homepage.recent_jobs}</a></li>
				{if $most_applied_to_jobs}
					<li class="selected"><a href="#popular_jobs" title="" id="alljobs"><span></span>{$translations.homepage.popular_jobs}</a></li>
				{/if}
			</ul>
			{if $spotlight_jobs}
				<div id="spotlight_jobs"  class="latest-jobs">
					<ul class="joblisting">
						{foreach item=job from=$spotlight_jobs}
							<li>
								<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">
									<span class="jobtype spotlight-image">
										<!--<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />-->
									</span>
									<span class="date">{$job.created_on|date_format:"%d %b"}</span>
									<span class="jobtitle">{$job.title}</span><br />
									<span class="company_name">
										{$job.company}, 
										{if $job.is_location_anywhere}{$translations.jobs.location_anywhere}{else}{$translations.homepage.in}{$job.location}{/if}
									</span>
								</a>
							</li>
						{/foreach}	
					</ul>
				</div>
			{/if}
			{if $latest_jobs}
				<div id="latest_jobs"  class="latest-jobs">
					<ul class="joblisting">
						{foreach item=job from=$latest_jobs}
							<li>
								<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">
									<span class="jobtype">
										<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
									</span>
									<span class="date">{$job.created_on|date_format:"%d %b"}</span>
									<span class="jobtitle">{$job.title}</span><br />
									<span class="company_name">
										{$job.company}, 
										{if $job.is_location_anywhere}{$translations.jobs.location_anywhere}{else}{$job.location}{/if}
									</span>	
								</a>
							</li>
						{/foreach}
					</ul>
				</div>
			{/if}
			
			{if $most_applied_to_jobs}
				<div id="popular_jobs"  class="latest-jobs">
					<ul class="joblisting">
						{foreach item=job from=$most_applied_to_jobs}
							<li>
								<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">
									<span class="jobtype">
										<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
									</span>
									<span class="date">{$job.apps} {$translations.homepage.applicants}</span>
									<span class="jobtitle">{$job.title}</span><br />
									<span class="company_name">
										{$job.company}, 
										{if $job.is_location_anywhere}{$translations.jobs.location_anywhere}{else}{$job.location}{/if}
									 </span>			
								</a>
							</li>
						{/foreach}
					</ul>
				</div>
			{/if}
			
		</div>
	
	

	

	{if !$latest_jobs && !$most_applied_to_jobs}
		<br />
		<p>
			{$translations.homepage.no_jobs}.<br />
			<a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a>?
		</p>
	{/if}
	<div id="job-listings"></div>
</div><!--#left-content-->
<div id="sidebar">
	{include file="sidebar.tpl"}
</div><!-- #sidebar -->