local gc = Var("GameCommand");

return Def.ActorFrame{
	MadeChoiceP1MessageCommand=function(self)
		self:playcommand("GoOff")
	end;
	MadeChoiceP2MessageCommand=function(self)
		self:playcommand("GoOff")
	end;
	GoOffCommand=function(self) self:linear(0.5); local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01 if bHasFocus then self:x(0); self:y(0); self:glowblink(); self:sleep(0.5); self:linear(0.5); self:zoom(0); else self:x(0); self:y(0); self:z(0); self:zoom(0); end self:sleep(5) end,

	LoadActor( gc:GetName() ),
}
