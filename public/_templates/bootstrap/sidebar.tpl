		<div class="span4">
			<div class="spannerfirst">
						
			<h6>Job Categories</h6>
				<ul>
				{section name=tmp loop=$categories}
				<li><a href="{$BASE_URL}{$URL_JOBS}/{$categories[tmp].var_name}/" title="{$categories[tmp].name}">{$categories[tmp].name}</a></li>
				{/section}
				</ul>
					
			</div>
			{if $CURRENT_PAGE == ''}
			<div class="spanner">			
			<h6>{$jobs_count_all} {$translations.homepage.sidebar_totaljobs}</h6>
				<ul>
					{if $smarty.const.SIDEBAR_SHOW_WHAT == 'categories'}
					{foreach item=job from=$jobs_count_all_categs}
					<li><a href="{$BASE_URL}{$URL_JOBS}/{$job.categ_varname}/">{$job.categ_name} ({$job.categ_count})</a></li>
					{/foreach}
				{else}
					{foreach item=job from=$jobs_count_per_country}
					<li><a href="{$BASE_URL}{$URL_JOBS_IN_COUNTRY}/{$job.country_ascii_name}/">{$job.country_name} ({$job.jobs_in_country})</a></li>
					{/foreach}
					{if !$hide_other_countries_in_sidebar}
					<li><a href="{$BASE_URL}jobs-worldwide/">{$translations.sidebar.other_countries} ({$jobs_count_in_other_countries})</a></li>
					{/if}
				{/if}
					
				</ul>	
			</div>
			{/if}
			<div class="spanner">
			 <h6><a href="/rss/"><img src="/_templates/bootstrap/img/rss.png"> RSS Feeds</a></h6>
			</div>
			<div class="spannerlast">
			{if $navigation.secondary != ''}
			<h6>{$translations.sidebar.menu_title}</h6>
				<ul>
					{section name=tmp loop=$navigation.secondary}
					{if $smarty.const.ENABLE_NEW_JOBS || (!$smarty.const.ENABLE_NEW_JOBS && $navigation.secondary[tmp].url != 'post')}
						<li><a href="{if $navigation.secondary[tmp].outside != 1}{$BASE_URL}{/if}{$navigation.secondary[tmp].url}/" title="{$navigation.secondary[tmp].title}" >{$navigation.secondary[tmp].name}</a></li>
					{/if}
				{/section}
				</ul>
			{/if}		
			</div>
		</div>
