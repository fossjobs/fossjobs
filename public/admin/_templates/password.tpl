{include file="header.tpl"}
		<div id="content">
				<h2 id="password">Change password</h2>
				
				{if $error}
					<div class="fail">
						{$error}
					</div>
				{/if}
				
				<form id="change_password" action="{$smarty.server.REQUEST_URI}" method="post">
					<div>
						<div class="group{if $error} error{/if}">
							<label for="new_password">New password</label>
							<input type="password" name="new_password" id="new_password" size="30" />
						</div>
						<div class="group{if $error} error{/if}">
							<label for="verify_password">Verify password</label>
							<input type="password" name="verify_password" id="verify_password" size="30" />
						</div>
					<div class="group_submit">
						<button type="submit"><span>Change password</span></button>
					</div>
				</form>
		</div><!-- #content -->

	{literal}
		<script type="text/javascript">
			$(document).ready(function()
			{
				$('#new_password').focus();
				
				$("#change_password").validate({
					rules: {
						new_password: { required: true },
						verify_password: { equalTo: "#new_password" }
					}
				});
			});
		</script>
		{/literal}

{include file="footer.tpl"}