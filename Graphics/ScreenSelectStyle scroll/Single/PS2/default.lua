return Def.ActorFrame{
	ModeNotChosenMessageCommand=function(self)
		self:linear(0.5):zoom(0):sleep(5)
	end;
	ModesingleChosenMessageCommand=function(self)
		self:linear(0.4):zoom(1.01):addy(-30):sleep(1):linear(0.4):zoom(0):sleep(3)
	end;
	Def.ActorFrame{
		LoadActor("title")..{
			InitCommand=function(self)
				self:x(-20):z(30):y(-50):shadowlength(4):ztest(1):zoom(1.2)
			end;
			EnabledCommand=function(self)
				self:stopeffect()
			end;
			DisabledCommand=function(self)
				self:diffuseshift():effectcolor1(0,0,0,1):effectcolor2(0,0,0,1)
			end;
		},

		Def.ActorFrame{
			OnCommand=function(self)
				self:x(200):zoom(0.6)
			end,
			LoadActor("one pad")..{
				InitCommand=function(self)
					self:y(30):ztest(1):zoom(1.1):shadowlength(4)
				end;
				EnabledCommand=function(self)
					self:stopeffect()
				end;
				DisabledCommand=function(self)
					self:diffuseshift():effectcolor1(0,0,0,1):effectcolor2(0,0,0,1)
				end;
			},

			Def.Sprite {
				Texture="girl",
				Frames=Sprite.LinearFrames(10, 1),
				InitCommand=function(self)
					self:y(-90):ztest(1):shadowlength(4)
				end;
				EnabledCommand=function(self)
					self:stopeffect()
				end;
				DisabledCommand=function(self)
					self:diffuseshift():effectcolor1(0,0,0,1):effectcolor2(0,0,0,1)
				end;
			},
		}
	}
}