local inWorkout = GAMESTATE:Env()["WorkoutMode"]
return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self)
			self:diffuse( Color.Black ):FullScreen()
			:diffusealpha( inWorkout and 0 or 1 )
		end,
		StartTransitioningCommand=function(self)
			if inWorkout then
				SOUND:DimMusic(0,3)
			end
			self:cropleft(1):fadeleft(.5):linear(0.5):cropleft(-0.5):sleep(0.5)
		end
	},

	Def.Sound{
		File=THEME:GetPathS("","_screen cancel"),
		StartTransitioningCommand=function(self)
			self:play()
		end
	}
}
