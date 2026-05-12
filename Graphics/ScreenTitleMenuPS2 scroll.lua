local gc = Var("GameCommand")

local children = {
	Def.Sprite{
		Texture=THEME:GetPathG("ITG2PS2/TitleMenu","choice/icon"),
		InitCommand=function(self)
			self:shadowlength(4)
			if gc:GetName() == "GameStart" then
				self.gain = color("0.5,1.0,0.5,1")
				self.lose = color("0.3,0.6,0.3,1")
			elseif gc:GetName() == "Exit" then
				self.gain = color("1,1,.5,1")
				self.lose = color("0.6,0.6,0.3,1")
			else
				self.gain = color("1,0.3,0.3,1")
				self.lose = color("0.6,0.2,0.2,1")
			end

			self:diffuse( self.lose )
		end,
		GainFocusCommand=function(self)
			self:diffuse( self.gain )
		end;
	},

	Def.BitmapText{
		Font="_serpentine outline",
		Text=THEME:GetString( 'ScreenTitleMenu', gc:GetText() );
		InitCommand=function(self)
			self:shadowlength(2):y(16):zoom(0.9):wrapwidthpixels(150)

			if gc:GetName() == "GameStart" then
				self.gain = color("1,1,0,1")
				self.lose = color("0.5,0.6,0.4,1")
			elseif gc:GetName() == "Exit" then
				self.gain = color("1,0.4,0,1")
				self.lose = color("0.6,0.1,0.0.1")
			else
				self.gain = color("1,.8,0,1")
				self.lose = color("0.55,0.5,0.5,1")
			end

			self:diffuse( self.lose )
		end;
		GainFocusCommand=function(self)
			self:stoptweening():diffuseshift():effectperiod(0.5):effectcolor1(self.gain):effectcolor2(BoostColor(self.gain, 0.5))
		end;
		LoseFocusCommand=function(self)
			self:stoptweening():stopeffect():diffuse(self.lose)
		end;
		DisabledCommand=function(self)
			self:diffuse(0.5,0.5,0.5,1)
		end;
	};
};

return Def.ActorFrame { children = children };