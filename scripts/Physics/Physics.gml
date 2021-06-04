/// This script contains gravity reset, tile collision functions to be called in the player StateMachine.

/// @function	CheckForVertTileCollision(_object, _tilemap);
/// @param	{index}	_object	The object to check for
/// @param	{index}	_tilemap	The Tile Map
/// @description	Check for Vertical Collision with the tile map whenever the script is called and stop the object from moving past the tile.
/// Variables to be initialized in the player object
/// - vsp, hsp, grv, isTouchingGround, isTouchingCeiling, tilemap as a parameter


function CheckForVertTileCollision(_object, _tilemap)
{
	// Check if stuck in ground
	if (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_bottom) != 0) || (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_bottom) != 0) || (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_bottom) != 0)
	{
		_object.y = _object.y - 1;
	}
	// Check if stuck in ceiling
	else if (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_top) != 0) || (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_top) != 0) || (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_top) != 0)
	{
		_object.y = _object.y + 1;
	}
	
	if (_object.vsp > 0) //object is falling downwards
	{
		//check for vertical collision on the rightmost of sprite
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_bottom + _object.vsp) != 0)
		{
			//Flush to floor
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_bottom + 1) == 0)
			{
				_object.y = _object.y + 1;
			}
			_object.vsp = 0;
			_object.grv = 0;
			_object.isTouchingGround = true;
			return true;
		}
		//check for vertical collision on the leftmost of sprite
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_bottom + _object.vsp) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_bottom + 1) == 0)
			{
				_object.y = _object.y + 1;
			}
			_object.vsp = 0;
			_object.grv = 0;
			_object.isTouchingGround = true;
			return true;
		}
		//Check for collision in the middle of player sprite
		if (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_bottom + _object.vsp) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_bottom + 1) == 0)
			{
				_object.y = _object.y + 1;
			}
			_object.vsp = 0;
			_object.grv = 0;
			_object.isTouchingGround = true;
			return true;
		}
	}
	else if (_object.vsp < 0) // Player object is moving upwards
	{
		//Check for right side
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_top + _object.vsp) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_top + sign(_object.vsp)) == 0)
			{
				_object.y = _object.y - 1;
			}
			_object.vsp = 0;
			_object.grv = 0;
			_object.isTouchingCeiling = true;
			return true;
		}
		//Check for left side
		else if (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_top + _object.vsp) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_top + sign(_object.vsp)) == 0)
			{
				_object.y = _object.y - 1;
			}
			_object.vsp = 0;
			_object.grv = 0;
			_object.isTouchingCeiling = true;
			return true;
		}
		//Check for middle
		else if (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_top + _object.vsp) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_top + sign(_object.vsp)) == 0)
			{
				_object.y = _object.y - 1;
			}
			_object.vsp = 0;
			_object.grv = 0;
			_object.isTouchingCeiling = true;
		}
		else
		{
			_object.isTouchingCeiling = false;
		}
	}
	//Check if Grounded
	if (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_bottom + 1) != 0) || (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_bottom + 1) != 0) || (tilemap_get_at_pixel(_tilemap, _object.x, _object.bbox_bottom + 1) != 0)
	{
		_object.isTouchingGround = true;
	}
	else
	{
		_object.isTouchingGround = false;	
	}
	_object.y = round(y);
}

/// @function	CheckForHoriTileCollision(_object, _tilemap);
/// @param	{index}	_object	The object to check for
/// @param	{index}	_tilemap	The Tile Map
/// @description	Check for Horizontal Collision with the tile map whenever the script is called and stop the object from moving past the tile.

function CheckForHoriTileCollision(_object, _tilemap)
{
	if (tilemap_get_at_pixel(_tilemap, _object.bbox_left, _object.bbox_bottom) != 0) && (_object.vsp == 0)
	{
		_object.x = _object.x + 1;
	}
	else if (tilemap_get_at_pixel(_tilemap, _object.bbox_right, _object.bbox_bottom) != 0) && (_object.vsp == 0)
	{
		_object.x = _object.x - 1;
	}
	
	if (_object.hsp > 0) //Player Moving Right
	{
		//Check for Top of Sprite
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_right + ceil(hsp), _object.bbox_top) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_right + 1, _object.bbox_top) == 0)
			{
				_object.x = _object.x + 1;	
			}
			_object.hsp = 0;
			_object.isTouchingRightWall = true;
			return 0;
		}
		//Check for Bottom of Sprite
		else if (tilemap_get_at_pixel(_tilemap, _object.bbox_right + ceil(hsp), _object.bbox_bottom) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_right + 1, _object.bbox_bottom) == 0)
			{
				_object.x = _object.x + 1;	
			}
			_object.hsp = 0;
			_object.isTouchingRightWall = true;
			return 0;
		}
		else
		{
			_object.isTouchingRightWall = false;
			_object.isTouchingLeftWall = false;	
		}
	}
	else if (_object.hsp < 0) //Player Moving Left
	{
		//Check for Top of Sprite
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_left + floor(hsp), _object.bbox_top) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_left - 1, _object.bbox_top) == 0)
			{
				_object.x = _object.x - 1;	
			}
			_object.hsp = 0;
			_object.isTouchingLeftWall = true;
			return 0;
		}
		//Check for Bottom of Sprite
		else if (tilemap_get_at_pixel(_tilemap, _object.bbox_left + floor(hsp), _object.bbox_bottom) != 0)
		{
			while (tilemap_get_at_pixel(_tilemap, _object.bbox_left - 1, _object.bbox_bottom) == 0)
			{
				_object.x = _object.x - 1;	
			}
			_object.hsp = 0;
			_object.isTouchingLeftWall = true;
			return 0;
		}
		else
		{
			_object.isTouchingRightWall = false;
			_object.isTouchingLeftWall = false;
		}
	}
	_object.x = round(x);
}

/// @function	CheckForNormalPlayerInputs(_object);
/// @param	{index}	_object	The object to check for
/// @description	Check for player inputs for general movement

function CheckForNormalPlayerInputs(_object)
{
	// Gamepad Stuff
	var gp_num = gamepad_get_device_count();
	for (var i = 0; i < gp_num; i++;)
	{
		if gamepad_is_connected(i) 
		{
			global.gp[i] = true
		}
		else 
		{
			global.gp[i] = false;
		}
	}
	for (var i = 0; i < gp_num; i++;)
	{
		if (global.gp[i] == true)
		{
			var first_gp_connected = i;
			_object.first_gp_connected = first_gp_connected;
			break;
		}
	}

	//Check for controller
	if (gamepad_is_connected(_object.first_gp_connected))
	{
		var haxis = gamepad_axis_value(first_gp_connected, gp_axislh);
		var vaxis = gamepad_axis_value(first_gp_connected, gp_axislv);
		global.KEY_LEFT = (haxis < -0.20) || keyboard_check(ord("A"));
		global.KEY_RIGHT = (haxis > 0.20) || keyboard_check(ord("D"));
		global.KEY_JUMP = gamepad_button_check_pressed(first_gp_connected, gp_face1) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
		global.KEY_JUMP_HOLDING = gamepad_button_check(first_gp_connected, gp_face1) || keyboard_check(vk_space)|| keyboard_check(ord("W"));
		global.KEY_ATTACK = gamepad_button_check_pressed(first_gp_connected, gp_face2) || gamepad_button_check_pressed(first_gp_connected, gp_face3) || gamepad_button_check_pressed(first_gp_connected, gp_face4);
		global.KEY_ATTACK_HOLDING = gamepad_button_check(first_gp_connected, gp_face2) || gamepad_button_check(first_gp_connected, gp_face3) || gamepad_button_check(first_gp_connected, gp_face4);
	}
	else
	{
		//Only check for keyboard inputs
		global.KEY_LEFT = keyboard_check(ord("A"));
		global.KEY_RIGHT = keyboard_check(ord("D"));
		global.KEY_JUMP = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
		global.KEY_JUMP_HOLDING = keyboard_check(vk_space) || keyboard_check(ord("W"));
		global.KEY_ATTACK = mouse_check_button_pressed(mb_left);
		global.KEY_ATTACK_HOLDING = mouse_check_button(mb_left);
	}
	//Horizontal motion
	var horizontalDirection = global.KEY_RIGHT - global.KEY_LEFT;
	var horizontalInputBool = (horizontalDirection != 0);
	if (_object.hsp == 0 && _object.isTouchingGround && _object.vsp == 0 && _object.isAttacking == false) { _object.sprite_index = herochar_idle_anim; }
	if (horizontalInputBool) && (!_object.isChargingDash)
	{
		if (_object.isTouchingGround) && (_object.vsp == 0) && (!_object.isAttacking)
		{
			_object.image_speed = 1;
			_object.sprite_index = herochar_run_anim;
		}
		_object.image_xscale = 1 * sign(horizontalDirection);
	}
	
	if (((global.KEY_LEFT || global.KEY_RIGHT) && (!_object.isAttacking) && (!_object.isHurt)) || (gamepad_is_connected(0) &&  (!_object.isAttacking) && (!_object.isHurt))) && (!_object.isChargingDash)
	{
		hsp = sign(horizontalDirection) * global.PLAYER_NORMAL_WALK;
	}
	
	else //Player does not input horizontal motion
	{
		//Apply friction if grounded
		if (_object.isTouchingGround)
		{
			if (_object.hsp > 0)
			{
				hsp = max(0, _object.hsp - global.PLAYER_FRICTION);
			}
			else if (_object.hsp < 0)
			{
				hsp = min(0, _object.hsp + global.PLAYER_FRICTION);	
			}
		}
		//Else apply air resistance
		else if (!isAttacking)
		{
			if (_object.hsp > 0) 
			{
				_object.hsp = max(0, hsp - global.PLAYER_AIR_RESISTANCE);
			}
			else
			{
				_object.hsp = min(0, hsp + global.PLAYER_AIR_RESISTANCE);	
			}
		}
	}
	if (_object.isTouchingGround && _object.vsp == 0) { global.CURRENT_PLAYER_JUMP = 0; }
	if (global.KEY_JUMP) && (global.CURRENT_PLAYER_JUMP < global.MAX_PLAYER_JUMPS) && (!_object.isAttacking) && (!global.KEY_ATTACK) 
	{
		if (!_object.isAttacking) && (!global.KEY_ATTACK) 
		{ 
			//Dust
			//part_particles_create(psDust.particle_system, x, y+sprite_height/2, psDust.particle_dust, 1);
			instance_create_layer(_object.x, _object.y+_object.sprite_height/2, "Player", oDust);
			_object.sprite_index = herochar_jump_up_anim; 
		}
		_object.vsp = global.PLAYER_NORMAL_JUMP;
		global.CURRENT_PLAYER_JUMP += 1;
	}
	if (global.CURRENT_PLAYER_JUMP == 2)
	{
		//_object.hsp = sign(horizontalDirection) * global.PLAYER_NORMAL_WALK;
		if (!_object.isAttacking) && (!global.KEY_ATTACK) 
		{ 
			////Dust
			//part_particles_create(psDust.particle_system, x, y+sprite_height/2, psDust.particle_dust, 1);
			_object.sprite_index = herochar_jump_double_anim; 
		}
	}
	if _object.vsp > 0
	{
		if (!_object.isAttacking) && (!global.KEY_ATTACK) {	_object.sprite_index = herochar_jump_down_anim; }
	}
	return horizontalInputBool;
}

/// @function CheckForLedges(_object);
/// @param {index} _object The object to check for
/// @description	Check for ledges on the left or right of the object

function CheckForLedges(_object, _tilemap)
{
	//Right Ledge
	if (_object.hsp > 0)
	{
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_right + 1, _object.bbox_bottom + 1) == 0) && (isTouchingGround)
		{
			_object.isTouchingRightLedge = true;
		}
		else
		{
			_object.isTouchingRightLedge = false;	
		}
	}
	else if (_object.hsp < 0)
	{
		if (tilemap_get_at_pixel(_tilemap, _object.bbox_left + 1, _object.bbox_bottom + 1) == 0) && (isTouchingGround)
		{
			_object.isTouchingLeftLedge = true;
		}
		else
		{
			_object.isTouchingLeftLedge = false;	
		}
	}
}