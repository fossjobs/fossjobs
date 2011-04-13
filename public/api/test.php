<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>jobberBase API test</title>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
	<script src="api.php?action=getJobs&amp;type=0&amp;category=0&amp;count=5&amp;random=1&amp;days_behind=7&amp;response=js" type="text/javascript"></script>
	<style>
		ul.jobber-list {
			list-style-type: none;
			margin: 0;
			padding: 0;
		}
		ul.jobber-list li {
			margin-bottom: 5px;
		}
	</style>
</head>

<body>
	<div id="container">
		<h1>latest jobs on jobber</h1>
		<div id="jobber_container"></div>
	</div><!-- #container -->
	<script type="text/javascript">
		// 1st param is the id of the html element where we'll inject the content
		// 2nd param is the css class used to style the content
		showJobs('jobber_container', 'jobber-list');
	</script>
</body>
</html>