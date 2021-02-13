{include file="header.tpl"}

<section class="container">
	<div class="columns">

		<div class="column is-9">
			<div class="box content">

				<h1>{$translations.rss.intro}</h1>
				<hr/>
				<ul>
					<li><a href="{$BASE_URL}rss/all/">{$translations.rss.all_categories}</a></li>
					{section name=tmp loop=$categories}
					<li><a href="{$BASE_URL}rss/{$categories[tmp].var_name}/">{$translations.rss.for} {$categories[tmp].name}</a></li>
					{/section}
				</ul>
			</div>
		</div>

		{include file="sidebar.tpl"}
	</div>
</section>

{include file="footer.tpl"}