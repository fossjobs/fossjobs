{include file="header.tpl"}
		<div id="content">
				<h2 id="job_types">Job Types</h2>
				
				<div class="information">The icon has to be named <em>icon_varname.png</em> (replace varname with the varname of the corresponding jobtype) and has to be uploaded to <strong>{$BASE_URL}_templates/{$THEME}/img/</strong>.</div>
				
				<div id="typesContainer">
				{section name=tmp loop=$types}
					<div class="typeItem" rel="{$types[tmp]->getId()}">
						<div class="typeHandle"></div>
						<div class="typeWrapper">
							<a href="#" title="Delete job type" class="deleteType"><img src="{$BASE_URL_ADMIN}_templates/img/bin.png" alt="Delete" /></a>
							<label><span>Name:</span><input type="text" size="50" name="name[{$types[tmp]->getId()}]" value="{$types[tmp]->getName()}" /><img class="help" src="{$BASE_URL_ADMIN}_templates/img/information-balloon.png" title="The name that will be used in the template" /></label>
							<a href="#" title="Save changes" class="saveType"><img src="{$BASE_URL_ADMIN}_templates/img/disk.png" alt="Delete" /></a>
							<label><span>Var name:</span><input type="text" size="50" id="nr" name="var_name[{$types[tmp]->getId()}]" value="{$types[tmp]->getVarName()}" /><img class="help" src="{$BASE_URL_ADMIN}_templates/img/information-balloon.png" title="Var name must not contain spaces or other special chars" /></label>
						</div>
					</div>
				{/section}
				</div>
				<p></p>
				<p>
					<a href="#" title="Add new type"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new job type" /></a></p>
		</div><!-- #content -->

{include file="footer.tpl"}