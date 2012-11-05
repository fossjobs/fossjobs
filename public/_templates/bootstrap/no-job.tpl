{include file="header.tpl"}
		
		<div class="row jobmain">
			{include file="sidebar.tpl"}
			<div class="span12">
			<div id="no-ads">
				<h6>{$translations.jobs.no_job}</h6>
				<p>
					{if $smarty.const.ENABLE_NEW_JOBS}
					<a href="{$BASE_URL}post/" title="{$translations.footer.new_job_title}">{$translations.footer.new_job}</a> &middot;
					{/if} 
					<a href="{$BASE_URL}">{$translations.notfound.back}</a>
				</p>
			</div>
			</div>
		</div><!-- #content -->
{include file="footer.tpl"}