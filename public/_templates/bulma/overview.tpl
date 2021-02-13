{include file="header.tpl"}

<section class="container">
	<div class="columns">
		<div class="column is-9">
			<div class="box content">
				<h1>{$translations.jobscountry.title}</h1>
				{section name=tmp loop=$countries_overview}
					<span class="company-tag-{$countries_overview[tmp].tag_height}">
						<a href="{$BASE_URL}{$URL_JOBS_IN_COUNTRY}/{$countries_overview[tmp].varname}">{$countries_overview[tmp].name}
							({$countries_overview[tmp].count})</a>
					</span>
				{/section}
				{if $jobs_count_in_other_countries > 0}
					<span class="company-tag-{$jobs_count_in_other_countries_tag_height}">
						<a href="{$BASE_URL}jobs-worldwide/">{$translations.jobscountry.other_countries}
							({$jobs_count_in_other_countries})</a>
					</span>
				{/if}
				<br /><br />
				<p>
					{$translations.jobscountry.total}: <strong>{$total_number_of_jobs}</strong>
					{$translations.jobscountry.jobs}
				</p>
			</div>
			<div class="box content">

				<h1>{$translations.companies.title}</h1>
				{section name=tmp loop=$companies}
					<span class="company-tag-{$companies[tmp].tag_height}">
						<a href="{$BASE_URL}{$URL_JOBS_AT_COMPANY}/{$companies[tmp].varname}/">{$companies[tmp].name}
							({$companies[tmp].count})</a>
					</span>
				{/section}
				<br /><br />
				<p>
					{$translations.companies.total}: <strong>{$companies_count}</strong>
					{$translations.companies.companies}
				</p>
			</div>
		</div>

		{include file="sidebar.tpl"}
	</div>
</section>

{include file="footer.tpl"}