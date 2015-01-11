<?php
/*
Plugin Name: WP Feedback Form
Plugin URI: https://www.socialappshq.com/web/feedback/intro
Description: Show feedbacks to relevant users instantly to increase conversions, promote a blog post or, a new product.
Author: SocialAppsHQ
Version: 1.1
Author URI: https://www.socialappshq.com/
*/

require_once 'php/admin.php';

if (!class_exists("Feedback")) {
    class Feedback extends WP_Widget
    {
        function Feedback()
        {
            $widget_ops = array('classname' => 'Feedback', 'description' => 'Shows Feedback Bar on Top of your Website' );
            $this->WP_Widget('Feedback', 'Feedback Bar', $widget_ops);
            $feedback = get_option('FeedbackAdminAdminOptions');
            if (empty($feedback['keyword'])) {
                add_action( 'admin_notices', 'feedback_admin_notices');
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

	function add_this_script_footer_feedback(){
		$feedback = get_option('FeedbackAdminAdminOptions');
        echo "<script type='text/javascript'>var _key=_key||{};_key['_key']='".$feedback['api_key']."';_key['_id']='".$feedback['_id']."';(function() {var _st= document.createElement('script');_st.setAttribute('type', 'text/javascript');_st.setAttribute('src', 'http://beta.usersdelight.com:8080/bck_ud.js');document.getElementsByTagName('body')[0].appendChild(_st);})();</script><noscript>Engage using <a href='http://beta.usersdelight.com:8080'>UsersDelight.com</a> apps</noscript>";
    }

    add_action('wp_footer', 'add_this_script_footer_feedback');
    add_action( 'widgets_init', create_function('', 'return register_widget("Feedback");') );
    add_action( 'admin_menu', 'my_feedback_menu' );
}
?>
