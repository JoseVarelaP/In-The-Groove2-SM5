local children = {
	LoadFont("", "_eurostile outline") ..{
		Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() );
		InitCommand=cmd(horizalign,left;shadowlength,2;setstate,5;pause);
		GainFocusCommand=cmd(stoptweening;diffuseshift;effectperiod,0.5;effectcolor1,1,0.5,0.5,1;effectcolor2,0.5,0.25,0.25,1;linear,0;zoom,1.1);
		LoseFocusCommand=cmd(stoptweening;stopeffect;linear,0;zoom,1.0);
		DisabledCommand=cmd(diffuse,0.5,0.5,0.5,1);
	};
};

return Def.ActorFrame { children = children };