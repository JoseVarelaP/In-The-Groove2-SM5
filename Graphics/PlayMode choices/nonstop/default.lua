local t = Def.ActorFrame{
	ModeNotChosenMessageCommand=function(self)
		self:linear(0.5):zoom(0):sleep(5)
	end;
	ModenonstopChosenMessageCommand=function(self)
		self:linear(0.4):zoom(1.01):addy(-30):sleep(1):linear(0.4):zoom(0):sleep(3)
	end;
}

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:xy(-150,30) end;
	GainFocusCommand=function(self)
		self:pulse():effectmagnitude(1.2,1,0):effectclock("bgm"):effectperiod(1):effecttiming( 0.5,0,0.25,1,0.25 ):effectoffset(0.5)
	end;
	LoseFocusCommand=function(self) self:stopeffect() end;	

	LoadActor("flag")..{ OnCommand=function(self) self:zbuffer(true):z(100) end };
};

t[#t+1] = LoadActor("title")..{ OnCommand=function(self) self:zbuffer(true):z(120) end };

return t;
