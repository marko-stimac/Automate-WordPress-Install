<?php 

define('DB_NAME', 'PROJECT_DATABASE');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('WP_HOME','http://localhost/PROJECT_PATHPROJECT_SLUG');
define('WP_SITEURL','http://localhost/PROJECT_PATHPROJECT_SLUG');

define('WP_DEBUG', true);
if (WP_DEBUG) 
{
	define('CONCATENATE_SCRIPTS', false);
	define('SAVEQUERIES', true);
	define('SCRIPT_DEBUG', true);
	define('WP_DEBUG_LOG', true);
	define('WP_DEBUG_DISPLAY', true) ;
	@ini_set('display_errors', 1);
}