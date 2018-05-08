return Def.ActorFrame{

	LoadActor("ScreenOptions underlay"),

	LoadActor( THEME:GetPathG("","MapController Mask") )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+40;zwrite,true;z,1;blend,"BlendMode_NoEffect");
	},


}