tilemap_terrain = layer_tilemap_get_id(layer_get_id("Tilemap_Terrain"));
vsp = 0;
hsp = 0;
grv = 0.5;
moveSpd = 2;
jumpSpd = 5;

isTouchingGround = false;
isTouchingCeiling = false;
chasing = false;
lunged = false;

taggingRange = 13;
aggroRange = 150;
lungeRange = 120;

stunned = false;