{include file="header.tpl"}
		
		<div class="row jobmain">
			<div class="span16">
			<ul class="pills">
				<li><a href="#">{$translations.publish.step1}</a></li>
				<li class="active"><a href="#">{$translations.publish.step2}</a></li>
				<li><a href="#">{$translations.publish.step3}</a></li>
			</ul>

			{include file="job-details.tpl"}
			
			<form name="publish_form" id="publish_form" method="post" action="{$BASE_URL}publish/{$job.id}/">
				<fieldset>
					<div class="right">
						<div class="suggestion">{$translations.publish.step2_info}
						<a class="btn small" href="{$BASE_URL}deactivate/{$job.id}/" title="{$translations.publish.step2_cancel}">{$translations.publish.step2_cancel}</a></div>
					</div>
					{if $smarty.session.later_edit}
					<input type="submit" name="submit" id="submit" class="btn danger" value="{$translations.publish.save}" />
					{else}
					<input type="submit" name="submit" id="submit" class="btn danger" value="{$translations.publish.publish}" />
					{/if}
					&nbsp;or&nbsp;
					<a class="btn small" href="{$BASE_URL}post/{$job.id}/" title="{$translations.publish.edit}">{$translations.publish.edit}</a>
				</fieldset>
			</form>
			</div>
		</div><!-- /content -->

{include file="footer.tpl"}