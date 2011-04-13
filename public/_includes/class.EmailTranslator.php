<?php
	class EmailTranslator{
	
		private $translations;
		private $xml;
		
		function __construct($languageCode)
		{
			$translationFilePath = APP_PATH . '_templates' . DIRECTORY_SEPARATOR . THEME . DIRECTORY_SEPARATOR . '_translations' . DIRECTORY_SEPARATOR . '_emails' . DIRECTORY_SEPARATOR . 'emails_' . $languageCode . '.xml';

			if (file_exists($translationFilePath)) 
			{
				$this->xml = simplexml_load_file($translationFilePath);
			} 
			else 
			{
				die("Unable to find the email translation file for language $languageCode!");
			}
		}
		
		private function ToNl($str)
		{
			return str_replace('{BR}', "\n", $str); 
		}
		
		public function GetSendToFriendSubject()
		{
			return (string)$this->xml->SendToFriend->subject;
		}
		
		public function GetSendToFriendMsg($my_email)
		{
			$msg = (string)$this->xml->SendToFriend->message;
			$msg = self::ToNl($msg);
			$msg = str_replace('{YOUR_EMAIL}', $my_email, $msg);
			return $msg;
		}
		
		public function GetApplyOnlineSubject($data)
		{
			$msg = (string)$this->xml->ApplyOnline->subject;
			$msg = str_replace('{JOB_TITLE}', $data['job_title'], $msg);
			$msg = str_replace('{SITE_NAME}',SITE_NAME, $msg);
			return $msg;
		}
		
		public function GetApplyOnlineMsg($referer)
		{
			$msg = (string)$this->xml->ApplyOnline->message;
			$msg = self::ToNl($msg);
			$msg = str_replace('{JOB_URL}', $referer, $msg);
			return $msg;
		}
		
		public function GetPublishToAdminSubject($data)
		{
			if ($data['isNewPost'])
			{
				$msg = (string)$this->xml->PublishToAdmin->newPostSubject;
			}
			else
			{
				$msg = (string)$this->xml->PublishToAdmin->editedPostSubject;
			}
			
			$msg = str_replace('{JOB_TITLE}', $data['title'], $msg);
			$msg = str_replace('{SITE_NAME}', SITE_NAME, $msg);
			return $msg;
		}
		
		public function GetPublishToAdminMsg($data)
		{
			$msg = (string)$this->xml->PublishToAdmin->message;
			$msg = str_replace('{JOB_URL}', $data['job_url'], $msg);
			$msg = str_replace('{JOB_TITLE}', $data['title'], $msg);
			$msg = str_replace('{JOB_COMPANY}', $data['company'], $msg);
			$msg = str_replace('{JOB_DESCRIPTION}', $data['description'], $msg);
			$msg = str_replace('{JOB_POSTER_EMAIL}', $data['poster_email'], $msg);
			$msg = str_replace('{JOB_EDIT_URL}', $data['edit_url'], $msg);
			$msg = str_replace('{JOB_DEACTIVATE_URL}', $data['deactivate_url'], $msg);
			$msg = str_replace('{JOB_POSTER_IP}', $data['poster_ip'], $msg);
			$msg = str_replace('{JOB_POST_DATE}', $data['created_on'], $msg);
			$msg = self::ToNl($msg);
			return $msg;
		}
		
		public function GetPublishToAdminExtraMsg($activateUrl)
		{
			$msg = (string)$this->xml->PublishToAdmin->messageFirstPost;
			$msg = str_replace('{JOB_ACTIVATE_URL}', $activateUrl, $msg);
			$msg = self::ToNl($msg);
			return $msg;
		}
		
		public function GetPublishPendingToUserSubject()
		{
			$msg = (string)$this->xml->PublishPendingToUser->subject;
			$msg = str_replace('{SITE_NAME}',SITE_NAME, $msg);
			return $msg;
		}
		
		public function GetPublishPendingToUserMsg()
		{
			$msg = (string)$this->xml->PublishPendingToUser->message;
			$msg = self::ToNl($msg);
			return $msg;
		}
		
		public function GetPublishToUserSubject()
		{
			$msg = (string)$this->xml->PublishToUser->subject;
			$msg = str_replace('{SITE_NAME}',SITE_NAME, $msg);
			return $msg;
		}
		
		public function GetPublishToUserMsg($data)
		{
			$msg = (string)$this->xml->PublishToUser->message;
			$msg = str_replace('{JOB_URL}', $data['job_url'], $msg);
			$msg = str_replace('{JOB_EDIT_URL}', $data['edit_url'], $msg);
			$msg = str_replace('{JOB_DEACTIVATE_URL}', $data['deactivate_url'], $msg);
			$msg = str_replace('{SITE_NAME}',SITE_NAME, $msg);
			$msg = self::ToNl($msg);
			return $msg;
		}

		public function GetReportSpamSubject($jobTitle)
		{
			$msg = (string)$this->xml->ReportSpam->subject;
			$msg = str_replace('{SITE_NAME}',SITE_NAME, $msg);
			$msg = str_replace('{JOB_TITLE}',$jobTitle, $msg);
			return $msg;
		}
		
		public function GetReportSpamMsg($data)
		{
			$msg = (string)$this->xml->ReportSpam->message;
			$msg = str_replace('{JOB_URL}', $data['job_title'], $msg);
			$msg = str_replace('{JOB_TITLE}', $data['title'], $msg);
			$msg = str_replace('{JOB_COMPANY}', $data['company'], $msg);
			$msg = str_replace('{JOB_DESCRIPTION}', $data['description'], $msg);
			$msg = str_replace('{JOB_POSTER_EMAIL}', $data['poster_email'], $msg);
			$msg = str_replace('{JOB_EDIT_URL}', $data['edit_url'], $msg);
			$msg = str_replace('{JOB_DEACTIVATE_URL}', $data['deactivate_url'], $msg);
			$msg = str_replace('{JOB_POSTER_IP}', $data['poster_ip'], $msg);
			$msg = str_replace('{JOB_POST_DATE}', $data['created_on'], $msg);
			$msg = self::ToNl($msg);
			return $msg;
		}
		
		public function GetContactSubject()
		{
			$msg = (string)$this->xml->Contact->subject;
			$msg = str_replace('{SITE_NAME}',SITE_NAME, $msg);
			return $msg;
		}
		
		public function GetContactMsg($data)
		{
			$msg = (string)$this->xml->Contact->message;
			$msg = str_replace('{SENDER_NAME}', $data['sender_name'], $msg);
			$msg = str_replace('{SENDER_EMAIL}', $data['sender_email'], $msg);
			$msg = str_replace('{SENDER_IP}', $data['poster_ip'], $msg);
			$msg = str_replace('{SEND_DATE}',$data['created_on'], $msg);
			$msg = self::ToNl($msg);
			return $msg;
		}
	}
?>