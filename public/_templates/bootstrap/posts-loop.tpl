
{if $no_categ != 1}
	{if $keywords}
		Search results for <strong>{$keywords}</strong>:
	{/if}
	{if $jobs}
		{include file="jobs-list.tpl"}
	{/if}
{/if}