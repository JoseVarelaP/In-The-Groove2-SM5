return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.85):wag():EffectMagnitude(0,10,0)
	end;

	LoadActor("c.txt"),
}