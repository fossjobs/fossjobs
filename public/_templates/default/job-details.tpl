			<div id="job-details">
				{if $smarty.session.apply_successful AND $smarty.session.apply_successful eq 1}
				<div class="apply-status-ok">
					{$translations.apply.success}
				</div>
				{/if}
				{if ($job.days_old > $smarty.const.OLD_JOB_NOTIFY) && ($smarty.const.OLD_JOB_NOTIFY > 0)}
				<div id="old-ad">
					{$translator->translate("apply.old_ad", $smarty.const.OLD_JOB_NOTIFY)}
				</div>
				{/if}
				{if $CURRENT_PAGE == $URL_JOB}
				<div id="applied-to-job">
					{$job.applied_count}
					{if $job.applied_count != 1}
					<p>{$translations.homepage.applicants}</p>
					{else}
					<p>{$translations.homepage.applicant}</p>
					{/if}
				</div>
				{/if}
				<h2>
					<img src="{$BASE_URL}_templates/{$THEME}/img/icon-{$job.type_var_name}.png" alt="{$job.type_name}" /> {$job.title} 
				</h2>
				<p>
					<span class="fading">{$translations.jobs.preposition_at}</span>
					{if $job.url && $job.url != 'http://'}
					<a href="{$job.url}">{$job.company}</a>
					{else}
					<strong>{$job.company}</strong>
					{/if}
					{if $job.is_location_anywhere}
					<strong>({$translations.jobs.location_anywhere})</strong>
					{else}
					<span class="fading">{$translations.homepage.in}</span> <strong>{$job.location}</strong>
					{/if}
				</p>
				<div id="job-description">
				{$job.description}
				</div>
				<br />
				{if $job.apply_online == 1 && $CURRENT_PAGE != 'verify'}
					<div id="apply_online_now"><a href="#" onclick="$('#apply-online').toggle(); window.location.href = '#apply'; return false;">{$translations.apply.apply_message}</a></div>
					{if $smarty.session.apply_successful AND $smarty.session.apply_successful eq -1}
					<div class="validation-failure">
						<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />
						{if $smarty.session.apply_allowed AND $smarty.session.apply_allowed eq -1}
							{$translator->translate("apply.error_apply_timeout_not_passed", $smarty.const.MINUTES_BETWEEN_APPLY_TO_JOBS_FROM_SAME_IP)}
						{elseif $smarty.session.apply_mail_sent AND $smarty.session.apply_mail_sent eq -1}
							{$translations.apply.error_sending_mail}
						{elseif $smarty.session.apply_errors.apply_cv}
							{$smarty.session.apply_errors.apply_cv}
						{else}
							{$translations.apply.errro_apply_data_invalid}
						{/if}
					</div>
					{/if}
			
					<div id="apply-online" {if $smarty.session.apply_successful AND $smarty.session.apply_successful eq -1}style="display: block;"{else}style="display: none;"{/if}>
						<form id="frm-apply-online" method="post" enctype="multipart/form-data" action="{$BASE_URL}apply-online/">
							<table>
								<tr>
									<td><label for="apply_name">{$translations.apply.name_label}:</label></td>
									<td>
										<input {if $smarty.session.apply_errors.apply_name}class="error"{/if} type="text" name="apply_name" id="apply_name" maxlength="50" size="30" value="{$smarty.session.apply_fields.apply_name}" />
										<span class="validation-error">{if $smarty.session.apply_errors.apply_name}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>	
									</td>
								</tr>
								<tr>
									<td><label for="apply_email">{$translations.apply.email_label}:</label></td>
									<td>
										<input {if $smarty.session.apply_errors.apply_email}class="error"{/if} type="text" name="apply_email" id="apply_email" maxlength="50" size="30" value="{$smarty.session.apply_fields.apply_email}" />
										<span class="validation-error">{if $smarty.session.apply_errors.apply_email}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>	
									</td>
								</tr>
								<tr>
									<td valign="top"><label for="apply_msg">{$translations.apply.message_label}:</label></td>
									<td>
										<textarea {if $smarty.session.apply_errors.apply_msg}class="error"{/if} name="apply_msg" id="apply_msg" cols="60" rows="15">{$smarty.session.apply_fields.apply_msg}</textarea>
										<span class="validation-error">{if $smarty.session.apply_errors.apply_msg}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" />{/if}</span>	
									</td>
								</tr>
								<tr>
									<td valign="top"><label for="apply_cv">{$translations.apply.cv_label}:</label></td>
									<td>
										<input type="file" name="apply_cv" id="apply_cv" />
										<span class="validation-error">{if $smarty.session.apply_errors.apply_cv}<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" title="{$smarty.session.apply_errors.apply_cv}" />{/if}</span>	
										<div class="suggestion">{$translations.apply.cv_info}</div>
									</td>
								</tr>
								{if $ENABLE_RECAPTCHA}
									<tr>
										<td valign="top"><label>Anti-Spam</label></td>
										<td>
											{literal}
											<script type="text/javascript">
											  var RecaptchaOptions = {
											    theme : 'white',
											    tabindex : 9
											  };
											</script>
											{/literal}
											{$the_captcha} <span class="validation-error">{if $smarty.session.apply_errors.captcha}
											<img src="{$BASE_URL}_templates/{$THEME}/img/icon-delete.png" alt="" /> {$smarty.session.apply_errors.captcha}{/if}</span>
										</td>
									</tr>
								{/if}
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr>
									<td colspan="2">
										<input type="submit" name="submit" id="submit" value="{$translations.apply.submit}" /> {$translations.apply.or}
										<a href="#" onclick="$('#apply-online').toggle(); return false;">{$translations.apply.cancel}</a>
									</td>
								</tr>
							</table>
							<input type="hidden" name="job_id" id="job_id" value="{$job.id}" />
						</form>
					</div><!-- #apply-online -->
				{/if}
			<br />{include file="company-posts-loop.tpl"}
			</div><!-- #job-details -->
{literal}
	<script type="text/javascript">
	$(document).ready(function() { 
{/literal}
{if $smarty.session.apply_successful AND $smarty.session.apply_successful eq -1}
	{literal}
		if (document.getElementById("apply_name"))
		{
			window.location.href = "#apply";
			document.getElementById("apply_name").focus();	
		}
	{/literal}
{/if}
{literal}
	$("#frm-apply-online").validate({
		rules: {
			apply_name: { required: true },
			apply_email: { required: true, email: true },
			apply_msg: { required: true },
			apply_cv: { accept: "pdf|rtf|doc|odt" }
		},
		messages: {
			apply_name: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
			apply_email: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
			apply_msg: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />',
			apply_cv: ' <img src="{/literal}{$BASE_URL}_templates/{$THEME}/{literal}img/icon-delete.png" alt="" />'
		}
	});
	}); 
	</script>
{/literal}