<?php
/*
Plugin Name: WP Notification Bar
Plugin URI: https://www.socialappshq.com/web/notification/intro
Description: Show notifications to relevant users instantly to increase conversions, promote a blog post or, a new product.
Author: SocialAppsHQ
Version: 1.1
Author URI: https://www.socialappshq.com/
*/

require_once 'php/admin.php';

if (!class_exists("Notification")) {
    class Notification extends WP_Widget
    {
        function Notification()
        {
            $widget_ops = array('classname' => 'Notification', 'description' => 'Shows Notification Bar on Top of your Website' );
            $this->WP_Widget('Notification', 'Notification Bar', $widget_ops);
            $notification = get_option('NotificationAdminAdminOptions');
            if (empty($notification['keyword'])) {
                add_action( 'admin_notices', 'notification_admin_notices');
            }
        }
        function form($instance)
        {
            $instance = wp_parse_args( (array) $instance, array( 'title' => '' ) );
            $title = $instance['title'];
		}

		function update($new_instance, $old_instance)
		{
			$instance = $old_instance;
			$instance['title'] = $new_instance['title'];
			return $instance;
		}
    }

	function add_this_script_footer(){
		$notification = get_option('NotificationAdminAdminOptions');
		echo "<script type='text/javascript'>var _key=_key||{};_key['_key']='".$notification['api_key']."';_key['_id']='".$notification['_id']."';(function() {var _st= document.createElement('script');_st.setAttribute('type', 'text/javascript');_st.setAttribute('src', '//www.socialappshq.com/socialappsweb.js');document.getElementsByTagName('body')[0].appendChild(_st);})();</script>";
	}

    add_action('wp_footer', 'add_this_script_footer');
    add_action( 'widgets_init', create_function('', 'return register_widget("Notification");') );
    add_action( 'admin_menu', 'my_notification_menu' );
}
?>
