{include file="header.tpl"}
		
		<div class="row jobmain">
			<div class="span4">
			<div class="spannerfirst">
            <h6>{$translations.category.display_only}</h6>
				<ul>
					{if $jobs}
					{section name=tmp loop=$types}
					<li><a href="{$BASE_URL}{$URL_JOBS}/{$current_category}/{$types[tmp].var_name}/" title="{$current_category} {$types[tmp].name}">{$types[tmp].name}</a></li>
					{/section}
					{/if}
				</ul>
			</div>
			</div>
			<div class="span12">
				<div class="job-details zebra-striped"><!-- Recent Jobs /-->
				<h6>{$translations.category.jobs_for} {$current_category_name}</h6>
				{include file="posts-loop.tpl"}			
			</div>
			</div>	
		</div><!-- #content -->
		

{include file="footer.tpl"}