<div id="featured">

 <ul id="featured-posts">
	<?php $popular = new WP_Query('orderby=comment_count&posts_per_page=3'); while ($popular->have_posts()) : $popular->the_post();?>
        <li class="item-1">
      
          <a href="<?php the_permalink(); ?>">
            <span class="image-roll"><?php getImage('1'); ?>" class="post_popular" style="width:200px;height:200px"><em>&nbsp;</em></span>
          </a>
        
        </li>
<?php endwhile; ?>
       </ul>      


</div>
