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
	<?php else :

		if ( is_category() ) { // If this is a category archive
			printf("<h2 class='pagetitle'>Sorry, but there aren't any posts in the %s category yet.</h2>", single_cat_title('',false));
		} else if ( is_date() ) { // If this is a date archive
			echo("<h2 class='pagetitle'>Sorry, but there aren't any posts with this date.</h2>");
		} else if ( is_author() ) { // If this is a category archive
			$userdata = get_userdatabylogin(get_query_var('author_name'));
			printf("<h2 class='pagetitle'>Sorry, but there aren't any posts by %s yet.</h2>", $userdata->display_name);
		} else {
			echo("<h2 class='pagetitle'>No posts found.</h2>");
		}
		get_search_form();

	endif;
?>

		</div>
		</div>


<?php get_sidebars('right'); ?>

	</div>
<?php get_footer(); ?>
