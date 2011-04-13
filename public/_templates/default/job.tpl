{include file="header.tpl"}
		
		<div id="content">
			<div id="job-listings"></div><!-- #job-listings -->
			{include file="job-details.tpl"}
			{if $CURRENT_PAGE == $URL_JOB}
			<div id="job-bottom">
				<div id="job-post-utils">
					<a href="{$back_link}" title="category home">&laquo; {$translations.notfound.back}</a><br />
					{$translations.jobs.report_fake} <a href="#" onclick="Jobber.ReportSpam('{$BASE_URL}report-spam/', {$job.id}); return false;" title="report fake ad">{$translations.jobs.report_it}</a>
					&nbsp;&nbsp;<span id="report-spam-response"></span><br />
					<a href="#" onclick="Jobber.SendToFriend.showHide(); return false;" title="{$translations.recommend.title}">{$translations.recommend.title}</a>
				</div><!-- #job-post-utils -->
				<div id="number-views">
					{$translator->translate("jobs.published_at", "<strong>`$job.created_on`</strong>")}
					<br />
					{$translator->translate("jobs.viewed", "<strong>`$job.views_count`</strong>")}
				</div><!-- #number-views -->
				<div class="clear"></div>
			</div><!-- #job-bottom -->
			<div id="send-to-friend" style="display: none;">
				<form id="frm-send-to-friend" method="post" action="{$BASE_URL}send-to-friend/">
					<table>
						<tr>
							<td class="send-to-friend-address-label"><label for="friend_email">{$translations.recommend.friend_email_label}:</label></td>
							<td><input type="text" name="friend_email" id="friend_email" maxlength="50" size="30" /></td>
						</tr>
						<tr>
							<td><label for="my_email">{$translations.recommend.your_email_label}:</label></td>
							<td><input type="text" name="my_email" id="my_email" maxlength="50" size="30" /></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" name="submit" id="submit" value="{$translations.recommend.submit}" />
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
		</div><!-- /content -->

{include file="footer.tpl"}