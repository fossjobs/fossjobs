{include file="header.tpl"}
	<div id="content">
	{if $settings_categories && $settings_form == ''}
		<h2 id="settings">Settings Overview</h2>
		<div class="list">
		{section name=tmp loop=$settings_categories}
			<div class="row {cycle values='odd,even'}">
				<a class="right" href="{$BASE_URL_ADMIN}settings/{$settings_categories[tmp].var_name}/" title="Edit {$settings_categories[tmp].name}"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
				<h4 class="bold mb05">{$settings_categories[tmp].name}</h4>
				<div>{if $settings_categories[tmp].description != ''}{$settings_categories[tmp].description}{/if}</div>
			</div>
		{/section}
		</div>

	{/if}

	{if $settings_form != ''}
		{if $category_name !=  ''}<h2 id="settings">{$category_name}</h2>{/if}
		
		{if $errors != ''}
			<div class="fail">
				{foreach from=$errors item=error}
				{section name=tmp2 loop=$error}								
					<div>{$error[tmp2]}</div>
				{/section}						
				{/foreach}
			</div>
		{/if}
		
		<form id="publish_form" method="post" action="{$BASE_URL_ADMIN}settings/{$CURRENT_ID}/">
			<div class="list settings">
			{foreach from=$settings_form item=setting}
				{assign var=name value=$setting.name}
				{assign var=title value=$setting.title}
				{assign var=description value=$setting.description}
				{assign var=value value=$setting.value}
				{assign var=data_type value=$setting.data_type}
				{assign var=input_type value=$setting.input_type}
				{assign var=input_options value=$setting.input_options}
				
				<div class="row {cycle values='odd,even'}{if $errors.$name != ''} error{/if}">
					<span>{$title}:</span>
					{if $input_type == 'text_area'}
						<textarea class="settingsform_text_area{if $errors.$name != ''} error{/if}" name="{$name}" cols="40" rows="2">{$value|escape}</textarea>
					{elseif $input_type == 'radiobutton'}
						{if $data_type == 'boolean'}
							<input type="radio" name="{$name}" value="0" {if $value == 0}checked="checked"{/if} />{if $input_options[0]}{$input_options[0]}{else}0{/if}
							<input type="radio" name="{$name}" value="1" {if $value == 1}checked="checked"{/if} />{if $input_options[1]}{$input_options[1]}{else}1{/if}
						{else}
							{section name=tmp2 loop=$input_options}
								<input type="radio" name="{$name}" value="{$input_options[tmp2]}" {if $input_options[tmp2] == $value}checked="checked"{/if} />{$input_options[tmp2]}
							{/section}
						{/if}
					{elseif $input_type == 'select'}
						<select {if $errors.$name != ''}class="error"{/if} name="{$name}">
						{section name=tmp2 loop=$input_options}
							<option value="{$input_options[tmp2]}" {if $input_options[tmp2] == $value}selected="selected"{/if}>{$input_options[tmp2]}</option>
						{/section}
						</select>
					{elseif $input_type == 'checkbox'}
						<input {if $errors.$name != ''}class="error"{/if} type="checkbox" name="{$name}[]" value="_hidden" style="display:none;" checked="checked" />
						{section name=tmp2 loop=$input_options}
							<input type="checkbox" name="{$name}[]" value="{$input_options[tmp2]}" {if in_array($input_options[tmp2], $value)}checked="checked"{/if} />{$input_options[tmp2]}<br />
						{/section}
					{else}
						<input class="settingsform_text_field{if $errors.$name != ''} error{/if}" type="text" name="{$name}" value="{$value|escape}" size="42" />
					{/if}
							{$description}
					</div>
				{/foreach}
			</div>
			<div class="group_submit">
				<input type="hidden" name="action" value="update_settings" />
				<a class="button_gray" href="{$BASE_URL_ADMIN}settings/">Cancel</a>
				<button type="submit" id="save"><span>Save</span></button>
			</div>
		</form>
		{/if}
	</div>
		
{include file="footer.tpl"}