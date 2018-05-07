return Def.ActorFrame{
	Def.ActorFrame{
		OnCommand=cmd(y,30;zoom,1.6;fov,30);
		GainFocusCommand=cmd(wag;effectmagnitude,0,10,0);
		LoseFocusCommand=cmd(stopeffect);
			LoadActor("../../_platform home single")..{
				InitCommand=cmd(ztest,1);
				OnCommand=cmd(rotationx,30);
			},
		},

		LoadActor("tag")..{
			InitCommand=cmd(z,30;y,-50;shadowlength,4;ztest,1);
			GainFocusCommand=cmd();
			LoseFocusCommand=cmd();
			EnabledCommand=cmd(stopeffect);
			DisabledCommand=cmd(diffuseshift;effectcolor1,0,0,0,1;effectcolor2,0,0,0,1);
		},
}