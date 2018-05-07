return Def.ActorFrame{
	OnCommand=cmd(zoom,0.7;rotationy,-90;spin;effectmagnitude,0,40,0);
	LoadActor("b.txt")..{ OnCommand=cmd(x,-20) },
	LoadActor("b plus.model")..{ OnCommand=cmd(x,35) },
}