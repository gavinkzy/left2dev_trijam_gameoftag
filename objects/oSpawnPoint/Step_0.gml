
if (spawned == false)
{
	spawned = true;
	alarm[0] = spawnDelay;
	with (instance_create_layer(x,y, "Instances", oMonster))
	{
		show_debug_message("Spawned");
	}
}