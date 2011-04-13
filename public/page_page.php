<?php

	$captcha_enabled = ENABLE_RECAPTCHA && ENABLE_CAPTCHA_ON_CONTACT_PAGE;
	
	if ($_SERVER['REQUEST_METHOD'] == 'POST') {
		
		$_SESSION['contact_msg_sent'] = -1;
		
		$contact_name = strip_tags($_POST['contact_name']);
		$contact_email = $_POST['contact_email'];
		$contact_msg = strip_tags($_POST['contact_msg']);
		
		$errors = array();
		
		// validation
		if ($captcha_enabled)
		{
			$resp = recaptcha_check_answer(CAPTCHA_PRIVATE_KEY,
			$_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"],
			$_POST["recaptcha_response_field"]);
			if (!$resp->is_valid) $errors['captcha'] = $translations['captcha']['captcha_error'];
		}
		
		if ($contact_name == '')
		{
			$errors['contact_name'] = $translations['contact']['name_error'];
		}
		if ($contact_email == '' || !validate_email($contact_email))
		{
			$errors['contact_email'] = $translations['contact']['email_error'];
		}
		if ($contact_msg == '')
		{
			$errors['contact_msg'] = $translations['contact']['msg_error'];
		}
		
		if (count($errors) > 0)
		{
			$errors['contact_error'] = $translations['contact']['send_error'];
			$smarty->assign('errors', $errors);
		}
		else
		{
			$mailer = new Postman();
			
			if ($mailer->MailContact($contact_name, $contact_email, $contact_msg))
			{
				$_SESSION['contact_msg_sent'] = 1;
			}
		}
	}
	$smarty->assign('page', $pageData);
	
	if ($pageData['has_form'] == '1')
	{
		$smarty->assign('ENABLE_RECAPTCHA', $captcha_enabled);
		
		if ($captcha_enabled)
		{
			$smarty->assign('the_captcha', recaptcha_get_html(CAPTCHA_PUBLIC_KEY));
		}
	}
?>