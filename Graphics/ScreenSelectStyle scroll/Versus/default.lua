return Def.ActorFrame{
	MadeChoiceP1MessageCommand=function(self)
		self:playcommand("GoOff")
	end;
	MadeChoiceP2MessageCommand=function(self)
		self:playcommand("GoOff")
	end;
	ModeNotChosenCommand=function(self)
		self:linear(0.5):zoom(0):sleep(5)
	end;
	ModeversusChosenMessageCommand=function(self)
		self:linear(0.4):zoom(1.01):addy(-30):sleep(1):linear(0.4):zoom(0):sleep(3)
	end;
	GoOffCommand=function(self) self:linear(0.5); local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01 if bHasFocus then self:x(0); self:y(0); self:glowblink(); self:sleep(0.5); self:linear(0.5); self:zoom(0); else self:x(0); self:y(0); self:z(0); self:zoom(0); end self:sleep(5) end,

		Def.ActorFrame{
		OnCommand=function(self)
			self:y(30):zoom(1.6)
		end;
		GainFocusCommand=function(self)
			self:wag():effectmagnitude(0,10,0)
		end;
		LoseFocusCommand=function(self)
			self:stopeffect()
		end;
			LoadActor("../../_platform home single")..{
				InitCommand=function(self)
					self:x(-54):ztest(1)
				end;
				OnCommand=function(self)
					self:rotationx(30)
				end;
			},
			LoadActor("../../_platform home single")..{
				InitCommand=function(self)
					self:x(54):ztest(1)
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
