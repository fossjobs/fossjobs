<?php
/**
 * jobber job board platform
 *
 * @author     Filip C.T.E. <http://www.filipcte.ro> <me@filipcte.ro>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * Function used for debug. Prettifies print_r.
 *
 * @param $value		Any variable type
 */

function printr($value)
{
   echo '<div style="position: relative; z-index: 10000; float: left; clear: both;"><table border="0" cellspacing="0" cellpadding="5"><tr>' .
      '<td bgcolor="#C0C000"><font size="1" face="verdana" color="#000000"><b>Debug</b></font></td>' .
      '</tr><tr><td bgcolor="#000000"><pre><font size="1" face="verdana" color="#FFFFFF">'; 

   print_r($value);
      
   echo '</font></pre></td></tr></table></div><div style="clear: both; height: 1px;"></div>';
}

?>