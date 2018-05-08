return Def.ActorFrame{
	LoadActor("triangle")..{
	OnCommand=cmd(x,-48;diffuseblink;effectcolor1,0.6,0.6,0.6,1;effectperiod,0.4;effectoffset,0.2;effectclock,"bgm");
	ExitSelectedP1Command=cmd(stoptweening;linear,.15;rotationz,-90);
	ExitUnselectedP1Command=cmd(stoptweening;linear,.15;rotationz,0);
	},
	
	LoadActor("triangle")..{
	OnCommand=cmd(x,48;diffuseblink;effectcolor1,0.6,0.6,0.6,1;effectperiod,0.4;effectoffset,0.2;effectclock,"bgm");
	ExitSelectedP2Command=cmd(stoptweening;linear,.15;rotationz,90);
	ExitUnselectedP2Command=cmd(stoptweening;linear,.15;rotationz,0);
	},

	LoadActor("moreexit")..{
	OnCommand=cmd(y,-18;croptop,.57;cropbottom,.1);
	},
}
