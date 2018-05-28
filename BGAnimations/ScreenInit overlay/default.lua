return Def.ActorFrame {
		Def.Quad {
			InitCommand=cmd(FullScreen);
			OnCommand=cmd(diffuse,Color.Black;sleep,1.5;linear,0.25);
		};
		LoadActor("splash")..{ OnCommand=cmd(Center); },
	};
