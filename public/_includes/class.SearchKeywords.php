<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * SearchKeywords class keeps track on what people search on the site
 */

class SearchKeywords
{
	var $mKeywords = false;
	
	function __construct($keywords)
	{ 
		$this->mKeywords = $keywords;
	}
	
	// save recorded keywords, if available
	public function Save()
	{
		global $db;
		$sql = 'INSERT INTO '.DB_PREFIX.'searches (keywords, created_on) VALUES ("' . $this->mKeywords . '", NOW())';
		$db->query($sql);
	}
}
?>