if (stunned)

{
	sprite_index = Creature_Stunned;
	if (hsp > 0)
	{
		image_xscale = 1;	
	}

	else if (hsp < 0)
	{
		image_xscale = -1;	
	}
	//Check if hit right wall
	if (isTouchingRightWall) && (!isTouchingGround)
	{
		hsp = -10;
		vsp = -10;
	}
	//Check if hit left wall
	if (isTouchingLeftWall) && (!isTouchingGround)
	{
		hsp = 10;
		vsp = -10;
	}
}

//flip sprite
if (hsp > 0) && (!stunned)
{
	image_xscale = -1;	
}

else if (hsp < 0) && (!stunned)
{
	image_xscale = 1;	
}

//movespd cap
if (moveSpd > 5)
{
	moveSpd = 5;	
}

//Check for aggro range
if (collision_circle(x,y, aggroRange, oPlayer, false, true))
{
	chasing = true;
	alarm[0] = 5 * room_speed;
}

//Chase
if (chasing == true) && (!stunned)
{
	if (jumped) && (!stunned)
	{
		if (x > oPlayer.x)
		{
			hsp = -2;
		}
		else if (x < oPlayer.x)
		{
			hsp = 2;
		}
	}
	
	if ((isTouchingLeftWall) || (isTouchingRightWall)) && !jumped && (sprite_index == Creature_Running) && !stunned
	{
		jumped = true;
		vsp = -jumpSpd;
		sprite_index = Creature_Jump_Landing;
	}
	
	if (isTouchingGround) && (!lunged)
	{
		sprite_index = Creature_Running;
		if (x > oPlayer.x)
		{
			hsp = -moveSpd;
		}
		else if (x < oPlayer.x)
		{
			hsp = moveSpd;
		}
	}
	//check for lunge range
	if (collision_circle(x, y, lungeRange, oPlayer, false, true))
	{
		//lunge
		if (!lunged) && (isTouchingGround) && (!isTouchingLeftWall) && (!isTouchingRightWall)
		{
			sprite_index = Lunge_Creature;
			lunged = true;
			alarm[2] = lungCoolDown;
			if (!oPlayer.isTouchingGround || oPlayer.hasPressedJumpKey)
			{
				vsp = -8;
			}
			else
			{
				vsp = -5;
			}
			if (x > oPlayer.x)
			{
				hsp = -lungePower;
			}
			else if (x < oPlayer.x)
			{
				hsp = lungePower;
			}
			if (audio_is_playing(Lunge_Sound))
			{
				audio_stop_sound(Lunge_Sound);	
			}
			audio_play_sound_at(Lunge_Sound, x, y, 0, 10, 20, 0.5, false, 0);
		}
	}
}
else if (!stunned)
{
	sprite_index = Creature_Idle;	
}

if (lunged)
{
	//Check for tagging range
	if (collision_circle(x,y, taggingRange, oPlayer, false, true)) && (!oPlayer.godMode)
	{
		room_restart();
	}
	//Apply air resistance
	if (hsp>0)
	{
		hsp = max(0, hsp - airResistance);
	}
	else if (hsp<0)
	{
		hsp = min(0, hsp + airResistance);	
	}
}

if (isTouchingGround) && (vsp == 0)
{
	jumped = false;
}
else
{
	grv = 0.5;	
}

//Check for tile collision
CheckForVertTileCollision(id, tilemap_terrain);
CheckForHoriTileCollision(id, tilemap_terrain);

x = x + hsp;
vsp = vsp + grv;
y = y + vsp;