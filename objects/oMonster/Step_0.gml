//movespd cap
if (moveSpd > 10)
{
	moveSpd = 10;	
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
		if (!lunged)
		{
			sprite_index = Lunge_Creature;
			lunged = true;
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
				hsp = -5;
			}
			else if (x < oPlayer.x)
			{
				hsp = 5;
			}
			audio_play_sound_at(Lunge_Sound, x, y, 0, 10, 20, 0.5, false, 0);
		}
	}
}
else
{
	sprite_index = Creature_Idle;	
}

if (lunged)
{
	//Check for tagging range
	if (collision_circle(x,y, taggingRange, oPlayer, false, true))
	{
		room_restart();
	}
}

if (isTouchingGround) && (vsp == 0)
{
	lunged = false;	
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