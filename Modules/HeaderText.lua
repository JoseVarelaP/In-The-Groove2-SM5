return function( ScreenName )
	return Def.ActorFrame{
		OnCommand=function(self)
			self:xy(35,38)
		end,

		Def.BitmapText{
			Font=_eurostileColorPick(),
			Text=string.upper(THEME:GetString(ScreenName,"HeaderText")),
			InitCommand=function(self) self:shadowlength(4):x(self:GetWidth()/2):skewx( IsITG1Mode() and 0 or -0.16) end,
			OnCommand=function(self)
				self:zoomx(0):zoomy(6):sleep(0.3):bounceend(.3):zoom(1)
				if IsITG2PS2Mode() then
					self:zoomy(1.3):zoomx(0.8)
				end
			end;
			OffCommand=function(self)
				self:accelerate(.2):zoomx(2):zoomy(0):diffusealpha(0)
			end
		}
	}
end