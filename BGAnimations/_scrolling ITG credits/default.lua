return Def.ActorFrame{
	Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_CENTER_X+2;y,SCREEN_CENTER_Y+18);
		LoadActor("credits frame"),
		Def.Quad{ OnCommand=cmd(y,-226;zwrite,1;blend,"BlendMode_NoEffect";zoomto,340,66) },
		Def.Quad{ OnCommand=cmd(y,223;zwrite,1;blend,"BlendMode_NoEffect";zoomto,340,66) },
		LoadActor( THEME:GetPathB("","_ITG credits text") ),
	},
}