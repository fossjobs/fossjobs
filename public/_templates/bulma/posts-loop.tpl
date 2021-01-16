
{if $no_categ != 1}
	{if $keywords}
		<h1>Search results for <strong>{$keywords}</strong>:</h1>
	{/if}
	{if $jobs}
		{include file="jobs-list.tpl"}
	{/if}
{/if}