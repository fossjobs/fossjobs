<?php
/**
 * Smarty plugin
 * highlights keywords
 */
function smarty_modifier_highlight_keywords($text, $keywords)
{
	if ($keywords)
	{
		foreach ($keywords as $keyword)
		{
			$text = str_ireplace($keyword, '<span class="highlight_keyword">' . $keyword . '</span>', $text);	
		}
	}
	
  return $text;
}
?>