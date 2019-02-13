local t = Def.ActorFrame{}

t[#t+1] = LoadActor("title")..{ OnCommand=function(self) self:zbuffer(true) end };

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:xy(-150,30) end;
	GainFocusCommand=function(self)
		self:pulse():effectmagnitude(1.2,1,0):effectclock("bgm"):effectperiod(1):effecttiming( 0.5,0,0.25,1,0.25 ):effectoffset(0.5*i)
	end;
	LoseFocusCommand=function(self) self:stopeffect() end;	

	LoadActor("flag")..{ OnCommand=function(self) self:zbuffer(true):z(100) end };
}

return t;
