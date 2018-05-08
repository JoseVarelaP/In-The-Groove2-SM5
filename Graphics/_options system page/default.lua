return Def.ActorFrame{
	LoadActor("options page")..{
	OnCommand=cmd(addy,-1);
	},

	LoadActor("line highlight mask right")..{
	OnCommand=cmd(addy,-135;x,290;zwrite,1;blend,Blend.NoEffect);
	},
}