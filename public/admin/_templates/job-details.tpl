			<div id="job-details">
				
				{if $job.days_old > 40}
				<div id="old-ad">
					This job ad has been posted over 40 days ago...
				</div>
				{/if}
				{if $CURRENT_PAGE == $URL_JOB}
				<div id="applied-to-job">
					{$job.applied_count}
					{if $job.applied_count != 1}
					<p>applicants</p>
					{else}
					<p>applicant</p>
					{/if}
				</div>
				{/if}
				<h2>
					<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" /> {$job.title} 
				</h2>
				<p>
					<span class="fading">at</span>
					{if $job.url && $job.url != 'http://'}
					<a href="{$job.url}">{$job.company}</a>
					{else}
					<strong>{$job.company}</strong>
					{/if}
					{if $job.is_location_anywhere}
					<strong>({$translations.jobs.location_anywhere})</strong>
					{else}
					<span class="fading">in</span> <strong>{$job.location}</strong>
					{/if}
				</p>
				<div id="job-description">
				{$job.description|highlight_keywords:$smarty.session.keywords_array}
				</div><br />
				
			</div><!-- #job-details -->
