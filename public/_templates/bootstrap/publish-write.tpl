{include file="header.tpl"}

<div class="row jobmain">
	{include file="sidebar.tpl"}
	<div class="span12">
		<ul class="pills">
			<li class="active"><a href="#">{$translations.publish.step1}</a></li>
			<li><a href="#">{$translations.publish.step2}</a></li>
			<li><a href="#">{$translations.publish.step3}</a></li>
		</ul>

		{if $filter_error}
		<div class="validation-failure">
			<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />
			{$filter_error}
		</div>
		{/if}
		{if $errors}
		<div class="validation-failure">
			<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />
			{$translations.publish.form_error}
		</div>
		{/if}

		<form id="publish_form" method="post" action="{$BASE_URL}post/">
			<div class="row">
				<div class="span10">
					<h6>{$translations.publish.job_details}</h6>
					<table border="0" cellspacing="2" cellpadding="2">
						<tr>
							<td colspan="2">
								<select name="type_id" id="type_id" tabindex="1">
									{section name=tmp2 loop=$types}
									<option value="{$types[tmp2].id}" {if !$job.type_id && !$smarty.post.type_id}{if $smarty.section.tmp2.first}selected="selected"{/if}{else}{if $types[tmp2].id == $job.type_id}selected="selected"{/if}{if $types[tmp2].id == $smarty.post.type_id}selected="selected"{/if}{/if}>{$types[tmp2].name}</option>
									{/section}&nbsp;&nbsp;
								</select>
								<select name="category_id" id="category_id" tabindex="1">
									{section name=tmp1 loop=$categories}
									<option value="{$categories[tmp1].id}" {if $default_categ_id != '' && $default_categ_id == $categories[tmp1].id}selected="selected"{else}{if $categories[tmp1].id == $job.category_id}selected="selected"{/if}{if $categories[tmp1].id == $smarty.post.category_id}selected="selected"{/if}{/if}>{$categories[tmp1].name}</option>
									{/section}
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" name="title" id="title" class="span10" value="{if $job.company}{$job.title|escape}{else}{$smarty.post.title|escape}{/if}" placeholder="{$translations.publish.title_label}" />
								{if $errors.title}<span class="validation-error"><img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" /></span>{/if}
								<div class="{$translations.publish.title_info}"></div>
							</td>
						</tr>
						<tr>
							<td>
								<select class="span6" name="country_id" id="country_id" tabindex="3">
									<option value="0">{$translations.jobs.location_anywhere}</option>
									{section name="c" loop=$countries}
									<option value="{$countries[c].id}" {if $smarty.post.country_id == $countries[c].id || $job.country_id == $countries[c].id}selected="selected"{else}{if $user_country.id == $countries[c].id AND !$smarty.post.country_id AND !$job.country_id}selected="selected"{/if}{/if}>{$countries[c].name}</option>
									{/section}
								</select>
								<input type="text" name="city" id="city" class="span5" {if $smarty.post.city != ''}value="{$smarty.post.city|escape}"{/if} placeholder="{$translations.publish.where} {$translations.publish.where_info}" />
							</td>
						</tr>
						<tr>
							<td>
								<textarea tabindex="4" name="description" id="description" rows="15" class="span10" placeholder="{$translations.publish.description_label} ">{if $job.company}{$job.description}{else}{$smarty.post.description}{/if}</textarea>
								{if $errors.description}<span class="validation-error"><img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" /></span>{/if}
								<div class="suggestion">
									<a target="_blank" href="https://textile-lang.com" onclick="$('#textile-suggestions').toggle(); return false;">{$translations.publish.description_info}</a>
								</div>
								<div id="textile-suggestions" style="display: none;">
									<table>
										<thead>
											<tr>
												<th style="width: 50%;">{$translations.publish.syntax}</th>
												<th>{$translations.publish.result}</th>
											</tr>
										</thead>
										<tbody>
											<tr class="even">
												<td>For italics, use _underscores_</td>
												<td>For italics, use <em>underscores</em></td>
											</tr>
											<tr class="odd">
												<td>For bold, use *asterisks*</td>
												<td>For bold, use <strong>asterisks</strong></td>
											</tr>
											<tr class="even">
												<td>"Example link":https://example.com</td>
												<td>Here's how to format an "example link":https://example.com</td>
												<td><a href="https://example.com">Example link</a></td>
											</tr>
											<tr class="odd">
												<td>Bullet list:<br />* apples<br />* oranges<br />* pears</td>
												<td>
													Bullet list:
													<ul>
														<li>apples</li>
														<li>oranges</li>
														<li>pears</li>
													</ul>
												</td>
											</tr>
											<tr class="even">
												<td>Numbered list:<br /># first<br /># second<br /># third</td>
												<td>
													Numbered list:
													<ol>
														<li>first</li>
														<li>second</li>
														<li>third</li>
													</ol>
												</td>
											</tr>
											<tr class="odd">
												<td>Headings:<br />h1. level 1<br />h2. level 2<br />...<br />h6. level 6</td>
												<td>
													Headings:
													<h1>level 1</h1>
													<h2>level 2</h2>
													...
													<h6>level 6</h6>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- #textile-suggestions -->
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="span10">
					<h6>{$translations.publish.company}</h6>
					<table border="0" cellspacing="2" cellpadding="2">
						<tr>
							<td><input tabindex="6" type="text" name="company" id="company" class="span8" value="{if $job.company}{$job.company|escape}{else}{$smarty.post.company|escape}{/if}" placeholder="{$translations.publish.name_label}" />
							<span class="validation-error">{if $errors.company}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>
							</td>
						</tr>
						<tr>
							<td><input tabindex="7" type="text" name="url" id="url" class="span8" value="{if $job.company}{$job.url}{else}{$smarty.post.url}{/if}" placeholder="{$translations.publish.website_label} http://..."/>
								<div class="suggestion">{$translations.publish.website_info}</div>
							</td>
						</tr>
						<tr>
							<td>
								<input tabindex="8" type="text" name="poster_email" id="poster_email" class="span8" value="{if $job.poster_email}{$job.poster_email}{else}{$smarty.post.poster_email}{/if}" placeholder="{$translations.publish.email_label} ({$translations.publish.email_info1})"/>
								<span class="validation-error">{if $errors.poster_email}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			{if $ENABLE_RECAPTCHA}
			<div class="row">
				<div class="span10">
					<h6>{$translations.captcha.captcha_title}</h6>
					{literal}
					<script type="text/javascript">
						var RecaptchaOptions = {
						theme : 'white',
						tabindex : 9
						};
					</script>
					{/literal}
					{$the_captcha}
					<span class="validation-error">
						{if $errors.captcha}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" /> {$errors.captcha}{/if}
					</span>
				</div>
			</div>
			{/if}
<!--
			<div class="row">
				<div class="span10">
					<ul class="inputs-list">
					<li>
						<label>
						<input type="checkbox" name="apply_online" id="apply_online" class="no-border" {if $job.apply_online == 1 || $is_apply == 1}checked="checked"{/if}{if !isset($job.apply_online) && !isset($is_apply)}checked="checked"{/if} />
						<span>{$translations.publish.apply_online}</span>
						</label>
					</li>
					</ul>
				</div>
			</div>
-->
			<input type="hidden" name="apply_online" id="apply_online" value="0" />
			<input type="submit" name="submit" id="submit" class="btn danger" value="{$translations.publish.step1_submit}" />
			<fieldset class="hidden">
				<input type="hidden" name="action" {if $job.id || $smarty.session.later_edit}value="edit"{else}value="publish"{/if} />
				{if $smarty.session.later_edit}<input type="hidden" name="auth" value="{$smarty.session.later_edit}" />{/if}
				{if $job.id}<input type="hidden" name="job_id" value="{$job.id}" />{/if}
			</fieldset>
		</form>
	</div>

	{literal}
	<script type="text/javascript">
		$(document).ready(function()
		{
			$('#title').focus();

			$("#publish_form").validate({
				rules: {
					type_id: { required: true },
					company: { required: true },
					title: { required: true },
					description: { required: true },
					poster_email: { required: true, email: true }
				},
				messages: {
					type_id: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
					company: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
					title: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
					location: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
					description: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
					poster_email: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />'
				}
			});
		});
	</script>
	{/literal}

</div>

{include file="footer.tpl"}
