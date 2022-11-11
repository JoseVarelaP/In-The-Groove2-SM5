return Def.ActorFrame{
	LoadActor(THEME:GetPathB("_ITG1 blue","streak"))..{
		OnCommand=function(self)
			local zoompos = {1.4,2.2,2}
			self:zoom(zoompos[1]):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):linear(1):cropleft(-0.3):zoom(zoompos[2]):linear(3):zoom(zoompos[3])
		end
	},
	Def.Sprite{
		Texture="were just",
		OnCommand=function(self)
			self:xy(-SCREEN_WIDTH, -50):sleep(0.45):decelerate(0.6):x(0):linear(2):zoom(1.1)
		end
	},
	Def.Sprite{
		Texture="getting started",
		OnCommand=function(self)
			self:xy(SCREEN_WIDTH,50):sleep(0.45):decelerate(0.6):x(0):linear(2):zoom(1.1)
		end
	}
}