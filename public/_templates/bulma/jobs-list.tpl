	{foreach item=job from=$jobs}

	<article class="post">
	<h4><a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">{$job.title}</a></h4>
	<div class="media">
		<div class="media-left">
			<span class="bd-color {$job.type_var_name}" alt="{$job.type_name}"/>
				&nbsp;
			</span>
		</div>
		<div class="media-content">
			<div class="content">
				<p>
					{$job.created_on} - {$translations.homepage.at} 
					{if $job.url && $job.url != 'http://'}
						<a href="{$job.url}" class="neutral-link">{$job.company}</a>
						{else}
						{$job.company}
						{/if}

					{if $job.is_location_anywhere}, {$translations.jobs.location_anywhere}{else}{$translations.homepage.in} {$job.location}{/if}

					<a href="{$BASE_URL}jobs/{$job.type_var_name}/"><span class="tag {$job.type_name}">{$job.type_name}</span></a>
				</p>
			</div>
		</div>
		<div class="media-right">
			<span class="has-text-grey-light"><i class="fa fa-comments"></i> {$job.views_count}</span>
		</div>
	</div>
</article>

{/foreach}
