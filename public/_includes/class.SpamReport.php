<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * SpamReport handles users reporting a job ad as spam or problematic
 */

class SpamReport
{
	var $mIp = false;
	var $mJobId = false;
	var $mCanReport = false;
	
	public function __construct($job_id)
	{
		global $db;
		if (is_numeric($job_id))
		{
			$this->mIp = $_SERVER['REMOTE_ADDR'];
			$this->mJobId = $job_id;
			$sql = 'SELECT id
			               FROM '.DB_PREFIX.'spam_reports
			               WHERE job_id = ' . $this->mJobId . ' AND ip = "' . $this->mIp . '" AND DATE_ADD(the_time, INTERVAL ' . REPORT_POST_AGAIN_AFTER . ' MINUTE) > NOW()';
			$result = $db->query($sql);
			$row = $result->fetch_assoc();
			if (empty($row))
			{
				$this->mCanReport = true;
			}
			else
			{
				$this->mCanReport = false;
			}
		}
		else
		{
			$this->mCanReport = false;
		}
	}
	
	// Report a job post as spam
	public function PostIsSpam()
	{
		global $db;
		if ($this->mCanReport)
		{
			$sql = 'INSERT INTO '.DB_PREFIX.'spam_reports (the_time, ip, job_id)
			                    VALUES (NOW(), "' . $this->mIp . '", ' . $this->mJobId . ')';
			if ($db->query($sql))
			{
				if ($this->GetTotalVotesPerPost() > REPORT_POST_NOTIFY_ON)
				{
					$job = new Job($this->mJobId);
					$mihai = new Postman();
					$mihai->MailReportSpam($job->GetInfo());
				}
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}
	
	public function GetTotalVotesPerPost()
	{
		global $db;
		$sql = 'SELECT COUNT(id) AS total
		               FROM '.DB_PREFIX.'spam_reports
		               WHERE job_id = ' . $this->mJobId;
		$result = $db->query($sql);
		$row = $result->fetch_assoc();
		return $row['total'];
	}
}
?>