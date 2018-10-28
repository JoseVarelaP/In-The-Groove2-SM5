return Def.ActorFrame{
	OnCommand=cmd(zoom,0.8;rotationy,-90;spin;effectmagnitude,0,40,0);
	LoadActor("s.txt")..{ OnCommand=cmd(x,-25) },
	LoadActor("smooth plus.txt")..{ OnCommand=cmd(x,30) },
}