<?php
  if (!class_exists("NotificationAdmin")) {
	class NotificationAdmin {
		var $adminOptionsName = "NotificationAdminAdminOptions";
		function NotificationAdmin() {
		}
		function init() {
			$this->getAdminOptions();
		}
		function getAdminOptions() {
			//$devloungeAdminOptions = array('api_key' => 'sasa ', '_id' => '1', 'email' => get_option('admin_email'), 'name' => get_bloginfo('name'), 'domain' => 'www.shq.com', 'border_color' =>'ffff', 'background_color' => 'CCCCC', 'text_color' => 'CCCCCC', 'opacity' => 1, 'close_notification' => 1, 'notification_msg' => 'Enter your text', 'fixed_position' => 1, 'push_down' => 1, 'align_content' => 1, 'action_background_color' => 'fffff', 'action_text_color' => 'gggg', 'action_border_color' => 'hhhh', 'call_action_text' => 'click here', 'action_button_url' => 'Call to action url', 'new_window' => 1 );
                        $devloungeAdminOptions = array('api_key' => 'a1b345n3 ', '_id' => '1', 'email' => get_option('admin_email'), 'name' => get_bloginfo('name'), 'domain' => 'www.shq.com', 'border_color' =>'fff', 'background_color' => 'eb593c', 'text_color' => 'fff', 'opacity' => 1.0, 'close_notification' => 1, 'notification_msg' => 'Enter your notification text here.', 'fixed_position' => 0, 'push_down' => 1, 'align_content' => 0, 'action_background_color' => '000', 'action_text_color' => 'fff', 'action_border_color' => '000', 'call_action_text' => 'Click!', 'action_button_url' => 'Call to Action Url', 'new_window' => 0 );
			$devOptions = get_option($this->adminOptionsName);
			if (!empty($devOptions)) {
				foreach ($devOptions as $key => $option)
					$devloungeAdminOptions[$key] = $option;
			}
			update_option($this->adminOptionsName, $devloungeAdminOptions);
                        remove_action( 'admin_notices', 'notification_admin_notices' );
			return $devloungeAdminOptions;
		}

		function addContent($keyword = '') {
			$devOptions = $this->getAdminOptions();
			if ($devOptions['add_content'] == "true") {
				$keyword .= $devOptions['keyword'];
			}
			return $keyword;
		}
		function printAdminPage() {
                    $devOptions = $this->getAdminOptions();

                    if (isset($_POST['update_devloungePluginSeriesSettings'])) {
                        if (isset($_POST['devloungeApikey'])) {
                                $devOptions['api_key'] = apply_filters('keyword_save_pre', $_POST['devloungeApikey']);
                        }
                        if (isset($_POST['devloungeId'])) {
                                $devOptions['_id'] = apply_filters('keyword_save_pre', $_POST['devloungeId']);
                        }
                        if (isset($_POST['devloungeEmail'])) {
                                $devOptions['email'] = apply_filters('keyword_save_pre', $_POST['devloungeEmail']);
                        }

                        if (isset($_POST['devloungeName'])) {
                                $devOptions['name'] = apply_filters('keyword_save_pre', $_POST['devloungeName']);
                        }

                        if (isset($_POST['devloungeDomain'])) {
                                $devOptions['domain'] = apply_filters('keyword_save_pre', $_POST['devloungeDomain']);
                        }

                        if (isset($_POST['devloungeBorderColor'])) {
                                $devOptions['border_color'] = apply_filters('keyword_save_pre', $_POST['devloungeBorderColor']);
                        }
                        if (isset($_POST['devloungeBackgroundColor'])) {
                                $devOptions['background_color'] = apply_filters('keyword_save_pre', $_POST['devloungeBackgroundColor']);
                        }
                        if (isset($_POST['devloungeTextColor'])) {
                                $devOptions['text_color'] = apply_filters('keyword_save_pre', $_POST['devloungeTextColor']);
                        }
                        if (isset($_POST['devloungeOpacity'])) {
                                $devOptions['opacity'] = apply_filters('keyword_save_pre', $_POST['devloungeOpacity']);
                        }
                        if (isset($_POST['devloungeCloseNotification'])) {
                                $devOptions['close_notification'] = apply_filters('keyword_save_pre', $_POST['devloungeCloseNotification']);
                        }

                        if (isset($_POST['devloungeNotificationMsg'])) {
                                $devOptions['notification_msg'] = apply_filters('keyword_save_pre', $_POST['devloungeNotificationMsg']);
                        }

                        if (isset($_POST['devloungeFixedPosition'])) {
                                $devOptions['fixed_position'] = apply_filters('keyword_save_pre', $_POST['devloungeFixedPosition']);
                        }
                        if (isset($_POST['devloungePushDown'])) {
                                $devOptions['push_down'] = apply_filters('keyword_save_pre', $_POST['devloungePushDown']);
                        }
                        if (isset($_POST['devloungeAlignContent'])) {
                                $devOptions['align_content'] = apply_filters('keyword_save_pre', $_POST['devloungeAlignContent']);
                        }
                        if (isset($_POST['devloungeActionBackgroundColor'])) {
                                $devOptions['action_background_color'] = apply_filters('keyword_save_pre', $_POST['devloungeActionBackgroundColor']);
                        }
                        if (isset($_POST['devloungeActionTextColor'])) {
                                $devOptions['action_text_color'] = apply_filters('keyword_save_pre', $_POST['devloungeActionTextColor']);
                        }
                        if (isset($_POST['devloungeActionBorderColor'])) {
                                $devOptions['action_border_color'] = apply_filters('keyword_save_pre', $_POST['devloungeActionBorderColor']);
                        }
                        if (isset($_POST['devloungeCallActionText'])) {
                                $devOptions['call_action_text'] = apply_filters('keyword_save_pre', $_POST['devloungeCallActionText']);
                        }
                        if (isset($_POST['devloungeActionButtonUrl'])) {
                                $devOptions['action_button_url'] = apply_filters('keyword_save_pre', $_POST['devloungeActionButtonUrl']);
                        }

                        if (isset($_POST['devloungeNewWindow'])) {
                                $devOptions['new_window'] = apply_filters('keyword_save_pre', $_POST['devloungeNewWindow']);
                        }

                        update_option($this->adminOptionsName, $devOptions);

                        ?>
                        <div class="updated"><p><strong><?php _e("Settings Updated.", "NotificationAdmin");?></strong></p></div>
                        <?php
                        } ?>

                        <style>

                            .wrap h3{float: left;width:400px;margin:10px 10px 0 0;font-weight:normal}
                            .wrap p{float: left; max-width:300px;margin:0}
                            .wrap small{float: left; width:100%;margin:0}
                            .wrap .input_color{width:200px}
                            .wrap .input_kwd{width:200px; margin-left:10px;}
                            .wrap .row{float:left;width:100%; margin:5px 0;}
                            .wrap .title{font-weight:bold;}
                            .wrap .input_font{margin-left:10px; width:200px}
                            .wrap .che{margin:0px; -webkit-border-radius:0px  !important;-moz-border-radius:0px  !important;border-radius:0px !important; }
                            .wrap p input{background-color: #ffffff;
                                          border: 1px solid #cccccc;
                                          -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
                                          -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
                                          box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
                                          -webkit-transition: border linear .2s, box-shadow linear .2s;
                                          -moz-transition: border linear .2s, box-shadow linear .2s;
                                          -o-transition: border linear .2s, box-shadow linear .2s;
                                          transition: border linear .2s, box-shadow linear .2s; margin-top:5px;
                                        }
                            .wrap p input:hover{border-color: rgba(82, 168, 236, 0.8);
                              outline: 0;
                              outline: thin dotted \9;


                              -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(82,168,236,.6);
                              -moz-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(82,168,236,.6);
                              box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(82,168,236,.6);
                            }

                            .btn-primary {
                              cursor: pointer;
                              color: #ffffff !important;
                              text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25) !important;
                              background-color: #006dcc !important;
                              background-image: -moz-linear-gradient(top, #0088cc, #0044cc)!important;
                              background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0088cc), to(#0044cc))!important;
                              background-image: -webkit-linear-gradient(top, #0088cc, #0044cc)!important;
                              background-image: -o-linear-gradient(top, #0088cc, #0044cc)!important;
                              background-image: linear-gradient(to bottom, #0088cc, #0044cc)!important;
                              background-repeat: repeat-x;
                              filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0088cc', endColorstr='#ff0044cc', GradientType=0);
                              border-color: #0044cc #0044cc #002a80 !important;
                              border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25)!important;
                              *background-color: #0044cc !important;
                              /* Darken IE7 buttons by default so they stand out more given they won't have borders */

                              filter: progid:DXImageTransform.Microsoft.gradient(enabled = false);-webkit-border-radius:3px;-moz-border-radius:3px;border-radius:3px; padding:10px; text-align:center; text-decoration:none; }

                            .btn-primary:hover{
                             color: #ffffff !important;
                              background-color: #0044cc !important; }

.btn-success {
color: #ffffff;border-radius:3px;padding: 10px;
text-decoration: none;
border: 1px solid #098C06;-moz-border-radius:3px;-webkit-border-radius:3px;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
  background-color: #5bb75b;
  *background-color: #51a351;
  background-image: -moz-linear-gradient(top, #62c462, #51a351);
  background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#62c462), to(#51a351));
  background-image: -webkit-linear-gradient(top, #62c462, #51a351);
  background-image: -o-linear-gradient(top, #62c462, #51a351);
  background-image: linear-gradient(to bottom, #62c462, #51a351);
  background-repeat: repeat-x;
  border-color: #51a351 #51a351 #387038;
  border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr=&#039;#ff62c462&#039;, endColorstr=&#039;#ff51a351&#039;, GradientType=0);
  filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
}

.btn-success:hover,
.btn-success:active,
.btn-success.active,
.btn-success.disabled,
.btn-success[disabled] {color: #ffffff;  background-color: #51a351;  *background-color: #499249;}
.btn-success:active,
.btn-success.active { background-color: #408140 \9;}
.wrap h2{float: left;width: 100%;}
.wrap {float: left;width: 100%;}
</style>
<script type="text/javascript" >
var response_received = 0;
function submit_form() {
    var name = jQuery('#name').val();
    var email = jQuery('#email').val();
    var domain = jQuery('#domain').val();
    var notification_msg = jQuery('#notification_text').val();
    var call_action_text = jQuery('#act_text').val();
    var action_button_url = jQuery('#act_btn_url').val();
    var new_window = jQuery("#new_window").is(':checked')?1:0;
    var close_notification = jQuery('#close_notification').is(':checked')?1:0;
    var fixed_position = jQuery('#fixed_position').is(':checked')?1:0;
    var push_down = jQuery('#push_down').is(':checked')?1:0;
    var align_content = jQuery('input[name=devloungeAlignContent]:radio:checked').val();
    var background_color = jQuery('#background_color').val();
    var border_color = jQuery('#border_color').val();
    var text_color = jQuery('#text_color').val();
    var action_background_color = jQuery('#action_background_color').val();
    var action_text_color = jQuery('#action_text_color').val();
    var action_border_color = jQuery('#action_border_color').val();
    var opacity = jQuery('#opacity').val();
    dataString = "name="+name+"&email="+email+"&domain="+domain+"&message="+notification_msg+"&action_text="+call_action_text+"&action_url="+action_button_url+"&new_window="+new_window+"&close="+close_notification+"&fixed="+fixed_position+"&push_down="+push_down+"&alignment="+align_content+"&bg_c="+background_color+"&bor_c="+border_color+"&txt_c="+text_color+"&act_bg_c="+action_background_color+"&act_txt_c="+action_text_color+"&act_bor_c="+action_border_color+"&opacity="+opacity;
    jQuery("#status").html('<img src="<?php echo site_url()?>/wp-content/plugins/notification-bar/images/ajax-loader.gif">');
    jQuery("#status").show();
    jQuery.ajax({
        url: "https://www.socialappshq.com/api/wp/notifier",
        type: "POST",
        data :dataString,
        dataType:'jsonp',
        success:function(response_data){
            jQuery("#set_api_key").val(response_data['api_key']);
            jQuery('#set_api_id').val(response_data['_id']);
            var a = location.hostname;
            jQuery("#domain").val(a);
            response_received = 1;
            jQuery("#status").html('Successfully updated');
        },
          error:function(response_data){
         }
        });
  };

  function waitForElement(){
    if (response_received == 1) {
       jQuery.post('<?php echo site_url() ?>/wp-admin/admin.php?page=notification-menu-id', jQuery('#notifier_form').serialize());
      }
    else{
        setTimeout(function(){
            waitForElement();
        },250);
    }
}
jQuery(document).ready(function(){
  jQuery('#notifier_form').submit(function (e) {
    e.preventDefault();
    submit_form();
    waitForElement();
  })
})
</script>
                                <div class="wrap">
                                <div style="float:left;width:60%">

                                <form method="post" action="#" id="notifier_form">
                                  <h2>Notification color setting</h2>
                                <div class="row" style="width: 90%;"><hr></div>

                                <input type="hidden" id="set_api_key" name="devloungeApikey" value="<?php echo $devOptions['api_key'] ?>"/>
                                <input type="hidden" id="set_api_id" name="devloungeId" value="<?php echo $devOptions['_id'] ?>"/>
                                <input type="hidden" name="update_devloungePluginSeriesSettings" value="1"/>

                                <div class="row">
                                  <h3>Email</h3>
                                  <p><input id="email" name="devloungeEmail" class="input_color" value="<?php echo $devOptions['email'] ?>"></p>
                                  <small>e.g  yourname@example.com</small>
                                </div>
                                
                                <input type="hidden" id="name" name="devloungeName" class="input_color" value="<?php echo $devOptions['name'] ?>">                                
                                <input type="hidden" id="domain" name="devloungeDomain" class="input_color" value="<?php echo $devOptions['domain'] ?>">
                                
                                <div class="row">
                                  <h3>Border Color</h3>
                                  <p>#<input id="border_color" name="devloungeBorderColor" class="input_color" value="<?php echo $devOptions['border_color'] ?>"></p>
                                  <small>e.g. fff</small>
                                </div>

                                <div class="row">
                                  <h3>Background color</h3>
                                  <p>#<input id="background_color" name="devloungeBackgroundColor" class="input_color" value="<?php echo $devOptions['background_color'] ?>"></p>
                                  <small>e.g. fff</small>
                                </div>
                               <div class="row">
                                  <h3>Text color color</h3>
                                  <p>#<input id="text_color" name="devloungeTextColor" class="input_color" value="<?php echo $devOptions['text_color'] ?>"></p>
                                  <small>e.g. 000</small>
                               </div>
                                <div class="row">
                                  <h3>Opacity</h3>
                                  <p><input id="opacity" style="width: auto !important;" id="opacity" name="devloungeOpacity" value="<?php echo $devOptions['opacity'] ?>"></p>
                                  <small>Lies between 0 to 1</small>
                                </div>
                               <div class="row">
                                  <h3>Allow users to close notification?</h3>
                                   <?php
                                       if($devOptions['close_notification'] == 1) {
                                                 $select = 'checked';
                                   }
                                        else {
                                                     $select = '';
                                 } ?>

                                 <input type="hidden" name="devloungeCloseNotification" value="0"/>
                                 <p><input id="close_notification" type="checkbox" name="devloungeCloseNotification" value="1"<?php echo $select ?>>Yes</p>

                             </div>
                             <br/>

                                <div class="row" style="width: 90%;"><hr></div>
                                  <h2>Notification Content setting</h2>
                                <div class="row" style="width: 90%;"><hr></div>
                                <div class="row">
                                  <h3>Notification message</h3>
                                  <p><input id="notification_text" name="devloungeNotificationMsg" class="input_color" value="<?php echo $devOptions['notification_msg'] ?>"></p>
                                  <small>e.g. Check out our new Blog entry -></small>
                               </div>
                               <div class="row">
                                  <h3>Fixed position (doesn't scroll with page)?</h3>
                                   <?php
                                       if($devOptions['fixed_position'] == 1) {
                                                 $select = 'checked';
                                   }
                                        else {
                                                     $select = '';
                                 } ?>

                                 <input type="hidden" name="devloungeFixedPosition" value="0"/>
                                  <p><input id="fixed_position" type="checkbox" name="devloungeFixedPosition" value="1"<?php echo $select ?>>Yes</p>
                                </div>
                                <div class="row">
                                  <h3>Push down HTML content when rendering?</h3>
                                 <?php
                                       if($devOptions['push_down'] == 1) {
                                                 $select = 'checked';
                                   }
                                        else {
                                                     $select = '';
                                 } ?>

                                 <input type="hidden" name="devloungePushDown" value="0"/>
                                  <p><input id="push_down" type="checkbox" name="devloungePushDown" value="1"<?php echo $select ?>>Yes</p>
                                </div>
                                <div class="row">
                                  <h3>Align Content in Notification</h3>
                                   <?php
										if($devOptions['align_content'] == 0) {
                                            $select = 'checked';
										}
										elseif ($devOptions['align_content'] == 1) {
                                            $select1 = 'checked';
                                        }
                                        elseif ($devOptions['align_content'] == 2) {
                                            $select2 = 'checked';
                                        }
                                  ?>

                                  <input type="hidden" name="devloungeOptnBox" value="1"/>
                                  <p><input id="align_content" type="radio" name="devloungeAlignContent" value="0"<?php echo $select ?>>Left&nbsp;&nbsp;&nbsp;</p>
                                  <p><input id="align_content" type="radio" name="devloungeAlignContent" value="1"<?php echo $select1 ?>>Center&nbsp;&nbsp;&nbsp; </p>
                                  <p><input id="align_content" type="radio" name="devloungeAlignContent" value="2"<?php echo $select2 ?>>Right </p>
                                </div>
                                </br>

                                <div class="row" style="width: 90%;"><hr>
                                  <h2>Call to action button setting</h2></div>
                                <div class="row" style="width: 90%;"><hr></div>
                                <div class="row">
                                  <h3>Background color:</h3>
                                  <p>#<input id="action_background_color" name="devloungeActionBackgroundColor" class="input_color" value="<?php echo $devOptions['action_background_color'] ?>"></p>
                                  <small>e.g. fff</small>
                                </div>

                                <div class="row">
                                  <h3>Text color</h3>
                                  <p>#<input id="action_text_color" name="devloungeActionTextColor" class="input_color" value="<?php echo $devOptions['action_text_color'] ?>"></p>
                                  <small>e.g. fff</small>
                                </div>
                               <div class="row">
                                  <h3>Border color</h3>
                                  <p>#<input id="action_border_color" name="devloungeActionBorderColor" class="input_color" value="<?php echo $devOptions['action_border_color'] ?>"></p>
                                  <small>e.g. 000</small>
                               </div>
                                <div class="row">
                                  <h3>Call to action text:</h3>
                                  <p><input id="act_text" name="devloungeCallActionText" class="input_color" value="<?php echo $devOptions['call_action_text'] ?>"></p>
                                  <small>e.g. Read More, Buy Now, Redeem</small>
                               </div>
                               <div class="row">
                                  <h3>Button url:</h3>
                                  <p><input id="act_btn_url" name="devloungeActionButtonUrl" class="input_color" value="<?php echo $devOptions['action_button_url'] ?>"></p>
                                  <small>e.g. http://www.example.com/blog/latest-entry</small>
                               </div>
                               <div class="row">
                                  <h3>Open in New Window?</h3>
                                  <?php
                                       if($devOptions['new_window'] == 1) {
                                                 $select = 'checked';
                                   }
                                        else {
                                                     $select = '';
                                 } ?>

                                 <input type="hidden" name="devloungeNewWindow" value="0"/>
                                  <p><input id="new_window" type="checkbox" name="devloungeNewWindow" value="1"<?php echo $select ?>>Yes</p>
                                </div>

                                <div class="row" style="width: 90%;"><hr></div>
                                <div class="row">
                                <div class="submit" style="clear: both;">
                                  <input type="submit" name="update_devloungePluginSeriesSettings" value="Update Settings" class="btn-primary" >

                                    <div id='status' style='display:none'>
                                        <img src="<?php echo site_url()?>/wp-content/plugins/notification-bar/images/ajax-loader.gif">
                                    </div>
                                </div>

                                </div>
                                </form>                              
                            </div>
                            <div style="float: left; width: 28%">
                                <p style="font-size: 18px; width: 100%; float: left;">Mockup of Widget<br><br>
                                <img src="<?php echo site_url()?>/wp-content/plugins/notification-bar/images/mockup.png"></p>
                            </div>
                        </div>

                    <?php
            }
	}
}
if (class_exists("NotificationAdmin")) {
	$dl_notification = new NotificationAdmin();
}

function notification_admin_notices() {
    echo "<div id='notice' class='updated fade'><p><h2>Notification Bar is not configured yet. Please do it now.</h2>
          <br/><a href='"+site_url()+"/wp-admin/admin.php?page=notification-menu-configuration'><img src='"+site_url()+"/wp-content/plugins/notification-bar/images/configure.png'></img></a>
          </p></div>\n";
}


function my_notification_menu() {
   	add_menu_page( 'Configure Notification Bar', 'Notification', 'manage_options', 'notification-menu-id', 'my_notification_options', '../wp-content/plugins/notification-bar/images/favicon.ico');
	add_options_page( 'Configure Notification Bar', 'Notification', 'manage_options', 'notification-menu-configuration', 'my_notification_options' );
}

function my_notification_options() {
	if ( !current_user_can( 'manage_options' ) )  {
		wp_die( __( 'You do not have sufficient permissions to access this page.' ) );
	}

    global $dl_notification;
    if (!isset($dl_notification)) {
         return;
    }

    $dl_notification->printAdminPage();
	remove_action( 'admin_notices', 'notification_admin_notices' );
}
?>