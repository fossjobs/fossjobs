	<div class="column is-9">
		<div class="box content" role="main">
					<h1>Welcome to fossjobs.net</h1>
					<div class="content is-small">
					<img src="/logo.svg" width="200" height="135" style="float:right; margin-left:15px;" alt="">
						<div>
							<p>This is a job board exclusively for paid free &amp; open source jobs: <b>We only list jobs at organizations that improve and involve FOSS or open hardware projects. Merely _using_ open source as part of the job is not enough.</b></p>
							<p>Listings are free. <a href="{$BASE_URL}post/">Submit jobs you find!</a> You can also send us job links to <i>submit [(at)] fossjobs [dot] net</i>.</p>
							<br/><p><a href="https://fosstodon.org/@fossjobs">Mastodon</a> &bull; <a href="https://twitter.com/fossjobs_net">Twitter</a> &bull; <a href="ircs://chat.freenode.net/#fossjobs">IRC</a> &bull; <a href="https://www.facebook.com/fossjobs.net">Facebook</a> &bull; <a href="https://www.fossjobs.net/rss/">RSS Feeds</a> &bull; <a href="https://github.com/fossjobs/">Github</a></p>
							<hr/>
						</div>	
					</div>
					{if $latest_jobs}
						<h2 class="is-sr-only">Latest jobs</h2>
						{foreach item=job from=$latest_jobs}
						<article class="post">
							<h3><a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/">{$job.title}</a></h3>
							<div class="media">
								<div class="media-left">
									<span class="bd-color {$job.type_var_name}">
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
								<div class="media-right is-hidden-mobile">
									<span class="has-text-grey-light"><i class="fa fa-comments"></i> {$job.views_count}</span>
								</div>
							</div>
						</article>
						{/foreach}
						<a href="{$BASE_URL}{$URL_JOBS}/">{$translations.homepage.view_all_jobs}</a>
					{/if}
		</div>
	</div>
