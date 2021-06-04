if (pinVisible) { sprite_index = sCamPin; } else { sprite_index = -1;}

if ((global.KEY_RIGHT) || (global.KEY_LEFT)) && (!(global.KEY_RIGHT && global.KEY_LEFT))
{
	if (global.KEY_RIGHT) && (followObject.hsp != 0)
	{
		sinValue = min(90, sinValue + camSpd);	
	}
	if (global.KEY_LEFT) && (followObject.hsp != 0)
	{
		sinValue = max(-90, sinValue - camSpd);
	}
}
x = followObject.x + (dsin(sinValue) * lookAheadDist);
y = followObject.y;
//else
//{
//	x = followObject.x;
//	if (followObject.hsp > 0)
//	{
//		sinValue = 0;
//	}
//	else if (followObject.hsp < 0)
//	{
//		sinValue = 0;
//	}
//	y = followObject.y;
//}

