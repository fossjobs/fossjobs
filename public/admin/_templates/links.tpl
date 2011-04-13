{include file="header.tpl"}
	<div id="content">
	{if $links == ''}
		<h2 id="links">Navigation Links</h2>
		
		<div class="information">If you want to hide a menu from the frontend simply remove all links from the corresponding menu. It could be that some links are hardcoded. You'll have to edit the template files to remove those links.</div>
		
		<div class="list">
			<div class="row odd">
				<a class="right" href="{$BASE_URL_ADMIN}links/primary/" title="Edit main menu"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
				<h4 class="bold mb05">Primary menu</h4>
				<div>The primary menu for your Jobberbase theme. By default this menu is located at the top.</div>
			</div>
			<div class="row even">
				<a class="right" href="{$BASE_URL_ADMIN}links/secondary/" title="Edit secondary menu"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
				<h4 class="bold mb05">Secondary menu</h4>
				<div>The secondary menu for your Jobberbase theme. By default this menu is located in the sidebar</div>
			</div>
			<div class="row odd">
				<a class="right" href="{$BASE_URL_ADMIN}links/footer1/" title="Edit footer menu 1"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
				<h4 class="bold mb05">Footer menu 1</h4>
				<div>The default footer holds 3 columns. This is for the first column</div>
			</div>
			<div class="row even">
				<a class="right" href="{$BASE_URL_ADMIN}links/footer2/" title="Edit footer menu 2"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
				<h4 class="bold mb05">Footer menu 2</h4>
				<div>The default footer holds 3 columns. This is for the second column</div>
			</div>
			<div class="row odd">
				<a class="right" href="{$BASE_URL_ADMIN}links/footer3/" title="Edit footer menu 3"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
				<h4 class="bold mb05">Footer menu 3</h4>
				<div>The default footer holds 3 columns. This is for the third column</div>
			</div>
		</div>

	{else}

		<h2 id="links">{$menu_name}</h2>
		<div id="linksContainer">
		{foreach from=$links item=menu}
			{section name=tmp loop=$menu}
			<div class="linkItem" rel="{$menu[tmp].id}">
				<div class="linkHandle"></div>
				<div class="linkWrapper">
					<a href="#" title="Delete this link" class="deleteLink"><img src="{$BASE_URL_ADMIN}_templates/img/bin.png" alt="Delete" /></a>
					<label><span>Name:</span><input type="text" size="60" name="name{$menu[tmp].id}" value="{$menu[tmp].name}" /><img class="help" src="{$BASE_URL_ADMIN}_templates/img/information-balloon.png" title="The text you want to display in the frontend" /></label>
					<a href="#" title="Save changes" class="saveLink" style="display: none;"><img src="{$BASE_URL_ADMIN}_templates/img/disk.png" alt="Save" /></a>
					<label><span>Url:</span><input type="text" size="60" name="url{$menu[tmp].id}" value="{$menu[tmp].url}" /><img class="help" src="{$BASE_URL_ADMIN}_templates/img/information-balloon.png" title="The URL you want to link to. When you want to link to a Jobberbase page (e.g. the page Contact) you can use the Jobberbase URL (e.g. contact)" /></label>
					<label><span>Title:</span><input type="text" size="60" name="title{$menu[tmp].id}" value="{$menu[tmp].title}" /><img class="help" src="{$BASE_URL_ADMIN}_templates/img/information-balloon.png" title="Text that shows when you hover over the link, just like this help message. You can leave this blank if you don't want to show anything" /></label>
					</label>
				</div>
			</div>
			{/section}
		{/foreach}
		</div>
		<p></p>
		<p><a href="#" title="Add new link"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new link" /></a></p>

	{/if}
	</div><!-- #content -->

{include file="footer.tpl"}