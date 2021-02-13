{include file="header.tpl"}

<section class="container">
	<div class="columns">

		<div class="column is-9">
			<div class="box content">
				<h1>{$translations.category.jobs_for} {$current_category_name}</h1>
				<hr />
				{include file="posts-loop.tpl"}
			</div>
		</div>

		<!-- sidebar start -->
		<div class="column is-3">
			<a class="button is-primary is-block is-alt is-large"
				href="{$BASE_URL}post/">{$translations.search.submit}</a>
			<aside class="menu">
				<p class="menu-label">
					{$translations.category.display_only}
				</p>
				<ul class="menu-list">
					{section name=tmp loop=$types}
						<li><a href="{$BASE_URL}{$URL_JOBS}/{$types[tmp].var_name}/"
								title="{$types[tmp].name}">{$types[tmp].name}</a></li>
					{/section}
				</ul>
			</aside>
		</div>
		<!-- sidebar end -->
	</div>
</section>

{include file="footer.tpl"}
