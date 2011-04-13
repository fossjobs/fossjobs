	</div><!-- #wrap -->
	<div class="footer clear">
	</div><!-- .footer -->
	{literal}
	<script type="text/javascript">
		//<![CDATA[
		Jobber.jobber_admin_url = "{/literal}{$BASE_URL_ADMIN}{literal}";
		Jobber.FixPng();
		//]]>
	</script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("a.iframe").fancybox({
				hideOnContentClick: true,
				frameWidth: 980,
				frameHeight: 500
			});
		}); 
	</script>
	
	{/literal}
	<div id="overlay"><img src="{$BASE_URL_ADMIN}img/ajax-loader.gif" /></div>
	<div id="messagesContainer"></div>
	{if $CURRENT_PAGE == "categories"}
	<div id="help" style="display: none;">
		<p class="bold">Categories help</p>
		<ul>
			<li><strong>Name</strong>: The name that will be used in the template</li>
			<li><strong>Title</strong>:</li>
			<li><strong>Description</strong>:</li>
			<li><strong>Keywords</strong>:</li>
			<li><strong>URL</strong>:</li>
		</ul>
	</div>
	{/if}
</body>
</html>