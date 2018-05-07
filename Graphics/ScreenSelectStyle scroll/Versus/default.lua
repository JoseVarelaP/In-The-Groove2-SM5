return Def.ActorFrame{
	MadeChoiceP1MessageCommand=cmd(playcommand, "GoOff");
	MadeChoiceP2MessageCommand=cmd(playcommand, "GoOff");
	GoOffCommand=function(self) self:linear(0.5); local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01 if bHasFocus then self:x(0); self:y(0); self:glowblink(); self:sleep(0.5); self:linear(0.5); self:zoom(0); else self:x(0); self:y(0); self:z(0); self:zoom(0); end self:sleep(5) end,

		Def.ActorFrame{
		OnCommand=cmd(y,30;zoom,1.6;fov,30);
		GainFocusCommand=cmd(wag;effectmagnitude,0,10,0);
		LoseFocusCommand=cmd(stopeffect);
			LoadActor("../../_platform home single")..{
				InitCommand=cmd(x,-54;ztest,1);
				OnCommand=cmd(rotationx,30);
			},
			LoadActor("../../_platform home single")..{
				InitCommand=cmd(x,54;ztest,1);
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
