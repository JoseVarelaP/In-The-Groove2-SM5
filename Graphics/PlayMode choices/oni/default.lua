local t = Def.ActorFrame{
	ModeNotChosenMessageCommand=function(self)
		self:linear(0.5):zoom(0):sleep(5)
	end;
	ModeoniChosenMessageCommand=function(self)
		self:linear(0.4):zoom(1.01):addy(-30):sleep(1):linear(0.4):zoom(0):sleep(3)
	end;
}

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:xy(-200,30) end;
	GainFocusCommand=function(self)
		self:pulse():effectmagnitude(1.2,1,0):effectclock("bgm"):effecttiming( 0.25,0,0.25,1,0 ):effectoffset(0.5)
	end;
	LoseFocusCommand=function(self) self:stopeffect() end;	

	LoadActor("stopwatch")..{ OnCommand=function(self) self:zbuffer(true):z(0) end };
	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(8,16):rotationz(15):spin():effectmagnitude(0,0,45):effectclock("bgm")
		end;
		LoadActor("hand")..{
			OnCommand=function(self)
				self:zbuffer(true):horizalign(right):vertalign(bottom):xy(24,16)
			end;
		}
	},
	LoadActor("center")..{
		OnCommand=function(self)
			self:zbuffer(true):horizalign(right):vertalign(bottom):xy(36,36)
		end;
	}
};

t[#t+1] = LoadActor("title")..{ OnCommand=function(self) self:z(120):zbuffer(true) end };

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
-- 		OnCommand="x,-150;y,30"
-- 		GainFocusCommand="pulse;effectmagnitude,1.2,1,0;effectclock,bgm;effectperiod,.5;effectdelay,.5;effectoffset,0.6"
-- 		LoseFocusCommand="stopeffect"
-- 	> <children>
-- 		<Layer
-- 			File="stopwatch"
-- 			InitCommand="zbuffer,1"
-- 		/>
-- 		<Layer
-- 			Type="ActorFrame"
-- 			OnCommand="x,8;y,16;rotationz,15;spin;effectmagnitude,0,0,+45;effectclock,bgm"
-- 		> <children>
-- 			<AutoActor 
-- 				File="hand"
-- 				InitCommand="zbuffer,1;horizalign,right;vertalign,bottom;x,24;y,16"
-- 			/>
-- 		</children> </Layer>
-- 		<Layer
-- 			File="center"
-- 			InitCommand="zbuffer,1;horizalign,right;vertalign,bottom;x,36;y,36;hidden,0"
-- 		/>
-- 	</children> </ActorFrame>
-- </children> </ActorFrame>
