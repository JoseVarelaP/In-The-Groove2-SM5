return Def.ActorFrame{
	Def.Quad{
	InitCommand=function(self)
		self:diffuse( GAMESTATE:Env()["WorkoutMode"] and color("#00000000") or color("#000000") ):FullScreen()
	end;
	StartTransitioningCommand=function(self)
		if GAMESTATE:Env()["WorkoutMode"] then
			SOUND:DimMusic(0,3)
		end
		self:cropleft(1):fadeleft(.5):linear(0.5):cropleft(-0.5):sleep(0.5)
	end;
	},

	LoadActor( THEME:GetPathS("","_screen cancel") )..{
		StartTransitioningCommand=function(self)
			self:play()
		end;
	},
}
