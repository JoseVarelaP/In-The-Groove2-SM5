return Def.ActorFrame{
	LoadActor("d.txt")..{
	OnCommand=cmd(zoom,0.85;wag;effectmagnitude,0,0,10);
	},
}