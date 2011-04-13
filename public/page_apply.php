<?php
	foreach ($_POST as $variable => $value)
	{
		$GLOBALS[$variable] = $value;
	}
	$errors = array();
	
	$captcha_enabled = ENABLE_RECAPTCHA && ENABLE_CAPTCHA_ON_APPLY_PAGE;

	// validation
	if ($captcha_enabled)
	{
		$resp = recaptcha_check_answer(CAPTCHA_PRIVATE_KEY,
		$_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"],
		$_POST["recaptcha_response_field"]);
		if (!$resp->is_valid) $errors['captcha'] = $translations['captcha']['captcha_error'];
	}
	
	if ($apply_name == '')
	{
		$errors['apply_name'] = $translations['apply']['name_error'];
	}
	if ($apply_email == '')
	{
		$errors['apply_email'] = $translations['apply']['email_error'];
	}
	if ($apply_msg == '')
	{
		$errors['apply_msg'] = $translations['apply']['msg_error'];
	}
	if ($_FILES['apply_cv'] && $_FILES['apply_cv']['size'] >= MAX_CV_SIZE)
	{
		$errors['apply_cv'] = $translations['apply']['cv_error'];
	}
	if (!validate_email($apply_email))
	{
		$errors['apply_email'] = $translations['apply']['email_invalid'];
	}

	if (empty($errors))
	{
		$j = new Job($job_id);

		$filename = time() . '_' . $_FILES['apply_cv']['name'];
		if (move_uploaded_file($_FILES['apply_cv']['tmp_name'], FILE_UPLOAD_DIR . $filename))
		{
			$attachment = $filename;
		}
		else
		{
			$attachment = '';
		}

		$data = array('apply_email' => $apply_email,
		              'apply_name' => $apply_name,
		              'apply_msg' => strip_tags($apply_msg),
		              'company_email' => $j->mPosterEmail,
		              'company_name' => $j->mCompany,
		              'job_title' => $j->mTitle,
		              'attachment_path' => APP_PATH . FILE_UPLOAD_DIR . $attachment,
		              'attachment_filename' => $attachment,
		              'job_id' => $job_id);
								
		$app = new JobApplication($job_id);
		
		$applicationTimeoutDisabled = MINUTES_BETWEEN_APPLY_TO_JOBS_FROM_SAME_IP <= 0;
		$applicationTimeoutPassed = false;
		
		$applicantIP = $_SERVER['REMOTE_ADDR'];
		
		if (!$applicationTimeoutDisabled)
		{
			$applicationTimeoutPassed = $app->HasApplyTimeoutPassed($applicantIP);
		}
		
		$applicationAllowed = $applicationTimeoutDisabled || $applicationTimeoutPassed;
		
		if ($applicationAllowed)
		{
			$app->Apply($applicantIP);
			
			$mailSender = new Postman();
			
			$applyMailSent = $mailSender->MailApplyOnline($data);
			
			if ($applyMailSent)
			{
				$_SESSION['apply_mail_sent'] = 1;
				$_SESSION['apply_successful'] = 1;
			}
			else
			{
				$_SESSION['apply_mail_sent'] = -1;
				$_SESSION['apply_successful'] = -1;
				$_SESSION['apply_fields'] = $_POST;
			}
		}
		else
		{
			$_SESSION['apply_allowed'] =  -1;
			$_SESSION['apply_successful'] = -1;
			$_SESSION['apply_fields'] = $_POST;
		}
		
		// delete uploaded file (cleanup)
		if ($attachment != '')
		{
			unlink(APP_PATH . FILE_UPLOAD_DIR . $attachment);
		}
	}
	else
	{
		$_SESSION['apply_successful'] = -1;
		$_SESSION['apply_errors'] = $errors;
		$_SESSION['apply_fields'] = $_POST;
	}
	redirect_to($_SERVER['HTTP_REFERER']);
	exit;
?>