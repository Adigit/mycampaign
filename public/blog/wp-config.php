<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wp_usersdelight');

/** MySQL database username */
define('DB_USER', 'ptlook');

/** MySQL database password */
define('DB_PASSWORD', 'shq123shq!');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '+~/UwHiHfr$=`-5vGx0PGz25JDU{+Aao7|_h[+)kE-w^=-u(v]A132x!.|#IK|T!');
define('SECURE_AUTH_KEY',  'h1do+GuA@15v38*iw_>rZb_v3a19<dh@.!=DmFOi~c7,|OwVA/Txwgy~DznR`eP,');
define('LOGGED_IN_KEY',    'FE+(j%lU[} F(EH2+d6vF,Rj$JW@sL;-|3p}G@n?-%YP(D0!DO+VS|TK#XnWrGFh');
define('NONCE_KEY',        'X+-=L#KC#_b3OB!q?FioYns.ya; M+w#{P,HKSjnuA@$M%-V3:X{<`q{s/&F`=?T');
define('AUTH_SALT',        'ig_8/!-/M$$M+-W.2D^Sb{<{U{JPIk3vY=:QFo%9=TS*hLp|-R?M:KTeGib|[ZNe');
define('SECURE_AUTH_SALT', 'u!#i.Z4iV6&+4ed4mkW}hzx@R#RfOx]s-BRcMa;H.mqNC2jh+#*i8G_glz7*Ku8d');
define('LOGGED_IN_SALT',   '4d5n/Ei!J2r[ND[C|3g/-(=<dvFf~a^3`#uD([v&uOF^1^uOo/0)u{uvUqjyC.C,');
define('NONCE_SALT',       'TZk;/f-%UJ0JqPG+]d_+6p81D|H%Vutbc>o%XN4-4qmVEZhZG@sAp9I.:1|cr-DW');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

/** Enable W3 Total Cache */
define('WP_CACHE', true); // Added by W3 Total Cache

