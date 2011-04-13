{include file="header.tpl"}

		<div id="content">
			<div id="job-listings"></div><!-- #job-listings -->
			<div id="no-ads">
				<p>{$translations.notfound.message}</p>
				<p>
					{if $smarty.const.ENABLE_NEW_JOBS}
						<a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a>	&middot;
					{/if} 
					<a href="{$BASE_URL}">{$translations.notfound.back}</a>
				</p>
			</div>
		</div><!-- /content -->

{include file="footer.tpl"}