{include file="header.tpl"}
		
		<div id="content">
			<div id="left-content">
				<div id="job-listings">
					<h2>
						{$translations.companies.jobs_at} {$current_company}
					</h2>
					{include file="posts-loop.tpl"}
				</div><!-- #job-listings -->
			</div><!--#left-content-->
			<div id="sidebar">
				{include file="sidebar.tpl"}
			</div><!-- #sidebar -->
		</div><!-- #content -->

{include file="footer.tpl"}