local t = Def.ActorFrame{
	ModeNotChosenMessageCommand=function(self)
		self:linear(0.5):zoom(0):sleep(5)
	end;
	ModedanceChosenMessageCommand=function(self)
		self:linear(0.4):zoom(1.01):addy(-30):sleep(1):linear(0.4):zoom(0):sleep(3)
	end;
}

local pos = {"left","right"}
for i=1,2 do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:xy(-150,30) end;
		GainFocusCommand=function(self)
			self:pulse():effectmagnitude(1.2,1,0):effectclock("bgm"):effectperiod(1):effectoffset(0.5*i)
		end;
		LoseFocusCommand=function(self) self:stopeffect() end;
	
		LoadActor(pos[i].." foot")..{ OnCommand=function(self) self:zbuffer(true) end };
	};
end

t[#t+1] = LoadActor("title")..{ OnCommand=function(self) self:z(120):zbuffer(true) end };

return t;