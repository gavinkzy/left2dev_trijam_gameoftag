//Instantiation
global.CAM_DEBUG_VISIBLE = false;
global.KEY_LEFT = 0;
global.KEY_RIGHT = 0;
global.KEY_JUMP = 0;
global.KEY_JUMP_HOLDING = 0;
global.KEY_ATTACK = 0;
global.KEY_ATTACK_HOLDING = 0;

tilemap_terrain = layer_tilemap_get_id(layer_get_id("Tilemap_Terrain"));
vsp = 0;
hsp = 0;
grv = 0.5;
moveSpd = 4.2;
jumpSpd = 7;

isTouchingGround = false;
isTouchingCeiling = false;
isPressingRightKey = false;
isPressingLeftKey = false;
hasPressedJumpKey = false;

//Animation
isIdle = true;
isRunning = false;
isJumping = false;

//Whack
whackRange = 40;
whackingActive = false;
whackingActiveDuration = 0.8 * room_speed;

whackCoolDownOver = true;
whackCoolDownDuration = 1 * room_speed;

hasObtainedFlag = false;
remainingTime = 30 * room_speed;

whackPowerVert = 10;
whackPowerHori = 15;

godMode = false;

hasPressedWhackKey = false;

hasCollectedFakeChicken = false;