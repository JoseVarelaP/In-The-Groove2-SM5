return Def.ActorFrame{
	LoadActor("star.txt")..{ OnCommand=cmd(x,-25;y,20;;zoom,0.5;wag;effectmagnitude,0,4,10) },
	LoadActor("star.txt")..{ OnCommand=cmd(x,0;y,-20;zoom,0.5;wag;effectmagnitude,0,4,10) },
	LoadActor("star.txt")..{ OnCommand=cmd(x,25;y,20;;zoom,0.5;wag;effectmagnitude,0,4,10) },
}