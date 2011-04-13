<?php
	escape($_POST);
	
	$costel = new Postman();
	if ($costel->MailSendToFriend($friend_email, $my_email))
	{
		echo '1';
	}
	else
	{
		echo '0';
	}
	exit;
?>