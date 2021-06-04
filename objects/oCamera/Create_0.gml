/// @description Camera Variables
camVisible = global.CAM_DEBUG_VISIBLE;

cam = view_camera[0];
camPin = oCameraPin;
view_w_half = camera_get_view_width(cam)/2;
view_h_half = camera_get_view_height(cam)/2;
xTarget = camPin.x;
yTarget = camPin.y;

//Panning effect config
xPanMultiplier = 20;
yPanMultiplier = 9;


enum CameraStates
{
	normal,
	transition,
	usingSpell
}

currentState = CameraStates.normal;
currentCamPoint = 0;
x = camPin.x;
y = camPin.y;

shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;
buffer = 10; //buffer
