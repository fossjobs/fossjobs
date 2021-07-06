<!-- Jobs from the same company -->
{if $compjobs && count($compjobs) > 1}
	<hr/>
	<h2>{$translations.jobs.recent_jobs} <a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$jobsat}/">{$job.company}</a>:</h2>
	<hr/>
	{foreach item=compjob from=$compjobs}
		{if $compjob.id != $job.id }
			<article class="post">
				<h3><a href="{$BASE_URL}{$URL_JOB}/{$compjob.id}/{$compjob.url_title}/" title="{$compjob.title}">{$compjob.title}</a></h3>
				<div class="media">
					<div class="media-content">
						<div class="content">
							<p>
								{$job.created_on} - {$translations.homepage.at}
								{if $compjob.url && $compjob.url != 'http://'}
									<a href="{$compjob.url}" class="neutral-link">{$compjob.company}</a>
								{else}
									{$compjob.company}
								{/if}

								{if $compjob.is_location_anywhere}— {$translations.jobs.location_anywhere}{else}{$translations.homepage.in} {$compjob.location}{/if}

								<a href="{$BASE_URL}jobs/{$compjob.type_var_name}/">
									<span class="tag">
										{$compjob.type_name}
										<span class="bd-color {$compjob.type_var_name}">&nbsp;</span>
									</span>
								</a>
							</p>
						</div>
					</div>
					<div class="media-right">
						<span class="has-text-grey-light"><i class="fa fa-comments"></i> {$job.views_count}</span>
					</div>
				</div>
			</article>
		{/if}
	{/foreach}
{/if}
<!-- Jobs from the same company -->
