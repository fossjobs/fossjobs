<?php
/**
 * jobber job board platform
 *
 * @implemented by     Adrian Rusu-Scurtu <adrian.rusu.scurtu@gmail.com>
 * @optimized by       Mihai Mocanu <mihai.mocanu@gmail.com>
 * @license    You are free to edit and use this work, but it would be nice if you always referenced the original author ;)
 *             (see license.txt).
 * 
 * Paginator class handles pagination issues
 */

class Paginator
{
  var $itemsCount;
  var $items_per_page;
  var $current_page;
  var $current_items;
  var $link;
  var $pages_link;
  var $firstLimit;
  var $lastLimit;

  function __construct( $itemsCount, $items_per_page, $current_page = 1 )
  {
    $this->itemsCount = $itemsCount;
    $this->items_per_page = $items_per_page;
    $this->current_page = $current_page;
  }
  
  function getFirstLimit()
  {
  	return $this->firstLimit;
  }

  function getLastLimit()
  {
  	return $this->lastLimit;
  }
  /**
   * Sets the link used in the pages text
   *
   * @param String $link
   */
  function setLink( $link )
  {
    $this->link = $link;
  }

  /**
   * Do the pagination
   *
   * @return array - the current items
   */
  function paginate()
  {
    $total_items = $this->itemsCount;
    
    if( $this->items_per_page == "" || $this->items_per_page == "0" || $this->items_per_page == 0 )
    {
      $this->items_per_page = 10;
    }

    $page = 1;

    if (isset($this->current_page) && $this->current_page!="" && is_numeric($this->current_page))
    {
    	$page = $this->current_page;
    }

    if( $total_items % $this->items_per_page == 0 )
    {
    	$total_pages = $total_items / $this->items_per_page;
    }
    else
    {
    	$total_pages = intval($total_items / $this->items_per_page) + 1;
    }
    
    if( $page > $total_pages )
    {
    	$page = 1;
    }

    if( $page < 1 )
    {
    	$page = 1;
    }

    $temp = array();
    $i = 0;
    $pages = "";
    if(is_numeric($this->itemsCount))
    {
	    $this->firstLimit = $this->items_per_page * ($page-1);
	    $this->lastLimit =  $this->items_per_page * $page;
    }
    
	if ($total_pages != 1)
	{
	    if($total_pages>0)
	    {
	    	if( $page == 1 )
	    	{
				$pages = "&nbsp;";
	    	}
	    	else
	    	{
	    		$pages = "&nbsp;<a href='".$this->link."?p=".($page-1)."'>&laquo;</a>&nbsp;";
	    	}
	    }
	    
        $numberOfPages = 7;
        $beginPages = array(1, 2, 3);
        $endPages = array($total_pages, $total_pages - 1, $total_pages - 2, $total_pages - 3);
        
        if ($total_pages > $numberOfPages) 
        {
            if (in_array($page, $beginPages)) 
            {
                $beginI = 1; $endI = $numberOfPages;
            } 
            elseif (in_array($page, $endPages)) 
            {
                $beginI = $total_pages - ($numberOfPages - 1);
                $endI = $total_pages;
            } 
            else 
            {
                $beginI = $page - 3;
                $endI = $page + 3;
            }
        } 
        else 
        {
            $beginI = 1;
            $endI = $total_pages;
        }
        
	    for($i=$beginI;$i<=$endI;$i++)
	    {
	    	if($i==$page)
	    	{
	    		$pages .= "&nbsp;<a class='current_page' href='".$this->link."?p=$i'>$i</a>&nbsp;";
	    	}
	    	else
	    	{
	    		$pages .= "&nbsp;<a href='".$this->link."?p=$i'>$i</a>&nbsp;";
	    	}
	    }
	    
	    if($total_pages>0)
	    {
	    	if( $page == $total_pages )
	    	{
	    	  $pages .= "&nbsp;";
	    	}
	    	else
	    	{
	    	  $pages .= "&nbsp;<a href='".$this->link."?p=".($page+1)."'>&raquo;</a>&nbsp;";
	    	}
	    }
	}
	else
	{
		$pages = '';
	}
	
    $this->pages_link = $pages;
  }
}
?>
