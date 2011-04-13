<ul class="joblisting">
{foreach item=job from=$jobs}
	<li>
		<a href="{$BASE_URL}{$URL_JOB}/{$job.id}/{$job.url_title}/" title="{$job.title}">
			<span class="jobtype">
				<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" />
			</span>
			<span class="date">{$job.created_on|date_format:"%d %b"}</span>
			<span class="jobtitle">{$job.title}</span><br />
			<span class="company_name">
				{$job.company}, 
				{if $job.is_location_anywhere}{$translations.jobs.location_anywhere}{else}{$job.location}{/if}
			</span>	
		</a>
	</li>
{/foreach}
</ul>
<br/>
{$pages}