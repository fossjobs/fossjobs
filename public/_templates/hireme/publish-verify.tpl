{include file="header.tpl"}
		
		<div id="content">
			<div id="job-listings"></div><!-- #job-listings -->
			<div class="steps">
				<div id="step-1">
					{$translations.publish.step1}
				</div>
				<div id="step-2" class="step-active">
					{$translations.publish.step2}
				</div>
				<div id="step-3">
					{$translations.publish.step3}
				</div>
				<div class="clear"></div>
			</div>
			
			{include file="job-details.tpl"}
			
			<form name="publish_form" id="publish_form" method="post" action="{$BASE_URL}publish/{$job.id}/">
				<fieldset>
					<div class="right">
						<div class="suggestion">{$translations.publish.step2_info}
						<a href="{$BASE_URL}deactivate/{$job.id}/" title="{$translations.publish.step2_cancel}">{$translations.publish.step2_cancel}</a></div>
					</div>
					{if $smarty.session.later_edit}
					<input type="submit" name="submit" id="submit" value="{$translations.publish.save}" />
					{else}
					<input type="submit" name="submit" id="submit" value="{$translations.publish.publish}" />
					{/if}
					&nbsp;or&nbsp;
					<a href="{$BASE_URL}post/{$job.id}/" title="{$translations.publish.edit}">{$translations.publish.edit}</a>
				</fieldset>
			</form>
		</div><!-- /content -->

{include file="footer.tpl"}