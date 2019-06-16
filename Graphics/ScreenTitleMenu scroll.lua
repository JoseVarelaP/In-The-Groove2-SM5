local children = {
	LoadFont("", "_eurostile outline") ..{
		Text=THEME:GetString( 'ScreenTitleMenu', Var("GameCommand"):GetText() );
		InitCommand=function(self)
			self:horizalign(left):shadowlength(2):setstate(5):pause()
		end;
		GainFocusCommand=function(self)
			self:stoptweening():diffuseshift():effectperiod(0.5):effectcolor1(1,0.5,0.5,1):effectcolor2(0.5,0.25,0.25,1):linear(0):zoom(1.2)
		end;
		LoseFocusCommand=function(self)
			self:stoptweening():stopeffect():linear(0):zoom(1.0)
		end;
		DisabledCommand=function(self)
			self:diffuse(0.5,0.5,0.5,1)
		end;
	};
};

return Def.ActorFrame { children = children };