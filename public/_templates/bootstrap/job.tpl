{include file="header.tpl"}
		
		<div class="row jobmain">
			{include file="sidebar.tpl"}
			
			<div class="span12">
			{include file="job-details.tpl"}
			{if $CURRENT_PAGE == $URL_JOB}
			<div class="job-post-utils">
			<div class="alert-message block-message info">
				<div class="alert-actions">
				  {$translations.jobs.report_fake} <a class="btn small danger" href="#" onclick="Jobber.ReportSpam('{$BASE_URL}report-spam/', {$job.id}); return false;" title="report fake ad">{$translations.jobs.report_it}</a> or <a class="btn small success" href="#" onclick="Jobber.SendToFriend.showHide(); return false;" title="{$translations.recommend.title}">Recommend to a friend</a>
					<br /><span id="report-spam-response"></span>
				</div>
			</div>
			</div>
			
			<div id="send-to-friend" style="display: none;">
				<form id="frm-send-to-friend" method="post" action="{$BASE_URL}send-to-friend/">
					<table>
						<tr>
							<td class="send-to-friend-address-label"><label for="friend_email">{$translations.recommend.friend_email_label}:</label></td>
							<td><input type="text" name="friend_email" id="friend_email" class="span8" /></td>
						</tr>
						<tr>
							<td><label for="my_email">{$translations.recommend.your_email_label}:</label></td>
							<td><input type="text" name="my_email" id="my_email" class="span8" /></td>
						</tr>
						<tr>
							<td colspan="2">
								<input class="btn small" type="submit" name="submit" id="submit" value="{$translations.recommend.submit}" />
								&nbsp;&nbsp;<span id="send-to-friend-response"></span>
							</td>
						</tr>
					</table>
				</form>
			</div><!-- #send-to-friend -->
			
			{literal}
			<script type="text/javascript">
				$(document).ready(function()
				{
					Jobber.SendToFriend.init();
				});
			</script>
			{/literal}
			{/if}
			</div>
			
		</div><!-- #content -->

{include file="footer.tpl"}