<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * Function validates an e-mail address
 *
 * @param string $string		E-mail address to be validated
 */

function validate_email($string) 
{
	$string = strtolower($string); 	
	return preg_match("/^[^@]+@[^@]+\.[a-z]{2,6}$/i", $string);
}

?>
