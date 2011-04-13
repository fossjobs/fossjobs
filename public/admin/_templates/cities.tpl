{include file="header.tpl"}

	<div id="content">
			<h2 id="cities">Cities</h2>
			<p><a href="{$BASE_URL_ADMIN}cities/prepare-add/" title="Add a new city"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new city" /></a></p>
			<div class="list">
				{foreach from=$cities item=city}
				<div class="row {cycle values='odd,even'}" id="item{$city.id}">
					<div class="icons">
						<a href="{$BASE_URL_ADMIN}cities/prepare-edit/{$city.id}/" title="Edit this city"><img src="{$BASE_URL_ADMIN}_templates/img/pencil.png" alt="Edit" /></a>
						<a href="javascript:void(0);" title="Delete this city" onclick="jobberBase.deleteCity('{$BASE_URL_ADMIN}cities/delete/', {$city.id})"><img src="{$BASE_URL_ADMIN}_templates/img/bin.png" alt="Delete" /></a>
					</div>
					<strong>{$city.name}</strong> ({$city.ascii_name})
				</div>
				{/foreach}
			</div>
			<p><a href="{$BASE_URL_ADMIN}cities/prepare-add/" title="Add a new city"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new city" /></a></p>
		</div><!-- #content -->

{include file="footer.tpl"}