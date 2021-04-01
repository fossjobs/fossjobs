{include file="header.tpl"}

<div id="content">
	<h2 id="edit_job">{if $job.id == 0}Post a job{else}Edit a job{/if}</h2>
	<div id="job-listings"></div><!-- #job-listings -->

	{if $filter_error}
	<div class="fail">
		{$filter_error}
	</div>
	{/if}
	{if $errors}
	<div class="fail">
		{$translations.publish.form_error}
	</div>
	{/if}

	{if $show_preview}
		{include file="edit-post-preview.tpl"}
	{/if}

	<form id="publish_form" method="post" action="{$BASE_URL_ADMIN}edit-post/{if $job.id neq 0}{$job.id}/{/if}">
		<div class="clearfix">
			<div class="left span2 block">
				<h3>Job Details</h3>
				<div id="job_details" class="block_inner">
					<div class="group clearfix category">
						<label>Job Type</label>
						{section name=tmp2 loop=$types}
						<div>
							<label for="type_id_{$types[tmp2].id}">
								<input class="no-border" type="radio" name="type_id" id="type_id_{$types[tmp2].id}" value="{$types[tmp2].id}" {if !$job.type_id && !$smarty.post.type_id}{if $types[tmp2].id == 1}checked="checked"{/if}{else}{if $types[tmp2].id == $job.type_id}checked="checked"{/if}{if $types[tmp2].id == $smarty.post.type_id}checked="checked"{/if}{/if} />
								<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$types[tmp2].var_name}.png" alt="{$types[tmp2].name}" />
							</label>
						</div>
						{/section}
					</div>
					<div class="group">
						<label>Category</label>
						<select name="category_id" id="category_id" class="ml1">
						{section name=tmp1 loop=$categories}
							<option value="{$categories[tmp1].id}" {if $default_categ_id != '' && $default_categ_id == $categories[tmp1].id}selected="selected"{else}{if $categories[tmp1].id == $job.category_id}selected="selected"{/if}{if $categories[tmp1].id == $smarty.post.category_id}selected="selected"{/if}{/if}>{$categories[tmp1].name}</option>
						{/section}
						</select>
					</div>
					<div class="group{if $errors.title} error{/if}">
						<label for="title">{$translations.publish.title_label}</label>
						<input type="text" name="title" id="title" size="50" value="{if $job.title}{$job.title|escape}{else}{$smarty.post.title|escape}{/if}" />
						<div class="{$translations.publish.title_info}"></div>
					</div>
					<div class="group">
						<label for="country_id">{$translations.publish.location_label}</label>
						<select name="country_id" id="country_id" class="ml1">
							<option value="0">{$translations.jobs.location_anywhere}</option>
							{section name="c" loop=$countries}
							<option value="{$countries[c].id}" {if $smarty.post.country_id == $countries[c].id || $job.country_id == $countries[c].id}selected="selected"{else}{if $user_country.id == $countries[c].id AND !$smarty.post.country_id AND !$job.country_id}selected="selected"{/if}{/if}>{$countries[c].name}</option>
							{/section}
						</select>
						{$translations.publish.where} <input type="text" name="city" id="city" size="41" maxlength="140" {if $job.city != ''}value="{$job.city|escape}"{/if} />
					</div>
					<div class="group{if $errors.description} error{/if}">
						<label for="description">{$translations.publish.description_label}</label>
						<textarea name="description" id="description" cols="80" rows="15">{if $job.description}{$job.description}{else}{$smarty.post.description}{/if}</textarea>
						<div class="suggestion">
							<a target="_blank" href="https://textile-lang.com" onclick="$('#textile-suggestions').toggle(); return false;">{$translations.publish.description_info}</a>
						</div>
						<div id="textile-suggestions" style="display: none;">
							<table>
								<thead>
									<tr class="odd">
										<th>{$translations.publish.syntax}</th>
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
					</div>
				</div><!-- #job_details -->
			</div>

			<div id="company_info" class="left span1 block last">
				<h3>{$translations.publish.company}</h3>
				<div class="block_inner">
					<div class="group{if $errors.company} error{/if}">
						<label for="company">{$translations.publish.name_label}</label>
						<input type="text" name="company" id="company" size="30" value="{if $job.company}{$job.company|escape}{else}{$smarty.post.company|escape}{/if}" />
					</div>

					<div class="group">
						<label for="url">{$translations.publish.website_label}</label>
						<em>http://</em><input type="text" name="url" id="url" size="25" value="{if $job.company}{$job.url}{else}{$smarty.post.url}{/if}" />
						<div class="suggestion">{$translations.publish.website_info}</div>
					</div>

					<div class="group{if $errors.poster_email} error{/if}">
						<label for="poster_email">{$translations.publish.email_label} <span class="light">({$translations.publish.email_info1})</span></label>
						<input type="text" name="poster_email" id="poster_email" size="30" value="{if $job.poster_email}{$job.poster_email}{else}{$smarty.post.poster_email}{/if}" />
						<div class="suggestion">{$translations.publish.email_info2}</div>
					</div>

					<div class="group">
						<label for="apply_online">Allow online applications
						<input type="checkbox" name="apply_online" id="apply_online" class="no-indent" {if $job.apply_online == 1 || $job.id == 0}checked="checked"{/if}{if !isset($job.apply_online)}checked="checked"{/if} /></label><span class="suggestion">If you are unchecking this, then add a description on how to apply online!</span>
					</div>

					<div class="group_submit">
						<button type="button" id="preview" class="gray"><span>Preview</span></button>
						<button type="submit" id="save"><span>{if $job.id == 0}Post job{else}Save changes{/if}</span></button>
						<input type="hidden" name="show_preview" id="show_preview" value="false" />
						<input type="hidden" name="job_id" value="{$job.id}" />
					</div>
				</div>
			</div><!-- #company_info -->
		</div>
	</form>
</div><!-- /content -->

{literal}
<script type="text/javascript">
	$(document).ready(function()
	{
		$('#type_id_1').focus();

		$("#publish_form").validate({
			rules: {
				company: { required: true },
				title: { required: true },
				description: { required: true },
				poster_email: { required: true, email: true }
			},
			messages: {
				company: '',
				title: '',
				location: '',
				description: '',
				poster_email: ''
			}
		});

		$('#save').bind('click', function()
		{
			$("#publish_form").submit();
		});

		$('#preview').bind('click', function()
		{
			$('#show_preview').val('true');
			$("#publish_form").submit();
		});
	});
</script>
{/literal}

{include file="footer.tpl"}
