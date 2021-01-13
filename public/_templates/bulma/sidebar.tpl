				<div class="column is-3">
					<a class="button is-primary is-block is-alt is-large" href="{$BASE_URL}post/">{$translations.search.submit}</a>
					{if $jobs_count_all}
					<aside class="menu">
						<p class="menu-label">
							{$jobs_count_all} {$translations.homepage.sidebar_totaljobs}
						</p>
						<ul class="menu-list">
							{foreach item=job from=$jobs_count_per_country}
							<li><a href="{$BASE_URL}{$URL_JOBS_IN_COUNTRY}/{$job.country_ascii_name}/">{$job.country_name} ({$job.jobs_in_country})</a></li>
							{/foreach}
							{if !$hide_other_countries_in_sidebar}
								<li><a href="{$BASE_URL}jobs-worldwide/">{$translations.sidebar.other_countries} ({$jobs_count_in_other_countries})</a></li>
							{/if}			
						</ul>
					</aside>
					{/if}
					<aside class="menu">
						<p class="menu-label">
							Job Categories
						</p>
						<ul class="menu-list">
							{section name=tmp loop=$categories}
							<li><a href="{$BASE_URL}{$URL_JOBS}/{$categories[tmp].var_name}/" title="{$categories[tmp].name}">{$categories[tmp].name}</a></li>
							{/section}
						</ul>
					</aside>
				</div>
