{include file="header.tpl"}

<section class="container">
	<div class="columns">

		<div class="column is-9">
			<div class="box content">
				<h1>{$page.title}</h1>
				{$page.content}
				{if $page.has_form == '1'}
				{if $errors}
				<div class="validation-failure">
					{$errors.contact_error}
				</div>
				{elseif $smarty.session.contact_msg_sent == 1}
				<div class="apply-status-ok">
					{$page.form_message}
				</div>
				{/if}

				{if $smarty.session.contact_msg_sent != 1}
				<div id="contact-form">
					<div id="contact-form-contents">
						<form id="apply-online" method="post" action="{$BASE_URL}{$page.url}/">
							<input type="text" name="contact_name" id="contact_name" class="span7" placeholder="{$translations.contact.name_label}" />
							<span class="validation-error">{if $errors.contact_name}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>
							<br /><br />

							<input type="text" name="contact_email" id="contact_email" class="span7" placeholder="{$translations.contact.email_label}" />
							<span class="validation-error">{if $errors.contact_email}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>
							<br /><br />

							<textarea name="contact_msg" id="contact_msg" class="xxlarge" cols="50" rows="8" placeholder="{$translations.contact.message_label}" >{$smarty.post.contact_msg}</textarea>
							<span class="validation-error">{if $errors.contact_msg}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>

							{if $ENABLE_RECAPTCHA}
								<br /><br />
								{$the_captcha}
								<span class="validation-error">{if $errors.captcha}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" /> {$errors.captcha}{/if}</span>
							{/if}
							<br /><br />
							<button type="submit" name="submit" id="submit" class="btn primary">{$translations.contact.submit}</button>

						</form>
					</div><!-- #contact-form-contents -->
					{/if}
				</div><!-- #contact-form -->
				{/if}

			</div>
		</div>

		{include file="sidebar.tpl"}
	</div>
</section>

{include file="footer.tpl"}