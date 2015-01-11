<?php
/*
Plugin Name: Twitter Widget with Tweet Reach
Plugin URI: https://www.socialappshq.com/
Description: Twitter widget shows tweets for any search keyword, hashtag or, handle as well as it computes and shows sentiment analysis and trends if the volume is high enough.
Author: SocialAppsHQ
Version: 1.1
Author URI: https://www.socialappshq.com/
*/

require_once 'php/admin.php';

if (!class_exists("TwitterWidget")) {
    class TwitterWidget extends WP_Widget
    {

      function TwitterWidget()
      {
        $widget_ops = array('classname' => 'TwitterWidget', 'description' => 'Tracks & Displays tweets with sentiment analysis' );
        $this->WP_Widget('TwitterWidget', 'Twitter Widget with Sentiment', $widget_ops);

        // Here you can check if plugin is configured (e.g. check if some option is set). If not, add new hook.
        // In this example hook is always added.

        $monitoring_variables = get_option('TwitterAdminAdminOptions');
        if (empty($monitoring_variables['keyword'])) {
            add_action( 'admin_notices', 'twitter_admin_notices');
        }
      }

      function form($instance)
      {
        $instance = wp_parse_args( (array) $instance, array( 'title' => '' ) );
        $title = $instance['title'];
    ?>
      <p><label for="<?php echo $this->get_field_id('title'); ?>">Title: <input class="widefat" id="<?php echo $this->get_field_id('title'); ?>" name="<?php echo $this->get_field_name('title'); ?>" type="text" value="<?php echo attribute_escape($title); ?>" /></label></p>
    <?php
      }

      function update($new_instance, $old_instance)
      {
        $instance = $old_instance;
        $instance['title'] = $new_instance['title'];
        return $instance;
      }

      function widget($args, $instance)
      {
        extract($args, EXTR_SKIP);

        $site_url = 'https://widget.socialappshq.com'; // live
        
        echo $before_widget;
        $title = empty($instance['title']) ? ' ' : apply_filters('widget_title', $instance['title']);

        if (!empty($title))
			echo $before_title . $title . $after_title;;

			// WIDGET CODE GOES HERE
			$monitoring_variables = get_option('TwitterAdminAdminOptions');
			$height = intval($monitoring_variables['shq_h']);
		
			if (empty($height)) {
				$height = 400;
			}
			$iframe_height = $height+45;
			$iframe_width = intval($monitoring_variables['shq_c_wi'])+10;

			// configuration section
			$config_sidebar = "";
			$config_sidebar = "&c_b=".$monitoring_variables['shq_c_b']."&c_f=".$monitoring_variables['shq_c_f']."&c_h_c=".$monitoring_variables['shq_c_h_c']."&c_bg=".$monitoring_variables['shq_c_bg']."&c_f_c=".$monitoring_variables['shq_c_f_c']."&w=".$monitoring_variables['shq_c_wi']."&h=".$height;

			echo "<div style='text-align:left;width:".($iframe_width+12)."px;'><iframe id='shq-iframe-1355914507' style='height:".$iframe_height."px; width:".$iframe_width."px;border:none;' src='".$site_url."/widget/twitter/?q=".$monitoring_variables['keyword']."&em=".$monitoring_variables['email'].$config_sidebar."'></iframe>";

			if(($monitoring_variables['show_socialapp_link']==1)){
				echo "<br/><span style='font-size:10px;font-family:arial;text-align: center;margin-left: 10px;margin-top: -20px;'>
				<a href='https://www.socialappshq.com/widget/landing' style='cursor:pointer;text-decoration:none;color:#3F6EBA;' target='_blank'>Get Widget</a> from 
				<a href='https://www.socialappshq.com' target='_blank' style='cursor:pointer;text-decoration:none;color:#3F6EBA;'>SocialAppsHQ</a></span></div>";
			}

			echo $after_widget;
		}

    }
}

add_action( 'widgets_init', create_function('', 'return register_widget("TwitterWidget");') );
add_action( 'admin_menu', 'my_twitter_menu' );

?>
