{include file="header.tpl"}
			<div class="row jobmain">
			{include file="sidebar.tpl"}
			
			<div class="span12">
			<h3>{$translations.sitemap.title}</h3>
			
			<h6>{$translations.sitemap.jobs}:</h6>
			<ul>
				{section name=tmp loop=$categories}
        		<li id="{$categories[tmp].var_name}"><a href="{$BASE_URL}{$URL_JOBS}/{$categories[tmp].var_name}/" title="{$categories[tmp].var_name}">{$categories[tmp].name}</a></li>
				{/section}
			</ul>
			
			<h6>{$translations.sitemap.use}:</h6>
			<ul>
				{if $smarty.const.ENABLE_NEW_JOBS}
					<li><a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a></li>
				{/if}
				<li><a href="{$BASE_URL}widgets/" title="{$translations.footer.widgets_title}">{$translations.footer.widgets}</a></li>
				<li><a href="{$BASE_URL}rss/" title="{$translations.footer.title}">{$translations.footer.rss}</a></li>
			</ul>
			
			<h6>{$translations.sitemap.more}:</h6>
			<ul>
				<li><a href="{$BASE_URL}{$URL_COMPANIES}/" title="{$translations.footer.companies_title}">{$translations.footer.companies}</a></li>
				<li><a href="{$BASE_URL}{$URL_COUNTRIES}/" title="{$translations.footer.countries_title}">{$translations.footer.countries}</a></li>
				{foreach from=$articles item=article}
				<li><a href="{$BASE_URL}{$article.url}/" title="{$article.page_title}">{$article.title}</a></li>
				{/foreach}
			</ul>
			
		</div><!-- /content -->
		</div><!-- #content -->

{include file="footer.tpl"}
