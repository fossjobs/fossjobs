<?php
	if ($id != '' && !is_numeric($id))
	{
		$feed = new Feed($id);
		if ($feed->mCategoryId != '')
		{
			$feed->Display();
			exit;
		}
		else
		{
			redirect_to(BASE_URL);
		}
	}
	else
	{
		$template = 'rss.tpl';
	}
?>