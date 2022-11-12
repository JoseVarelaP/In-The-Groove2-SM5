local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffuse(Color.Black)
	end
}

-- Part 2: The modifier list
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:hibernate(7)
	end,

	Def.Sprite{
		Texture="vol3-14-ntsc.mpg",
		InitCommand=function(self)
			self:scale_or_crop_background()
		end
	},

	LoadActor("song list")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+180):CenterY():rotationy(30)
		end
	},
	LoadActor("modes list")..{
		OnCommand=function(self)
			self:hibernate(7):xy( SCREEN_CENTER_X-480, SCREEN_CENTER_Y )
		end
	},
	LoadActor("steps list1")..{
		OnCommand=function(self)
			self:hibernate(4):xy( SCREEN_CENTER_X-180, SCREEN_CENTER_Y - 80 )
			:rotationy(-20)
		end
	},
	LoadActor("course list")..{
		OnCommand=function(self)
			self:xy( SCREEN_CENTER_X+180, SCREEN_CENTER_Y )
			:hibernate(11.5)
		end
	},
	LoadActor("modifers")..{
		OnCommand=function(self)
			self:xy( SCREEN_CENTER_X+180, SCREEN_CENTER_Y )
			:hibernate(16)
		end
	},
	LoadActor("overlay")..{
		OnCommand=function(self)
			self:xy( SCREEN_CENTER_X, SCREEN_CENTER_Y )
			:rotationy(5)
		end
	}
}

-- Part 1: The introduction
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		self:sleep(7):linear(0.5):diffusealpha(0)
	end,
	LoadActor("edgebubble")..{
		OnCommand=function(self)
			self:sleep(5):diffusealpha(0)
		end
	},
	LoadActor("flare")..{
		OnCommand=function(self)
			self:Center()
			self:accelerate(5):zoom(1.3):addy(100)
			:sleep(2):diffusealpha(0)
		end
	},

	LoadActor("flash")..{
		OnCommand=function(self)
			self:Center()
			:zoom(0):sleep(4):linear(4):zoom(20)
		end
	},

	Def.ActorFrame{
		InitCommand=function(self)
			self:Center():zoom(0.8):diffusealpha(0):sleep(0.25):linear(0.25):diffusealpha(1):linear(2.5):zoom(0.7):linear(0.25):diffusealpha(0)
		end,
		FOV=45,
		Def.Sprite{
			Texture="Roxor Games presents",
			OnCommand=function(self)
				self:rotationy(20)
				:linear(4):rotationy(-20)
			end
		}
	},

	Def.ActorFrame{
		InitCommand=function(self)
			self:Center():zoom(0.8):diffusealpha(0):sleep(3):linear(0.25):diffusealpha(1):linear(2):zoom(0.7):linear(0.25):diffusealpha(0)
		end,
		FOV=45,
		Def.Sprite{
			Texture="the next generation",
			OnCommand=function(self)
				self:rotationy(20):sleep(2.5)
				:linear(4):rotationy(-20)
			end
		}
	},

	LoadActor("were just getting started")..{
		OnCommand=function(self)
			self:Center():rotationz(-20)
			:hibernate(5):sleep(2):linear(.5):diffusealpha(0)
		end
	}
}

return t