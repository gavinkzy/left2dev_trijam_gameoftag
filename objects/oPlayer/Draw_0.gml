draw_self();
draw_set_color(c_white);
if (image_xscale > 0)
{
	draw_rectangle(x,y-sprite_height/2,x+whackRange,y+sprite_height/2, true);
}

else if (image_xscale < 0)
{
	draw_rectangle(x,y-sprite_height/2,x-whackRange,y+sprite_height/2, true);
}
