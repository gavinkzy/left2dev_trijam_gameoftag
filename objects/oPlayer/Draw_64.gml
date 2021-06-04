DrawSetText(c_white, fDefault, fa_center, fa_middle);
if (hasObtainedFlag)
{
	draw_text(view_wport[0]/2, view_hport[0]/2-100, "Remaining time: " + string((remainingTime/60)) + "s");
}
else
{
	draw_text(view_wport[0]/2, view_hport[0]/2-100, "Capture the flag!");
}