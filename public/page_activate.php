<?php
	$j = new Job($id);
	// if auth code used, check it and allow activating
	if ((isset($_SESSION['later_edit']) && $_SESSION['later_edit'] == $j->GetAuth()) || ($extra != '' && $extra == $j->GetAuth()))
	{
		$activator = $j->Activate();
		$vali = new Postman();
		$vali->MailPostActivatedToUser($j->GetInfo());
		
		
		$_SESSION['status'] = $translations['jobs']['activated_success'];	
		redirect_to(BASE_URL . URL_JOB .'/' . $id . '/');
		exit;
	}
	else
	{
		redirect_to(BASE_URL);
		exit;
	}
?>