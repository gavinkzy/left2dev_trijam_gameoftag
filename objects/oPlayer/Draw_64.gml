DrawSetText(c_white, fDogica, fa_center, fa_middle);

if (room == Room1) || (room == Room2) || (room == Room3)
{
	if (hasObtainedFlag)
	{
		draw_text(view_wport[0]/2, view_hport[0]/2-100, "Remaining time: " + string((remainingTime/60)) + "s");
	}
	else
	{
		draw_text(view_wport[0]/2, view_hport[0]/2-100, "Steal That Golden Chicken and Run!");
	}
}

if (room == Room4)
{
	if (hasCollectedFakeChicken)
	{
		draw_text(view_wport[0]/2, view_hport[0]/2-100, "Or is it done? :)");
	}
	else
	{
		draw_text(view_wport[0]/2, view_hport[0]/2-100, "Well Done. You did it!");
	}
}