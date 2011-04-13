{include file="header.tpl"}
		
		<div id="content" class="clearfix">
			
			{include file="home.tpl"}
		</div><!-- #content -->
		{literal}
		<script type="text/javascript">
			$(document).ready(function()
			{

				$(".joblisting li:odd").addClass("alt");
			});
		</script>
		{/literal}
{include file="footer.tpl"}