{include file="header.tpl"}

<section class="container">
	<div class="columns">

		<div class="column is-9">
			<div class="box content">
				<h1>{$translations.jobscountry.jobs_in_other_countries}</h1>
				<hr/>
				{if $jobs}
					{include file="jobs-list.tpl"}
				{/if}
			</div>
		</div>

		<!-- sidebar start -->
		<div class="column is-3">
			<a class="button is-primary is-block is-alt is-large" href="{$BASE_URL}post/">{$translations.search.submit}</a>
			<aside class="menu">
				<p class="menu-label">
					{$translations.category.display_only}
				</p>
				<ul class="menu-list">
					{section name=tmp loop=$types}
						<!-- There doesn't seem to be type-support for countries yet -->
						<li><a href="{$BASE_URL}/jobs-worldwide/{$types[tmp].var_name}/" title="{$current_category} {$types[tmp].name}">{$types[tmp].name}</a></li>
					{/section}
				</ul>
			</aside>
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
		<!-- sidebar end -->

	</div>
</section>