if (hasObtainedFlag)
{
	remainingTime -= 1;
	if (remainingTime <= 0)
	{
		room_goto_next();	
	}
}

//Animation handler
if (isIdle) && (!whackingActive)
{
	image_speed = 1;
	sprite_index = Alice_idle;
}
if (isRunning) && (!isJumping)  && (!whackingActive)
{	
	image_speed = 1;
	sprite_index = Alice_running_A;
}
if (isJumping) && (!whackingActive) sprite_index = Alice_jump;


//Check Player Inputs
isPressingRightKey = keyboard_check(vk_right);
isPressingLeftKey = keyboard_check(vk_left);
hasPressedJumpKey = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
hasPressedWhackKey = keyboard_check_pressed(ord("C"));

if (hasPressedWhackKey) && whackCoolDownOver
{
	whackCoolDownOver = false;
	alarm[1] = whackCoolDownDuration;
	image_speed = 1;
	//play animation
	sprite_index = Alice_whack;
	//set whacking active
	whackingActive = true;
	//set duration before disable
	alarm[0] = whackingActiveDuration;
}

//Check if Monster is in range + Whacking Active
var monsterList = ds_list_create();
//check if oMonster in range
var numOfMonsters = collision_rectangle_list(x, y-sprite_height/2, x+whackRange, y+sprite_height/2, oMonster, false, true, monsterList, true)
if (numOfMonsters > 0) && (whackingActive)
{
	for (var i = 0; i < numOfMonsters; i++)
	{
		with (monsterList[| i])
		{
		if (lunged) && (!stunned)
		{
			if audio_is_playing(sndWhack)
			{
				audio_stop_sound(sndWhack);	
			}
			audio_play_sound(sndWhack,0,false);
			//Send monsters flying
			if (oPlayer.x>x) //send flying towards left
			{
				hsp = -oPlayer.whackPowerHori;
				vsp = -oPlayer.whackPowerVert;
			}
		
			else if (oPlayer.x<x) //send flying towards right
			{
				hsp = oPlayer.whackPowerHori;
				vsp = -oPlayer.whackPowerVert;	
			}
			
			else if (oPlayer.x == x)
			{
				vsp = -oPlayer.whackPowerVert * 1.1;
				hsp = choose(oPlayer.whackPowerHori, -oPlayer.whackPowerHori);
			}
			
			//Stun monsters for 1.5s
			stunned = true;
			alarm[1] = 1.5 * room_speed;
			//Increase monsters base movement speed
			moveSpd += 1;
			}
			//Set monster sprite
			sprite_index = Creature_Stunned;
		}
	}
}

//Running
var horizontalDirection = isPressingRightKey - isPressingLeftKey;
if (isPressingLeftKey || isPressingRightKey)
{
	hsp = moveSpd * horizontalDirection;
	if (hsp > 0) image_xscale = 1;
	if (hsp < 0) image_xscale = -1;
	isRunning = true;
	isIdle = false;
}
else
{
	hsp = 0;
	isRunning = false;
	isIdle = true;
}

//Jumping
if (!isTouchingGround)
{
	grv = 0.5;
}
else if (vsp == 0)
{
	isJumping = false;
	isIdle = true;
}
else if (vsp > 0)
{
	sprite_index = Alice_falling;	
}

if (hasPressedJumpKey) && (isTouchingGround)
{
	vsp = -jumpSpd;
	isIdle = false;
	isRunning = false;
	isJumping = true;
}

//Check for tile collision
CheckForVertTileCollision(id, tilemap_terrain);
CheckForHoriTileCollision(id, tilemap_terrain);

x = x + hsp;
vsp = vsp + grv;
y = y + vsp;