{include file="header.tpl"}

<div id="content">
	<h2 id="pages">Pages - <em>{if $current_page}&quot;{$current_page.title}&quot;{else}New page{/if}</em></h2>
	
	{if $errors}
	<div class="fail">
		Please check for errors
	</div>
	{/if}
	
	<form id="publish_form" class="add_page" action="{$smarty.server.REQUEST_URI}" method="post">
		<div class="left span2 block">
			<h3>Page content</h3>
			<div class="block_inner">
				<div class="group{if $errors.page_title} error{/if}">
					<label for="page_title">Page Heading</label>
					<input type="text" name="page_title" id="page_title" class="text_field" size="35" value="{$defaults.page_title}" />
					{if $errors.page_title}<span class="suggestion">{$errors.page_title}</span>{/if}
				</div>
				<div class="group">
					<label for="page_content">Content</label>
					<textarea id="page_content" name="page_content" class="textarea_field mceEditor" cols="85" rows="25">{$defaults.page_content}</textarea>
				</div>
				<div class="group">
					<label><input type="checkbox" id="page_has_form" name="page_has_form" value="1"{if $defaults.page_has_form == '1'} checked="checked"{/if} /> Add a contact form?</label>
					{if $defaults.page_has_form != '1'}<div class="suggestion">You can change the feedback message after you save the page</div>{/if}
					<div {if $defaults.page_has_form != '1'} class="hidden"{/if}>
						<label for="page_form_message">Form message</label></div>
					<div {if $defaults.page_has_form != '1'} class="hidden"{/if}>
						<textarea id="page_form_message" name="page_form_message" class="textarea_field mceEditor" cols="85" rows="10">{$defaults.page_form_message}</textarea>
					</div>
				</div>
				<div class="group_submit">
					<button type="submit"><span>{if $current_page}Save changes{else}Save page{/if}</span></button>
				</div>
			</div>
		</div>

		<div class="right span1">
			<div class="block mb2">
				<h3>Search Engine Optimisation</h3>
				<div class="block_inner">
					<div class="group{if $errors.page_url} error{/if}">
						<label for="page_url">URL</label>
						<input type="text" name="page_url" id="page_url" size="32" value="{$defaults.page_url}" />
						{if $errors.page_url}<span class="suggestion">{$errors.page_url}</span>{/if}
					</div>
					<div class="group{if $errors.page_page_title} error{/if}">
						<label for="page_page_title">Page title</label>
						<input type="text" name="page_page_title" id="page_page_title" size="32" value="{$defaults.page_page_title}" />
					</div>
					<div class="group">
						<label for="page_keywords">Keywords</label>
						<textarea id="page_description" name="page_description" rows="6" cols="30">{$defaults.page_description}</textarea>
					</div>
					<div class="group">
						<label for="page_description">Description</label>
						<textarea id="page_keywords" name="page_keywords" rows="6" cols="30">{$defaults.page_keywords}</textarea>
					</div>
					<div class="group_submit">
						<button type="submit"><span>{if $current_page}Save changes{else}Save page{/if}</span></button>
					</div>
				</div>
			</div>
			<div class="block mb2">
				<h3>Links</h3>
				<div class="block_inner">
					<p>Make a selection in the editor or select an existing link and click on one of the links bellow.</p>
					<dl id="links_list">
						<dt><strong>Internal</strong></dt>
							<dd><a href="#" rel="{$BASE_URL}post/">Post a job</a></dd>
							<dd><a href="#" rel="{$BASE_URL}rss/">RSS Feed</a></dd>
							<dd><a href="#" rel="{$BASE_URL}{$URL_COMPANIES}/">Companies</a></dd>
						<dt><strong>Categories</strong></dt>
							{section name=tmp loop=$categories}
							<dd><a href="#" rel="{$BASE_URL}{$URL_JOBS}/{$categories[tmp].var_name}/">{$categories[tmp].name}</a></dd>
							{/section}
						<dt><strong>Pages</strong></dt>
							{foreach from=$pages item=page}
							<dd><a href="#" rel="{$BASE_URL}{$URL_JOBS}/{$page.url}/">{$page.title}</a></dd>
							{/foreach}
					</dl>
				</div>
			</div>
		</div>
	</form>
</div><!-- #content -->
{literal}
	<script type="text/javascript">
		jobberBase.editor();
	</script>
{/literal}
{literal}
		<script type="text/javascript">
			$(document).ready(function()
			{
				$('#page_title').focus();
				
				$("#publish_form").validate({
					rules: {
						page_title: { required: true },
						page_content: { required: true },
						page_url: { required: true },
						page_page_title: { required: true }
					},
					messages: {
						page_title: '',
						page_content: '',
						page_url: '',
						page_page_title: ''
					}
				});
			});
		</script>
		{/literal}
{include file="footer.tpl"}