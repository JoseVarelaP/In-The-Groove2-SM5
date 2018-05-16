return Def.ActorFrame{
	LoadActor("../_moveon")..{
	StartTransitioningCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0;sleep,0.2;linear,0.1;diffusealpha,1;sleep,0.2);
	},
}