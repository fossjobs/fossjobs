{include file="header.tpl"}

<section class="container">
	<div class="columns">
		<div class="column is-9">
			<div class="box content">
				<h1>{$translations.notfound.message}</h1>
				<p>
					{if $smarty.const.ENABLE_NEW_JOBS}
						<a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a>	&middot;
					{/if}
					<a href="{$BASE_URL}">{$translations.notfound.back}</a>
				</p>
			</div>
		</div>

		{include file="sidebar.tpl"}
	</div>
</section>

{include file="footer.tpl"}