return Def.ActorFrame{
	InitCommand=function(self)
		self:y(SCREEN_TOP+42)
	end,
	OnCommand=function(self)
		local autoSkip = {
			["ITG_PlayModeSelect"] = true,
			["ScreenTitleMenuPS2"] = true,
		}
		if SCREENMAN:GetTopScreen():GetName() then
			if not autoSkip[SCREENMAN:GetTopScreen():GetName()] then
				self:playcommand("DoOn"):finishtweening()
			end
		end
	end,

	-- Dark underlay
	Def.Quad{
		InitCommand=function(self)
			self:diffusetopedge(color("0.5,0.4,0.4,0.5"))
			:diffusebottomedge(color("0,0,0,0.5"))
			:FullScreen():faderight(0.1):fadeleft(0.1)
			:cropright(-.1):cropleft(-.1):diffusealpha(0)
		end,
		DoOnCommand=function(self)
			self:diffusealpha(0):linear(0.5):diffusealpha(0.5)
		end,
		DoOffCommand=function(self)
			self:linear(0.5):diffusealpha(0)
		end
	},

	
	Def.Sprite{
		Texture=THEME:GetPathG("ITG2PS2/SWME","underlay/streak"),
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X):zoomtowidth(SCREEN_WIDTH):cropleft(-0.2):cropright(1.2)
		end,
		DoOnCommand=function(self)
			self:diffusealpha(1):cropright(1.2):cropleft(-0.2):linear(1):cropright(-0.2)
		end,
		DoOffCommand=function(self)
			self:linear(0.5):diffusealpha(0)
		end
	},

	Def.Sprite{
		Texture="flare",
		InitCommand=function(self)
			self:x(SCREEN_LEFT-128):visible(false)
		end,
		DoOnCommand=function(self)
			self:x(SCREEN_LEFT-128):visible(true):rotationz(0):linear(1):x(SCREEN_RIGHT+128):rotationz(360)
		end
	},

	Def.ActorFrame{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-104)
		end,
		DoOnCommand=function(self)
			self:addy(60):decelerate(0.5):addy(-60)
		end,
		DoOffCommand=function(self)
			self:decelerate(0.5):addy(60)
		end,
		EvalOnCommand=function(self)
			self:y(SCREEN_BOTTOM-50)
		end,
		Def.Sprite{
			Texture=THEME:GetPathG("ITG2PS2/SWME","footer/footer"),
			InitCommand=function(self)
				self:diffusealpha(0.8):zoomtowidth(SCREEN_WIDTH):vertalign(top)
			end,
			DoLargeCommand=function(self)
				self:stoptweening():decelerate(0.3):y(-30)
			end,
			DoSmallCommand=function(self)
				self:stoptweening():decelerate(0.3):y(0)
			end,
		},
	}
}