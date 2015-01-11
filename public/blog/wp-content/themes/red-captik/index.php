<?php get_header(); ?>
    <div class="span-24" id="contentwrap">
        <div class="span-14">
            <div id="content">
                <?php if (have_posts()) : ?>
                    <?php while (have_posts()) : the_post(); ?>
                        <div <?php post_class() ?> id="post-<?php the_ID(); ?>">
                            <div id="indexthumb">
                                <a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>">
                                    <?php echo get_avatar( get_the_author_meta( 'ID' ) , 64 ); ?>
                                </a>
                                <p class="postdate"><span><?php the_time('F jS, Y') ?><br/>by <?php the_author() ?><br/></span></p>
                                <?php
                                    $permalinked = urlencode(get_permalink($post->ID));
                                    $spermalink = get_permalink($post->ID);

                                    // for older blogs created before 31/8/2013
                                    if (strtotime($post->post_date) <= strtotime('August 31 2013')) {
                                        $t_permalink = get_permalink($post->ID);
                                        $t1_permalink = preg_replace(array("%\/blog%"), array(""), $t_permalink);
                                        $t2_permalink = preg_replace(array("%www.socialappshq.com%"), array("blog.socialappshq.com"), $t1_permalink);
                                        $permalinked = urlencode($t2_permalink);

                                        // twitter counturl to be specified
                                        $twitter_counturl = "http://blog.socialappshq.com".preg_replace(array("%http://www.socialappshq.com\/blog%"), array(""), $t_permalink);
                                    }

                                    $title = urlencode($post->post_title);
                                    $stitle = $post->post_title;
                                    $data = '<div class="wp_social_share_cat_wrapper">';
                                    if (1)
                                    {
                                        $data .='<div class="wp_social_share_twitter wpsh_cat_item" >                                        
                                        <a href="https://twitter.com/share" class="twitter-share-button" data-via="twitterapi" data-lang="en" data-url="'.$spermalink.'" data-text="'.$stitle.'" data-counturl="'.$twitter_counturl.'">Tweet</a>
                                        </div> <!--Twitter Button-->';
                                    }

                                    if (1) {
                                        $data .= '<div class="wp_social_share_gplus wpsh_cat_item">
                                        <!-- Place this tag where you want the +1 button to render -->
                                        <div class="g-plusone" data-href="'. $permalinked .'"></div>
                                        </div> <!--google plus Button-->';
                                    }

                                    if (1) {
                                        $data .= '<div class="wp_social_share_facebook wpsh_cat_item">
                                        <iframe src="//www.facebook.com/plugins/like.php?href='. $permalinked .'&amp;layout=button_count&amp;action=like&amp;show_faces=false&amp;share=false&amp;height=21&amp;appId=266232166733106" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:21px;" allowTransparency="true"></iframe>
                                        </div> <!--facebook Button-->';
                                    }

                                    if (0) {
                                        $data .= '<div class="wp_social_share_facebook_share wpsh_cat_item">
                                        <a expr:share_url="'. $permalinked .'" href="http://www.facebook.com/sharer.php?u="'. $permalinked .'" name="fb_share" type="box_count">Share</a>
                                        </div> <!--facebook Button-->';
                                    }

                                    if (0) {
                                        $data .= '<div class="wp_social_share_linkedin wpsh_cat_item">
                                        <script type="IN/Share" data-url="'. $permalinked .'" data-counter="top"></script>
                                        </div> <!--linkedin Button-->';
                                    }

                                    $data .= '</div>';
                                    echo $data;
                                ?>
                            </div>

                            <div id="indexcontent">
                                <h2 class="title"><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"><?php the_title(); ?></a></h2>                                
				<div class="entry">
                                    <?php echo excerpt(40); ?>
                                    <div class="readmorecontent">
                                        <a class="readmore" href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>">Read More...</a>
                                    </div>
				</div>
                            </div>

                            <div style="clear:both;"></div>
			</div><!--/post-<?php the_ID(); ?>-->
				
                    <?php endwhile; ?>
                    <div class="navigation">
                        <?php if(function_exists('wp_pagenavi')) { wp_pagenavi(); } else { ?>
                        <div class="alignleft"><?php next_posts_link('&laquo; Older Entries') ?></div>
                        <div class="alignright"><?php previous_posts_link('Newer Entries &raquo;') ?></div>
                        <?php } ?>
                    </div>
                    <?php else : ?>
                        <h2 class="center">Not Found</h2>
                        <p class="center">Sorry, but you are looking for something that isn't here.</p>
                        <?php get_search_form(); ?>
                    <?php endif; ?>
                    </div>
                </div>
                <?php get_sidebars('right'); ?>
            </div>
            
            <?php get_footer(); ?>