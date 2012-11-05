{include file="header.tpl"}
		
		<div class="row jobmain">
			{include file="sidebar.tpl"}
			
			<div class="span12">
			<div class="job-details zebra-striped"><!-- Recent Jobs /-->
				<h6>
					{$translations.companies.jobs_at} {$current_company}
				</h6>
				{include file="posts-loop.tpl"}
			</div><!-- End Recent Jobs /-->
		</div><!-- #content -->	
		</div>
{include file="footer.tpl"}