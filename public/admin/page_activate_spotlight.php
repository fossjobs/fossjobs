<?php
	$j = new Job($_POST['job_id']);
	$activator = $j->SpotlightActivate();
	echo 1;
	exit;
?>