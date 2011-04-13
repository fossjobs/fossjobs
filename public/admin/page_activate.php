<?php
	$j = new Job($_POST['job_id']);
	$activator = $j->Activate();
	$vali = new Postman();
	$vali->MailPostActivatedToUser($j->GetInfo(), BASE_URL_ORIG);
	echo 1;
	exit;
?>