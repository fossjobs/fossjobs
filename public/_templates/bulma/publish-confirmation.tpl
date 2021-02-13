{include file="header.tpl"}

<section class="container">
	<div class="columns">
		<div class="column is-9">
			<div class="box content">

			{if $smarty.session.later_edit}
				<div class="posted-ok">
					<h1>{$translations.publish.edit_success}: <a href="{$job_url}">{$job_url}</a></h1>
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
				{/if}
			{/if}

			</div>
		</div>

		{include file="sidebar.tpl"}
	</div>
</section>

{include file="footer.tpl"}