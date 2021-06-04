if (camVisible) { sprite_index = sDefaultCam; } else { sprite_index = -1;}

xTarget = camPin.x;
yTarget = camPin.y;

var nearestCamPoint = instance_nearest(x,y, oCameraPoint);
if (currentCamPoint != nearestCamPoint)
{
	//currentState = CameraStates.transition;
}

var x_min = 0;
var x_max = 1500;

switch currentState
{
	default:
		currentState = CameraStates.normal;
		return;
	case CameraStates.normal:
		//Follow Player with slow pan effect
		x = clamp(x + (xTarget - x)/xPanMultiplier, x_min + view_w_half + buffer, x_max - view_w_half - buffer);
		y = clamp(y + (yTarget - y)/yPanMultiplier, 0 + view_h_half + buffer, room_height - view_h_half - buffer);
		if (abs(x-xTarget)<3) { x=round(x); }
		if (abs(y-yTarget)<3) { y=round(y); }
		//Screen shake
		x += random_range(-shake_remain, shake_remain);
		y += random_range(-shake_remain, shake_remain);
		shake_remain = max(0, shake_remain-((1/shake_length)*shake_magnitude));
		camera_set_view_pos(cam, x-view_w_half, y-view_h_half);
		break;
	case CameraStates.transition:
		x = x + (nearestCamPoint.x - x)/25;
		y = y + (nearestCamPoint.y - y)/25;
		camera_set_view_pos(cam, x-view_w_half, y-view_h_half);
		if (abs(x - nearestCamPoint.x) < 15)
		{
			currentCamPoint = nearestCamPoint;
			currentState = CameraStates.normal;
		}
		break;
	case CameraStates.usingSpell:
		x = clamp(xTarget, x_min + view_w_half + buffer, x_max - view_w_half - buffer);
		y = clamp(yTarget, 0 + view_h_half + buffer, room_height - view_h_half - buffer);
		camera_set_view_pos(cam, x-view_w_half, y-view_h_half);
		break;
}
