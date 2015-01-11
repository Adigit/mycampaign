<?php


/**
 * Gets Social Stats From Requested Social Networks
 *
 * @since 0.1
 * @author randall@macnative.com
 */

function twitterCounts($username){

// WordPress Transient API Caching
$cacheKey = $username . '-cache';
$cached = get_transient($cacheKey);
//$cached = false;
if (false !== $cached)
        {return $cached;}

// Call and instantiate twitterOAuth. Modify the path to where you uploaded twitteroauth
include ('/var/www/wordpress/wp-content/themes/red-captik/twitteroauth/twitteroauth/twitteroauth.php');

// Replace the four parameters below with the information from your Twitter developer application.
$twitterConnection = new TwitterOAuth('SO3H2GzHYUTOtvPRbaYCSg','30sa4XXDXqkDY3xjbCRw5dtuxlnimbCAnmxdi054djE','251957558-3hzWJiqsgAg68jFOixIGtiQHnYPGBL4VZveFukQG', 'Ht0S1MRiyqIFaI7HYEU8g6q2i3LL7dAz98MI93xqvys');

// Send the API request
$twitterData = $twitterConnection->get('users/show', array('screen_name' => $username));

// Extract the follower and tweet counts
$followerCount = $twitterData->followers_count;
//$tweetCount = $twitterData->statuses_count;

$output = $followerCount; // . " followers, " . $tweetCount . " tweets";
set_transient($cacheKey,$output,3600);
return $output;
}



function SocialCrowd_GetCounts()
{
	$sc_options = SocialCrowd_GetOptions();
	
    if ($sc_options["interval"] < mktime() - get_option('Social_Crowd_Timer')) 
	{
		
		//Get Facebook Fans/Friends
		if($sc_options["get_facebook"]){
			$json = json_decode(SocialCrowd_Load_JSON('https://graph.facebook.com/'.$sc_options['facebook_token']));
			
			if($sc_options["update"]){
				if ($json->likes != '' && $json->likes > get_option('Social_Crowd_Facebook_Count')) 
				{ 
					update_option('Social_Crowd_Facebook_Count', (string) $json->likes); 
				}
			}else{
				if ($json->likes != '' && $json->likes > 0) 
				{ 
					update_option('Social_Crowd_Facebook_Count', (string) $json->likes); 
				}
			}
		}
		
		//Get Twitter Followers
			$tjson = twitterCounts('socialappshq');			
	                update_option('Social_Crowd_Twitter_Count',  $tjson); 
			update_option('Social_Crowd_Twitter_friendsCount',  (string) $tjson);
			update_option('Social_Crowd_Twitter_statusesCount',  (string) $tjson);
			update_option('Social_Crowd_Twitter_listedCount',  (string) $tjson);
		if($sc_options["get_twitter"]){
		//	$tjson = json_decode(SocialCrowd_Load_JSON("https://api.twitter.com/1/users/show.json?screen_name=".$sc_options['twitter_token']));
			$tjson = twitterCounts('socialappshq');			
	                update_option('Social_Crowd_Twitter_Count',  $tjson); 
			update_option('Social_Crowd_Twitter_friendsCount',  (string) $tjson);
			update_option('Social_Crowd_Twitter_statusesCount',  (string) $tjson);
			update_option('Social_Crowd_Twitter_listedCount',  (string) $tjson);
			if($sc_options["update"]){
				if ($tjson != '' && $tjson > get_option('Social_Crowd_Twitter_Count')) 
		        { 
	                update_option('Social_Crowd_Twitter_Count',  (string) $tjson); 
	            }
//				if ($tjson->friends_count != '' && $tjson->friends_count > get_option('Social_Crowd_Twitter_friendsCount')) 
//		        { 
//	                update_option('Social_Crowd_Twitter_friendsCount',  (string) $tjson->friends_count); 
//	            }
//				if ($tjson->statuses_count != '' && $tjson->statuses_count > get_option('Social_Crowd_Twitter_statusesCount')) 
//		        { 
//	                update_option('Social_Crowd_Twitter_statusesCount',  (string) $tjson->statuses_count); 
//	            }
//				if ($tjson->listed_count != '' && $tjson->listed_count > get_option('Social_Crowd_Twitter_listedCount')) 
//		        { 
//	                update_option('Social_Crowd_Twitter_listedCount',  (string) $tjson->listed_count); 
//	            }
			}else{
				if ($tjson != '' && $tjson > 0) 
		        { 
	                update_option('Social_Crowd_Twitter_Count',  (string) $tjson); 
	            }
//				if ($tjson->friends_count != '' && $tjson->friends_count > 0) 
//		        { 
//	                update_option('Social_Crowd_Twitter_friendsCount',  (string) $tjson->friends_count); 
//	            }
//				if ($tjson->statuses_count != '' && $tjson->statuses_count > 0) 
//		        { 
//	                update_option('Social_Crowd_Twitter_statusesCount',  (string) $tjson->statuses_count); 
//	            }
//				if ($tjson->listed_count != '' && $tjson->listed_count > 0) 
//		        { 
//	                update_option('Social_Crowd_Twitter_listedCount',  (string) $tjson->listed_count); 
//	            }
			}
		}
		
		//Get Youtube Followers
		if($sc_options["get_youtube"]){
				$xml = SocialCrowd_Load_XML('http://gdata.youtube.com/feeds/api/users/'.$sc_options['youtube_token']);
				$gd = $xml->children('http://schemas.google.com/g/2005');
			
			if($sc_options["update"]){
				foreach($gd->feedLink AS $links){
					$temp = $links->attributes();
					if(strpos($temp['rel'],"contacts") && $temp['countHint'] > get_option('Social_Crowd_Youtube_Count')){
						update_option('Social_Crowd_Youtube_Count', (string) $temp['countHint']);
					}
				}
			}else{
				foreach($gd->feedLink AS $links){
					$temp = $links->attributes();
					if(strpos($temp['rel'],"contacts") && $temp['countHint'] > 0){
						update_option('Social_Crowd_Youtube_Count', (string) $temp['countHint']);
					}
				}
			}
				
			//Get Youtube Statistics
			$yt = $xml->children('http://gdata.youtube.com/schemas/2007');
			
			$stats = $yt->statistics->attributes();
			if($sc_options["update"]){
				if($stats["subscriberCount"] != '' && $stats["subscriberCount"] > get_option('Social_Crowd_Youtube_subscriberCount')){
					update_option('Social_Crowd_Youtube_subscriberCount', (string) $stats['subscriberCount']);
				}
				if($stats["viewCount"] != '' && $stats["viewCount"] > get_option('Social_Crowd_Youtube_viewCount')){
					update_option('Social_Crowd_Youtube_viewCount', (string) $stats['viewCount']);
				}
				if($stats["totalUploadViews"] != '' && $stats["totalUploadViews"] > get_option('Social_Crowd_Youtube_uploadViewCount')){
					update_option('Social_Crowd_Youtube_uploadViewCount', (string) $stats['totalUploadViews']);
				}
			}else{
				if($stats["subscriberCount"] != '' && $stats["subscriberCount"] > 0){
					update_option('Social_Crowd_Youtube_subscriberCount', (string) $stats['subscriberCount']);
				}
				if($stats["viewCount"] != '' && $stats["viewCount"] > 0){
					update_option('Social_Crowd_Youtube_viewCount', (string) $stats['viewCount']);
				}
				if($stats["totalUploadViews"] != '' && $stats["totalUploadViews"] > 0){
					update_option('Social_Crowd_Youtube_uploadViewCount', (string) $stats['totalUploadViews']);
				}
			}
		}
		
		//Get Vimeo Contacts
		if($sc_options["get_vimeo"]){
			$xml = SocialCrowd_Load_XML("http://vimeo.com/api/v2/".$sc_options['vimeo_token']."/info.xml");
			if($sc_options["update"]){
				if ($xml->user->total_contacts != '' && $xml->user->total_contacts > get_option('Social_Crowd_Vimeo_Count')) 
		        { 
	                update_option('Social_Crowd_Vimeo_Count',  (string) $xml->user->total_contacts); 
	            }
				if ($xml->user->total_videos_uploaded != '' && $xml->user->total_videos_uploaded > get_option('Social_Crowd_Vimeo_uploadedCount')) 
		        { 
	                update_option('Social_Crowd_Vimeo_uploadedCount',  (string) $xml->user->total_videos_uploaded); 
	            }
				if ($xml->user->total_videos_appears_in != '' && $xml->user->total_videos_appears_in > get_option('Social_Crowd_Vimeo_appearsInCount')) 
		        { 
	                update_option('Social_Crowd_Vimeo_appearsInCount',  (string) $xml->user->total_videos_appears_in); 
	            }
				if ($xml->user->total_videos_liked != '' && $xml->user->total_videos_liked > get_option('Social_Crowd_Vimeo_likedCount')) 
		        { 
	                update_option('Social_Crowd_Vimeo_likedCount',  (string) $xml->user->total_videos_liked); 
	            }
			}else{
				if ($xml->user->total_contacts != '' && $xml->user->total_contacts > 0) 
		        { 
	                update_option('Social_Crowd_Vimeo_Count',  (string) $xml->user->total_contacts); 
	            }
				if ($xml->user->total_videos_uploaded != '' && $xml->user->total_videos_uploaded > 0) 
		        { 
	                update_option('Social_Crowd_Vimeo_uploadedCount',  (string) $xml->user->total_videos_uploaded); 
	            }
				if ($xml->user->total_videos_appears_in != '' && $xml->user->total_videos_appears_in > 0) 
		        { 
	                update_option('Social_Crowd_Vimeo_appearsInCount',  (string) $xml->user->total_videos_appears_in); 
	            }
				if ($xml->user->total_videos_liked != '' && $xml->user->total_videos_liked > 0) 
		        { 
	                update_option('Social_Crowd_Vimeo_likedCount',  (string) $xml->user->total_videos_liked); 
	            }
			}
		}
		
		
		
		
		//Mailchimp api call = http://us1.api.mailchimp.com/1.3/?method=lists&apikey=1fa32d83fc746903f28067258f2e70d6-us1
		
		update_option('Social_Crowd_Timer', mktime());		
	}   
}

?>
