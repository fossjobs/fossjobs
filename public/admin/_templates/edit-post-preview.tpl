<div class="block mb2">
	<h3>Preview</h3>
	<div class="block_inner">
		<div id="job-details">
		{if $job.days_old > 40}
			<div id="notice">
				This job ad has been posted over 40 days ago...
			</div>
		{/if}
			<h2><img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" /> {$job.title}</h2>
			<p>
				<span class="light">at</span>
				{if $job.url && $job.url != 'http://'}
					<a href="{$job.url}">{$job.company}</a>
				{else}
					<strong>{$job.company}</strong>
				{/if}
				{if $job.is_location_anywhere}
					<strong>({$translations.jobs.location_anywhere})</strong>
				{else}
					<span class="light">in</span> <strong>{$job.location}</strong>
				{/if}
			</p>
			<div id="job-description">
				{$job.textiledDescription}
			</div>
		</div><!-- #job-details -->
	</div>
</div>
