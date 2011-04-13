<?php
	escape($_POST);
	$spam = new SpamReport($job_id);
	if ($spam->PostIsSpam())
	{
		echo '1';
	}
	else
	{
		echo '0';
	}
	exit;
?>