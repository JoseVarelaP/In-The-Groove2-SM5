return Def.ActorFrame{
	Def.ActorFrame{
	InitCommand=cmd(zoom,0.8;rotationy,-90;spin;effectmagnitude,0,40,0);
		LoadActor("s.txt")..{ OnCommand=cmd(x,-25) },
		LoadActor("smooth minus.txt")..{ OnCommand=cmd(x,30) },
	},
}