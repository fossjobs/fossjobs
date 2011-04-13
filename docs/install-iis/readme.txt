For Microsoft URL Rewrite
- copy web.config to your JobberBase root folder
- copy web-admin.config to your JobberBase "admin" folder and rename it to web.config 

For ISAPI Rewrite:
- copy .htaccess to your JobberBase root folder 
(an .htaccess file already exists in the root folder but you can safely overwrite it)
- copy .htaccess-admin to your JobberBase "admin" folder and rename it to .htaccess 
(an .htaccess file already exists in the root folder but you can safely overwrite it) 
- if you still get a 404 (page not found) error, try to uncomment (by removing the # char from the beginning of the line) 
the #RewriteBase / line from your root .htaccess and the #RewriteBase /admin line from your admin .htaccess