<?php
/**
 * jobberbase form validation class
 *
 * @author     Erik Goverde  <http://chronoscripts.com> <chronos@chronoscripts.com>
 * @license    You are free to edit and use this work, but please keep the credits.
 * 
 */

class FormValidator
{
	var $_errorList;
	
	function __construct()
	{
		$this->resetErrorList();
	}

	// function to get the value of a variable (field)
	function _getValue($field)
	{
		$value = $_POST[$field];
		return $value;
	}

	function isEmpty($field, $msg = false)
	{
		$value = $this->_getValue($field);
		if ($msg == false) $msg = 'The field <strong>'.$field.'</strong> must be filled in.';

		if (trim($value) == '')
		{
			$this->_errorList[$field][] = $msg;
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function isNumber($field, $msg = false)
	{
		$value = $this->_getValue($field);
		if ($msg == false) $msg = 'The field <strong>'.$field.'</strong> must be a numeric value.';
		
		if(!is_numeric($value))
		{
			$this->_errorList[$field][] = $msg;
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function isAlpha($field, $msg = false)
	{
		$value = $this->_getValue($field);
		if ($msg == false) $msg = 'The field <strong>'.$field.'</strong> may only contain characters from a-z and A-Z.';
		
		$pattern = "/^[a-zA-Z]+$/";
		
		if(preg_match($pattern, $value))
		{
			return true;
		}
		else
		{
			$this->_errorList[$field][] = $msg;
			return false;
		}
	}
	
	function isUrlString($field, $msg = false)
	{
		$value = $this->_getValue($field);
		if ($msg == false) $msg = 'The field <strong>'.$field.'</strong> is not a valid URL-string. Available characters are a-z, 0-9, _ and -.';
		
		$pattern = "/^[a-zA-Z\-_]+$/";
		
		if(preg_match($pattern, $value))
		{
			return true;
		}
		else
		{
			$this->_errorList[$field][] = $msg;
			return false;
		}
	}
	
	// check whether input is a valid email address
	function isEmailAddress($field, $msg = false)
	{
		$value = $this->_getValue($field);
		if ($msg == false) $msg = 'The field <strong>'.$field.'</strong> is not a valid email-address.';
				
		$pattern = "/^([a-zA-Z0-9])+([\.a-zA-Z0-9_-])*@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-]+)+/";
		
		if(preg_match($pattern, $value))
		{
			return true;
		}
		else
		{
			$this->_errorList[$field][] = $msg;
			return false;
		}
	}

	// check whether any errors have occurred in validation
	// returns Boolean
	function isError()
	{
		if (sizeof($this->_errorList) > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	// return the current list of errors
	function getErrorList()
	{
		return $this->_errorList;
	}
	
	// reset the error list
	function resetErrorList()
	{
		$this->_errorList = array();
	}

}