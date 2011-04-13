{include file="header.tpl"}
		
		<div id="content">
			<h3 class="page-heading"><a href="{$BASE_URL}" title="{$translations.header.title}">&laquo; {$translations.header.home}</a> / {$translations.rss.title}</h3>
			<p>
				{$translations.rss.intro}
			</p>
			<ul>
				<li><a href="{$BASE_URL}rss/all/">{$translations.rss.all_categories}</a></li>
				{section name=tmp loop=$categories}
				<li><a href="{$BASE_URL}rss/{$categories[tmp].var_name}/">{$translations.rss.for} {$categories[tmp].name}</a></li>
				{/section}
			</ul>
		</div><!-- /content -->

{include file="footer.tpl"}