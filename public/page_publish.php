<?php
	$job = new Job($id);
	
	$isNewPost = $job->mIsTemp;
	$postRequiresModeration = !$job->IsApprovedPosterEmail() && ENABLE_NEW_POST_MODERATION;
	
	if ($isNewPost)
		$job->Publish();
	
	$postMan = new Postman();
	
	$jobInfo = $job->GetInfo();
	$jobInfo['isNewPost'] = $isNewPost;
	$jobInfo['postRequiresModeration'] = $postRequiresModeration;
	
	$postMan->MailPublishToAdmin($jobInfo);

	if ($postRequiresModeration)
	{
		if ($isNewPost)
			$postMan->MailPublishPendingToUser($job->mPosterEmail);
		
		$html_title = $translations['jobs']['add_success'] . ' / ' . SITE_NAME;
	}
	else
	{
		if (!$job->mIsActive)
			$job->Activate();
		
		if ($isNewPost)
			$postMan->MailPublishToUser($jobInfo);
		
		$html_title = $translations['jobs']['publish_success'] . ' / ' . SITE_NAME;
	}
	
	$smarty->assign('postRequiresModeration', $postRequiresModeration);
	
	redirect_to(BASE_URL . 'confirm/' . $job->mId . '/' . ($postRequiresModeration ? 1: 0) . '/');
	exit;
?>