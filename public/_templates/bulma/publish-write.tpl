{include file="header.tpl"}

<section class="container">
	<div class="columns">

		<div class="column is-9">
			<div class="box content">

				<h1>{$translations.publish.step1}</h1>
				{if $filter_error}
					<div class="notification is-dark">
						<h1 class="has-text-white" role="alert">{$filter_error}</h1>
					</div>
				{/if}
				{if $errors}
					<div class="notification is-dark">
						<h1 class="has-text-white" role="alert">{$translations.publish.form_error}</h1>
					</div>
				{/if}
				<form id="publish_form" method="post" action="{$BASE_URL}post/">

					<div class="field is-grouped">
						<label for="type_id" class="label is-sr-only">Type</label>
						<div class="control">
							<div class="select">
								<select name="type_id" id="type_id">
									{section name=tmp2 loop=$types}
										<option value="{$types[tmp2].id}" {if !$job.type_id && !$smarty.post.type_id}
												{if $smarty.section.tmp2.first}selected="selected"
													{/if}{else}{if $types[tmp2].id == $job.type_id}selected="selected"
													{/if}{if $types[tmp2].id == $smarty.post.type_id}selected="selected" {/if}{/if}>
													{$types[tmp2].name}</option>
									{/section}
								</select>
							</div>
						</div>

						<label for="category_id" class="label is-sr-only">Category</label>
						<div class="control">
							<div class="select">
								<select name="category_id" id="category_id">
									{section name=tmp1 loop=$categories}
										<option value="{$categories[tmp1].id}"
											{if $default_categ_id != '' && $default_categ_id == $categories[tmp1].id}selected="selected"
												{else}
													{if $categories[tmp1].id == $job.category_id}selected="selected"
														{/if}{if $categories[tmp1].id == $smarty.post.category_id}selected="selected"
													{/if}
												{/if}>{$categories[tmp1].name}</option>
									{/section}
								</select>
							</div>
						</div>
					</div>

					<div class="field">
						<label for="title" class="label is-sr-only">Job Title</label>
						<div class="control">
							<input class="input" type="text" name="title" id="title"
								value="{if $job.company}{$job.title|escape}{else}{$smarty.post.title|escape}{/if}"
								placeholder="{$translations.publish.title_label}" autofocus />
							{if $errors.title}
								<div class="notification is-danger">&#9888; Please enter a job title.</div>
							{/if}
						</div>
					</div>

					<div class="field is-grouped is-grouped-multiline">
						<div class="control" style="max-width: 100%;">
							<label for="country_id" class="label is-sr-only">Country</label>
							<div class="select">
								<select name="country_id" id="country_id">
									<option value="0">{$translations.jobs.location_anywhere}</option>
									{section name="c" loop=$countries}
										<option value="{$countries[c].id}"
											{if $smarty.post.country_id == $countries[c].id || $job.country_id == $countries[c].id}selected="selected"
											{else}
												{if $user_country.id == $countries[c].id AND !$smarty.post.country_id AND !$job.country_id}selected="selected"
												{/if}
											{/if}>{$countries[c].name}</option>
									{/section}
								</select>
							</div>
						</div>

						<div class="control">
							<label for="city" class="label is-sr-only">City</label>
							<input class="input" type="text" name="city" id="city"
								{if $smarty.post.city != ''}value="{$smarty.post.city|escape}" {/if}
								placeholder="{$translations.publish.where} {$translations.publish.where_info}" />
						</div>
					</div>

					<div class="field">
						<div class="control">
							<label for="description" class="label is-sr-only">Job Description</label>
							<textarea name="description" id="description" rows="15" class="textarea"
								placeholder="{$translations.publish.description_label} ">{if $job.company}{$job.description}{else}{$smarty.post.description}{/if}</textarea>
							{if $errors.description}
								<div class="notification is-danger">&#9888; Please enter a description.</div>
							{/if}
						</div>
					</div>

					<div class="field">
						<label for="company" class="label">{$translations.publish.company}</label>
						<div class="control">
							<input type="text" name="company" id="company" class="input"
								value="{if $job.company}{$job.company|escape}{else}{$smarty.post.company|escape}{/if}"
								placeholder="{$translations.publish.name_label}" />
							{if $errors.company}<div class="notification is-danger">&#9888; Please enter a company or
								project name.</div>{/if}
						</div>
					</div>

					<div class="field">
						<div class="control">
							<label for="url" class="label">{$translations.publish.website_label}</label>
							<input type="text" name="url" id="url" class="input"
								value="{if $job.company}{$job.url}{else}{$smarty.post.url}{/if}"
								placeholder="{$translations.publish.website_info}" />
						</div>
					</div>

					<div class="field">
						<div class="control">
							<label for="poster_email" class="label">{$translations.publish.email_label}</label>
							<input type="email" name="poster_email" id="poster_email" class="input"
								value="{if $job.poster_email}{$job.poster_email}{else}{$smarty.post.poster_email}{/if}"
								placeholder="({$translations.publish.email_info1})" />
							{if $errors.poster_email}<div class="notification is-danger">&#9888; Please enter an email
								address here. You will receive a mail and have to click a link to confirm.</div>{/if}
						</div>
					</div>

					{if $ENABLE_RECAPTCHA}
						<div class="field">
							<label class="label" for="recaptcha_response_field">{$translations.captcha.captcha_title}</label>
							<div class="control">
								{$the_captcha} {if $errors.captcha}
									<div class="notification is-danger">{$errors.captcha}</div>
								{/if}
							</div>
						</div>
					{/if}

					<div class="field">
						<div class="control">
							<input type="submit" name="submit" id="submit" class="button is-link"
								value="{$translations.publish.step1_submit}" />
						</div>
					</div>

					<fieldset class="hidden">
						<input
							type="hidden" name="action"
							{if $job.id || $smarty.session.later_edit}value="edit"{else}value="publish"{/if}
						/>
						{if $smarty.session.later_edit}
							<input type="hidden" name="auth" value="{$smarty.session.later_edit}" />
						{/if}
						{if $job.id}
							<input type="hidden" name="job_id" value="{$job.id}" />
						{/if}
					</fieldset>
				</form>

			</div><!-- /content -->
		</div>

		<div class="column is-3">
			<p class="menu-label">
				{$translations.publish.syntax}
			</p>
			<ul class="menu-list">
				<li>For italics, use _underscores_</li>
				<li>For bold, use *asterisks*</li>
				<li>Surround code with @at signs@</li>
				<li>"Example link":https://example.com</li>
				<li>Bullet list:<br />* apples<br />* oranges<br />* pears</li>
				<li>Numbered list:<br /># first<br /># second<br /># third</li>
				<li>Headings:<br/>h1. level 1<br />h2. level 2<br />...<br/>h6. level 6</li>
			</ul>
			<small>(<a href="https://textile-lang.com">{$translations.publish.syntax_ref}</a>)</small>
		</div>

	</div>
</section>

{include file="footer.tpl"}
