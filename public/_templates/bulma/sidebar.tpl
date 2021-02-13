				<nav class="column is-3" aria-label="job overview">
					<a class="button is-primary is-block is-alt is-large" href="{$BASE_URL}post/">{$translations.search.submit}</a>
					<h1 class="is-sr-only">Overview</h1>
					{if $jobs_count_all}
						<aside class="menu">
							<h2 class="menu-label">
								{$jobs_count_all} {$translations.homepage.sidebar_totaljobs}
							</h2>
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
						<h2 class="menu-label">
							Job Categories
						</h2>
						<ul class="menu-list">
							{section name=tmp loop=$categories}
								<li><a href="{$BASE_URL}{$URL_JOBS}/{$categories[tmp].var_name}/">{$categories[tmp].name}</a></li>
							{/section}
						</ul>
					</aside>
				</nav>