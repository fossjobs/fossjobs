{include file="header.tpl"}
		
		<div class="row jobmain">
			{include file="sidebar.tpl"}
			<div class="span12">
			<h6>{$translations.rss.intro}</h6>
			<ul>
				<li><a href="{$BASE_URL}rss/all/">{$translations.rss.all_categories}</a></li>
				{section name=tmp loop=$categories}
				<li><a href="{$BASE_URL}rss/{$categories[tmp].var_name}/">{$translations.rss.for} {$categories[tmp].name}</a></li>
				{/section}
			</ul>
			
			</div>
		</div><!-- #content -->
{include file="footer.tpl"}