return Def.ActorFrame{
	OnCommand=function(self)
		self:xy(35,38)
	end,

	Def.BitmapText{
		Font=_eurostileColorPick(),
		Text=Screen.String("HeaderText"),
		InitCommand=function(self) self:shadowlength(4):x(self:GetWidth()/2) end,
		OnCommand=function(self)
			self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
			MESSAGEMAN:Broadcast("UpdateColoring")
		end,
		OffCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			SOUND:PlayOnce( ThemePrefs.Get("ITG1") and THEME:GetPathS("ITG1/Common","start")
			or THEME:GetPathS("_ITGCommon","start") )
		end,
		CancelMessageCommand=function(self)
			self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
		end
	}
}