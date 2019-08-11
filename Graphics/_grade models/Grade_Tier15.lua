return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.85):wag():effectmagnitude(0,10,0)
	end;

	LoadActor("c.txt"),
}