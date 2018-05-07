return Def.ActorFrame{
	LoadActor("star.txt")..{ OnCommand=cmd(x,-19;y,20;;zoom,0.6;wag;effectmagnitude,0,4,10) },
	LoadActor("star.txt")..{ OnCommand=cmd(x,19;y,-20;zoom,0.6;wag;effectmagnitude,0,4,10) },
}