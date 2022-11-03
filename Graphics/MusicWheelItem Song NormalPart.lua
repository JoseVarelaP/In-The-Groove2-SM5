local style = ThemePrefs.Get("ITG1") and "ITG1/" or ""
return Def.ActorFrame{
	OnCommand=function(s)
		s:ztest(1):addx(-420):sleep(0.35):linear(0.5):addx(420)
	end;
	OffCommand=function(s) s:linear(0.5):addx(-420) end;
	CancelMessageCommand=function(s) if GAMESTATE:Env()["WorkoutMode"] then s:linear(0.5):addx(-420) end end;

	Def.Sprite{ Texture="WheelItems/"..style.."WheelSong NormalPart" },

	Def.ActorFrame{
		Name="SongContents",
		SetMessageCommand=function(self,params)
			self:shadowlength(1)
			local song = params.Song;
			if song then
				self:GetChild("Title"):diffuse( params.Color )
				:settext(song:GetDisplayMainTitle())
				self:GetChild("SubTitle"):diffuse( params.Color )
				:settext(song:GetDisplaySubTitle()):zoom(0)
				if string.len( song:GetDisplaySubTitle() ) > 2 then
					self:GetChild("SubTitle"):zoom(0.6)
					self:GetChild("Title"):zoom(0.8):y(-7)
				else
					self:GetChild("Title"):zoom(0.85):y(0)
				end
			end
		end,

		Def.BitmapText{
			Font="_eurostile normal",
			Name="Title",
			InitCommand=function(self)
				self:x(95):maxwidth(300):halign(1):shadowlength(1)
			end
		},
		Def.BitmapText{
			Font="_eurostile normal",
			Name="SubTitle",
			InitCommand=function(self)
				self:xy(95,8):maxwidth(460):halign(1):shadowlength(1)
			end
		}
	}
}