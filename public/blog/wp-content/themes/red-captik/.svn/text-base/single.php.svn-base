<?php get_header(); ?>
<div class="span-24" id="contentwrap">
    <div class="span-14">
        <div id="content">
            <?php if (have_posts()) : ?>
                <?php while (have_posts()) : the_post(); ?>
                    <div <?php post_class() ?> id="post-<?php the_ID(); ?>">
                        <img src="<?php getImage('1'); ?>" class="post_thumbnail" style="max-width:600px;"/>
                        <div class="postleft">
                            <?php echo get_avatar( get_the_author_meta( 'ID' ) , 64 ); ?>
                            <p class="postdate_single"><span><?php the_time('F jS, Y') ?><br/>by <?php the_author() ?><br/></span></p>
                            <div class="g-follow" data-annotation="bubble" data-height="20" data-href="<?php echo the_author_meta('googleplus'); ?>" data-rel="author"></div>

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
                        <div class="postright">
                            <?php echo nl2br(preg_replace("/\< *[img][^\>]*[.]*\>/i","",get_the_content(),1)); ?>
                        </div>
                        <?php wp_link_pages(array('before' => '<p><strong>Pages:</strong> ', 'after' => '</p>', 'next_or_number' => 'number')); ?>
					</div> <!--/post-<?php the_ID(); ?>-->

                    <div class="author clearfix">
                        <div class="shortbio">
                            <h4>About the Author</h4>
                            <p><?php the_author_description(); ?></p>
                        </div>
                    </div>

                    <?php comments_template(); ?>
                <?php endwhile; ?>
            <?php endif; ?>
        </div>
        <div class="tags"><?php the_tags(); ?></div>
    </div>
    <?php get_sidebars('right'); ?>
</div>
<?php get_footer(); ?>