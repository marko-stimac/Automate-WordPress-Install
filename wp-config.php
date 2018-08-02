<?php

if (file_exists(dirname(__FILE__) . '/wp-config-local.php')) {
    require_once dirname(__FILE__) . '/wp-config-local.php';
} else {
    define('DB_NAME', '');
    define('DB_USER', '');
    define('DB_PASSWORD', '');
    define('WP_HOME', 'https://www.website.com/_new');
    define('WP_SITEURL', 'https://www.website.com/_new');
    
    define('WP_DEBUG', false);
    define('WP_DEBUG_DISPLAY', false);
    define('DISALLOW_FILE_EDIT', true);
    define('WP_POST_REVISIONS', 5);
    define('FORCE_SSL_LOGIN', true);
    define('AUTOSAVE_INTERVAL', 120);
    define('AUTOMATIC_UPDATER_DISABLED', true);
    define('COMPRESS_CSS', true);
    define('COMPRESS_SCRIPTS', true);
    define('CONCATENATE_SCRIPTS', true);
    define('ENFORCE_GZIP', true);
}

define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8mb4');
$table_prefix = 'bi_';

// https://api.wordpress.org/secret-key/1.1/salt
define('AUTH_KEY', '(2;Hqf<0z.;r~l_O.KB$}O/&zf!b:2s=x@*b)X?;s/|vpI,dJj(_eGf=6fc2yDYWN');
define('SECURE_AUTH_KEY', 'jul+-51]O:!<pju}g^>kus4ptn*.tSs`x=4L(t|+E<f0a>v+W[`WAy#AD;=uuikZW');
define('LOGGED_IN_KEY', ',q#KYRONQ/|sC?C/|(5vhsS |[!_Usx4GsS.TxdfMkLM*M1U$29Yd7H1E}!&$!=NUZ');
define('NONCE_KEY', 'W[U/EN72iTyK:5J-~^4HI||#k<[JUq]Zf|Ip/_eu0f6^};Q4#5J@QcMS+7nmt#VH');
define('AUTH_SALT', '.r[vt+Zo+K:3qV.nZdc#%=F$#(Cm6=G}i`7OMjJ}|Mk6ox2tN`T]8T+z//),[uAS');
define('SECURE_AUTH_SALT', 'yfW4H+F+.)resz;p/~d5 V+D;u6) eNf5wpF(-Z+22z)@,f_ldOhE%tV}=1iN10BF');
define('LOGGED_IN_SALT', '#P^Ko-xZg_nx C.sh)~,U+o<|p_Cd=NC=-Wc1 kB/!DEu.-0jv{/B]!B jfl Fo)8');
define('NONCE_SALT', ',q{wm4,R]tI0kBU-&sE=hNsR-dz0UDRWP  6Gx8^4h ic2m[^{7MeZY$5_WBh<y-v');

if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/');
}
require_once(ABSPATH . 'wp-settings.php');
