return Def.ActorFrame{
	Def.ActorFrame{
		OnCommand=function(self)
			self:y(30):zoom(1.6):fov(30)
		end;
		GainFocusCommand=function(self)
			self:wag():effectmagnitude(0,10,0)
		end;
		LoseFocusCommand=function(self)
			self:stopeffect()
		end;
			LoadActor("../../_platform home single")..{
				InitCommand=function(self)
					self:ztest(1)
				end;
				OnCommand=function(self)
					self:rotationx(30)
				end;
			},
		},

		LoadActor("tag")..{
			InitCommand=function(self)
				self:z(30):y(-50):shadowlength(4):ztest(1)
			end;
			EnabledCommand=function(self)
				self:stopeffect()
			end;
			DisabledCommand=function(self)
				self:diffuseshift():effectcolor1(0,0,0,1):effectcolor2(0,0,0,1)
			end;
		},
}