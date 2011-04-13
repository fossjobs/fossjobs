<?php
	$j = new Job($_POST['job_id']);
	$deactivator = $j->Deactivate();
	echo 1;
	exit;
?>