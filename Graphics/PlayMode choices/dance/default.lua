local t = Def.ActorFrame{}

t[#t+1] = LoadActor("title")..{ OnCommand=function(self) self:zbuffer(true) end };

local pos = {"left","right"}
for i=1,2 do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:xy(-150,30) end;
		GainFocusCommand=function(self)
			self:pulse():effectmagnitude(1.2,1,0):effectclock("bgm"):effectperiod(1):effectoffset(0.5*i)
		end;
		LoseFocusCommand=function(self) self:stopeffect() end;
	
		LoadActor(pos[i].." foot")..{ OnCommand=function(self) self:zbuffer(true) end };
	}
end

return t;

-- <ActorFrame
-- 	MadeChoiceP1MessageCommand="playcommand,GoOff"
-- 	MadeChoiceP2MessageCommand="playcommand,GoOff"
-- 	GoOffCommand="%function(self) self:linear(0.5); local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01; if bHasFocus then self:x(0); self:y(0); self:z(200); self:diffuse(1,1,1,1); self:zoom(1); self:glowblink(); self:sleep(0.5); self:linear(0.5); self:zoom(0); else self:x(0); self:y(0); self:z(0); self:zoom(0); end self:sleep(5) end"
-- > <children>
-- 	<AutoActor 
-- 		File="title"
-- 		InitCommand="zbuffer,1"
-- 	/>
-- 	<ActorFrame
-- 		InitCommand="x,-150;y,30"
-- 		GainFocusCommand="pulse;effectmagnitude,1.2,1,0;effectclock,bgm;effectperiod,.5;effectdelay,.5;effectoffset,0.6"
-- 		LoseFocusCommand="stopeffect"
-- 	> <children>
-- 		<AutoActor 
-- 			File="left foot"
-- 			InitCommand="zbuffer,1"
-- 		/>
-- 		<AutoActor 
-- 			File="right foot"
-- 			InitCommand="zbuffer,1"
-- 		/>
-- 	</children> </ActorFrame>
-- </children> </ActorFrame>
