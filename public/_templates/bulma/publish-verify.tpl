{include file="header.tpl"}

<section class="container">
	<div class="columns">
		<div class="column">
			<div class="box content">
				<h1>{$translations.publish.step2}</h1>
				<div class="columns">
					{include file="job-details.tpl"}
				</div>

				<form name="publish_form" id="publish_form" method="post" action="{$BASE_URL}publish/{$job.id}/">
					<fieldset>
						<div class="content">
							{if $smarty.session.later_edit}
							<input type="submit" name="submit" id="submit" class="button danger" value="{$translations.publish.save}" />
							{else}
							<input type="submit" name="submit" id="submit" class="button danger" value="{$translations.publish.publish}" />
							{/if}
							&nbsp;or&nbsp;
							<a class="button small" href="{$BASE_URL}post/{$job.id}/" title="{$translations.publish.edit}">{$translations.publish.edit}</a>
						</div>
						<div class="content">
							{$translations.publish.step2_info}
							<a class="btn small" href="{$BASE_URL}deactivate/{$job.id}/" title="{$translations.publish.step2_cancel}">{$translations.publish.step2_cancel}</a>
						</div>
					</fieldset>
				</form>

			</div><!-- /content -->

		</div>
	</div>
</section>

{include file="footer.tpl"}