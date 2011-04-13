{include file="header.tpl"}
		<div id="content">
			<h2 id="pages">Pages</h2>
			<p>
				<a href="{$BASE_URL_ADMIN}pages/add/" title="Add a new page"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new page" /></a>
			</p>
			<div class="list">
			{foreach from=$pages item=page}
				<div class="row {cycle values='odd,even'}">
					<div class="icons">
						<a href="{$BASE_URL}{$page.url}/" target="_blank" title="View this page"><img src="{$BASE_URL_ADMIN}_templates/img/eye.png" alt="View" /></a>
						<a href="{$BASE_URL_ADMIN}pages/edit/{$page.url}/" title="Edit this page"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
					<a href="{$BASE_URL_ADMIN}pages/delete/{$page.url}/" title="Delete this page" onclick="if(!confirm('Are you sure you want to delete this page?'))return false;"><img src="{$BASE_URL_ADMIN}_templates/img/bin.png" alt="Delete" /></a>
					</div>
					{$page.page_title} - {$page.title}
				</div>
			{/foreach}
			</div>
			<p>
				<a href="{$BASE_URL_ADMIN}pages/add/" title="Add a new page"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new page" /></a>
			</p>
		</div><!-- #content -->
{include file="footer.tpl"}