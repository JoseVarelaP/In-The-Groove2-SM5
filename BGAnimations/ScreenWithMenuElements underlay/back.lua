return Def.ActorFrame{
	InitCommand=cmd(y,SCREEN_TOP+42);
	LoadActor("streak")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;zoomtowidth,SCREEN_WIDTH;cropleft,-0.2;cropright,-0.2);
		DoOnCommand=cmd(diffusealpha,1;cropright,1.2;cropleft,-0.2;linear,1;cropright,-0.2);
		DoOffCommand=cmd(linear,0.5;diffusealpha,0);
	},

	LoadActor("flare")..{
		InitCommand=cmd(x,SCREEN_LEFT-128);
		DoOnCommand=cmd(x,SCREEN_LEFT-128;rotationz,0;linear,1;x,SCREEN_RIGHT+128;rotationz,360);
	},
}