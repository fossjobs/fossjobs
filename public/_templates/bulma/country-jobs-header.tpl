{include file="header.tpl"}
		
<section class="container">
<div class="columns">

	<div class="column is-9">
		<div class="box content">

			<h4>{$translations.jobscountry.jobs_in} {$country_name}</h4>
			<hr/>
			{if $jobs}
				{include file="jobs-list.tpl"}
			{/if}
		</div>
	</div>

	{include file="sidebar.tpl"}
</div>
</section>

{include file="footer.tpl"}