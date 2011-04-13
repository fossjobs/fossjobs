<?php
	$j = new Job($_POST['job_id']);
	$deactivator = $j->SpotlightDeactivate();
	echo 1;
	exit;
?>