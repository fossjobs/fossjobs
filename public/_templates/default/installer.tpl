<form name="publish_form" id="publish_form" method="post" action="installer.php">
<fieldset>
	Database host(usually localhost):<input type="text" name="host" value="localhost" /><br />
	Database username:<input name="username" type="text" /><br />
	Database password:<input name="password" type="password" /><br />
	Database name:<input name="db_name" type="text" /><br />
	<input type="hidden" name="install" "value="install" />
	<input type="submit" name="submit" id="submit" value="Save" />
</fieldset>
</form>