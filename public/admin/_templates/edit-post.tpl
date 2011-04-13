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
							<label for="city_id">{$translations.publish.location_label}</label>
							<select name="city_id" id="city_id" {if $job.location_outside_ro != ''}disabled="disabled"{/if} class="ml1">
								<option value="0">{$translations.jobs.location_anywhere}</option>
								{section name="c" loop=$cities}
								<option value="{$cities[c].id}" {if $smarty.post.city_id == $cities[c].id || $job.city_id == $cities[c].id}selected="selected"{else}{if $user_city.id == $cities[c].id AND !$smarty.post.city_id AND !$job.city_id}selected="selected"{/if}{/if}>{$cities[c].name}</option>
								{/section}
							</select>
							<a id="other_location_label" href="#" onclick="Jobber.HandleLocationOutsideRo(); return false;">{if $job.location_outside_ro != ''}pick one from the list{else}other{/if}</a>
							<div id="location_outside_ro" {if $job.location_outside_ro != ''}style="display: block;"{else}style="display: none;"{/if} class="mt1 ml1">
								{$translations.publish.where} <input type="text" name="location_outside_ro_where" id="location_outside_ro_where" size="41" maxlength="140" {if $job.location_outside_ro != ''}value="{$job.location_outside_ro|escape}"{/if} />
								<div class="suggestion ml6">{$translations.publish.where_info}</div>
							</div>
						</div>
						<div class="group{if $errors.description} error{/if}">
							<label for="description">{$translations.publish.description_label}</label>
							<textarea name="description" id="description" cols="80" rows="15">{if $job.description}{$job.description}{else}{$smarty.post.description}{/if}</textarea>
							<div class="suggestion">
								<a target="_blank" href="http://www.textism.com/tools/textile/" onclick="$('#textile-suggestions').toggle(); return false;">{$translations.publish.description_info}</a>
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
											<td>That is _incredible_</td>
											<td>That is <em>incredible</em></td>
	
										</tr>
										<tr class="odd">
											<td>*Indeed* it is</td>
											<td><strong>Indeed</strong> it is</td>
										</tr>
										<tr class="even">
											<td>"Wikipedia":http://www.wikipedia.org</td>
	
											<td><a href="http://www.wikipedia.org">Wikipedia</a></td>
										</tr>
										<tr class="odd">
											<td>* apples<br />* oranges<br />* pears</td>
											<td>
	
												<ul>
													<li>apples</li>
													<li>oranges</li>
													<li>pears</li>
												</ul>
											</td>
										</tr>
	
										<tr class="even">
											<td># first<br /># second<br /># third</td>
											<td>
												<ol>
													<li>first</li>
													<li>second</li>
	
													<li>third</li>
												</ol>
											</td>
										</tr>
									</tbody>
								</table>
							</div><!-- #textile-suggestions -->
						</div>
					</div>
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