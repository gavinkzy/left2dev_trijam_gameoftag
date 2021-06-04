//Offset background based on camera

if (instance_exists(oCamera))
{
	layer_x("Backgrounds_far", oCamera.x * 0.90);
	layer_x("Backgrounds_less_far", oCamera.x * 0.75);
	layer_x("Backgrounds_foreground", oCamera.x * 0.15);
}