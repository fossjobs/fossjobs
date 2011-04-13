{include file="header.tpl"}
		
		<div id="content">
			<div id="job-listings"></div><!-- #job-listings -->
			<div class="steps">
				<div id="step-1">
					{$translations.publish.step1}
				</div>
				<div id="step-2">
					{$translations.publish.step2}
				</div>
				<div id="step-3" class="step-active">
					{$translations.publish.step3}
				</div>
				<div class="clear"></div>
			</div>
			<br />
			{if $smarty.session.later_edit}
				<div class="posted-ok">
					{$translations.publish.edit_success}: <a href="{$job_url}">{$job_url}</a>
					{php}
						unset($_SESSION['later_edit']);
						unset($_SESSION['referer']);
					{/php}
				</div>
				<br />
				<p>
					<a href="{$BASE_URL}">&laquo; {$translations.notfound.back}</a>
				</p>
			{else}
				{if $postRequiresModeration}
					<div class="posted-pending">
						{$translations.publish.success_message}
					</div>
					<br />
					<p>
						<a href="{$BASE_URL}">&laquo; {$translations.notfound.back}</a>
					</p>
				{else}
					<div class="posted-ok">
						<strong>{$translations.publish.congratulations}</strong><br /><a href="{$job_url}">{$translations.publish.view}</a>.
					</div>
					<h4>{$translations.publish.options_title}</h4>
					<p>
						{$translations.publish.options_info}:
					</p>
					<ul>	
						<li><a href="{$BASE_URL}post/{$CURRENT_ID}/{$auth}/" title="{$translations.publish.edit}">&raquo; {$translations.publish.edit}</a></li>
						<li><a href="{$BASE_URL}deactivate/{$CURRENT_ID}/{$auth}/" title="{$translations.publish.deactivate}">&raquo; {$translations.publish.deactivate}</a></li>
					</ul>
				{/if}
			{/if}
		</div><!-- /content -->

{include file="footer.tpl"}