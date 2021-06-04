tilemap_terrain = layer_tilemap_get_id(layer_get_id("Tilemap_Terrain"));
vsp = 0;
hsp = 0;
grv = 0.3;
moveSpd = 2;
jumpSpd = 5;

isTouchingGround = false;
isTouchingCeiling = false;
isTouchingRightWall = false;
isTouchingLeftWall = false;
chasing = false;
lunged = false;

taggingRange = 10;
aggroRange = 150;
lungeRange = 120;

lungePower = random_range(5.5,8);

stunned = false;

airResistance = 0.09;

