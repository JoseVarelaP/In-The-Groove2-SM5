return Def.ActorFrame{
	OnCommand=function(self)
		self:zoom(0.8):wag():effectmagnitude(0,4,10)
	end;
	LoadActor("star.txt"),
}