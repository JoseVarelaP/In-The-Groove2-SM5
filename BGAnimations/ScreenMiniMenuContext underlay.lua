return Def.ActorFrame{
	-- TODO: Investigate this weird offset.
	InitCommand=function(self)
		self:xy(-SCREEN_WIDTH*.2425,-SCREEN_HEIGHT*.5)
	end,

	Def.Quad{
		 OnCommand=function(self)
			self:FullScreen():diffuse(0,0,0,0):linear(0.3):diffusealpha(0.75)
		end
	},

	Def.ActorFrame{
		OnCommand=function(self)
			self:xy(SCREEN_LEFT+35,SCREEN_TOP+38)
		end,

		Def.BitmapText{
			Font=_eurostileColorPick(),
			Text="PROFILE OPTIONS",
			InitCommand=function(self) self:finishtweening() self:shadowlength(4):x(self:GetWidth()/2):skewx( ThemePrefs.Get("ITG1") and 0 or -0.16) end,
			OnCommand=function(self)
				self:finishtweening():diffusealpha(1):zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
			end,
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end
		}
	}
}