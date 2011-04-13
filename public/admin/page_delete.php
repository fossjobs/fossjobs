<?php
	$j = new Job($_POST['job_id']);
	if($j->DeleteJobAdmin())
		echo 1;
	else
		echo "0";
	exit;
?>