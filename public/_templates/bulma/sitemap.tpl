{include file="header.tpl"}

<section class="container">
	<div class="columns">
		<div class="column is-9">
			<div class="box content">

				<h1>{$translations.sitemap.title}</h1>

				<h2>{$translations.sitemap.jobs}:</h2>
				<ul>
					{section name=tmp loop=$categories}
					<li id="{$categories[tmp].var_name}"><a href="{$BASE_URL}{$URL_JOBS}/{$categories[tmp].var_name}/" title="{$categories[tmp].var_name}">{$categories[tmp].name}</a></li>
					{/section}
				</ul>

				<h2>{$translations.sitemap.use}:</h2>
				<ul>
					{if $smarty.const.ENABLE_NEW_JOBS}
						<li><a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a></li>
					{/if}
					<li><a href="{$BASE_URL}widgets/" title="{$translations.footer.widgets_title}">{$translations.footer.widgets}</a></li>
					<li><a href="{$BASE_URL}rss/" title="{$translations.footer.title}">{$translations.footer.rss}</a></li>
				</ul>

				<h2>{$translations.sitemap.more}:</h2>
				<ul>
					<li><a href="{$BASE_URL}{$URL_COMPANIES}/" title="{$translations.footer.companies_title}">{$translations.footer.companies}</a></li>
					<li><a href="{$BASE_URL}{$URL_COUNTRIES}/" title="{$translations.footer.countries_title}">{$translations.footer.countries}</a></li>
					{foreach from=$articles item=article}
					<li><a href="{$BASE_URL}{$article.url}/" title="{$article.page_title}">{$article.title}</a></li>
					{/foreach}
				</ul>

			</div>
		</div>

		{include file="sidebar.tpl"}
	</div>
</section>

{include file="footer.tpl"}