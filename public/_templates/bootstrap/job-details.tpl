<div class="column is-9">
<div class="box content">
			<div class="content job-details">

				<h6>Job details <small><a href="{$back_link}" title="category home">&laquo; {$translations.notfound.back}</a></small></h6>
				{if $smarty.session.apply_successful AND $smarty.session.apply_successful eq 1}
				<div class="alert-message block-message success">
					<p>{$translations.apply.success}</p>
				</div>
				{/if}
				
				{if ($job.days_old > $smarty.const.OLD_JOB_NOTIFY) && ($smarty.const.OLD_JOB_NOTIFY > 0)}
				<div class="alert-message block-message error">
					<p>{$translator->translate("apply.old_ad", $smarty.const.OLD_JOB_NOTIFY)}</p>
				</div>
				{/if}
				<div class="row"><!-- Start job /-->
					<div class="span10 details-page">
						<h5><span class="label {$job.type_var_name}">{$job.type_name}</span> {$job.title} </h5>
						<span>{$translator->translate("jobs.published_at", "<strong>`$job.created_on`</strong>")} - {$translator->translate("jobs.viewed", "<strong>`$job.views_count`</strong>")} - 
						{if $job.url && $job.url != 'http://'}
						<a href="{$job.url}">{$job.company}</a>
						{else}
						<strong>{$job.company}</strong>
						{/if}
						{if $job.is_location_anywhere}
						<strong>({$translations.jobs.location_anywhere})</strong>
						{else}
						<span>{$translations.homepage.in}</span> <strong>{$job.location}</strong>
						{/if}
						</span>
					</div>
					
				</div><!-- End job /-->
				<div class="job-description">
					<p>{$job.description}</p>
				</div>
				{if $job.url && $job.url != 'http://'}
				<div class="job-link">
					<p><a href="{$job.url}">{$job.url}</a></p>
				</div>
				{/if}
				</div>
				<div class="recent-jobs zebra-striped"><!-- Recent Jobs /-->	
			{include file="company-posts-loop.tpl"}
			</div><!-- End Recent Jobs /-->
			</div><!-- End Recent Jobs /-->

</div>
</div>