{if $spotlight_jobs}
	<h2>{$translations.homepage.spotlight_jobs}</h2>
	
	{foreach item=job from=$spotlight_jobs}
		<div class="row-spot">
			<span class="row-info">
				<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
				<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a> <span class="la">{$translations.homepage.at}</span> {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else} <span class="la">{$translations.homepage.in}</span> {$job.location}{/if}
			</span>
			<span class="spotlight-image"></span>
		</div>
	{/foreach}
{/if}

{if $latest_jobs}
	<br />
	<h2>{$translations.homepage.recent_jobs}</h2>
	
	{foreach item=job from=$latest_jobs}
		<div class="{cycle values='row,row-alt'}">
			<span class="row-info">
				<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
				<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a> <span class="la">{$translations.homepage.at}</span> {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else} <span class="la">{$translations.homepage.in}</span> {$job.location}{/if}
			</span>
			<span class="time-posted"><img src="{$BASE_URL}_templates/{$THEME}/img/clock.gif" alt="" /> {$job.created_on}</span>
		</div>
	{/foreach}
	
	<div id="view_all">
		<a href="{$BASE_URL}{$URL_JOBS}/">{$translations.homepage.view_all_jobs}</a>
	</div>
{/if}

{if $most_applied_to_jobs}
	<br />
	<h2>{$translations.homepage.popular_jobs}</h2>
	
	{foreach item=job from=$most_applied_to_jobs}
		<div class="{cycle values='row,row-alt'}">
			<span class="row-info">
				<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
				<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a> <span class="la">{$translations.homepage.at}</span> {$job.company}{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else} <span class="la">{$translations.homepage.in}</span> {$job.location}{/if}
			</span>
			<span class="time-posted"><strong>{$job.apps}</strong> {$translations.homepage.applicants}</span>			
		</div>
	{/foreach}
{/if}

{if !$latest_jobs && !$most_applied_to_jobs}
	<br />
	<p>
		{$translations.homepage.no_jobs}.<br />
		<a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a>?
	</p>
{/if}