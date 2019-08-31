local style = ThemePrefs.Get("ITG1") and "ITG1/" or ""
return Def.ActorFrame{
	OnCommand=function(s)
		s:ztest(1):addx(-420):sleep(0.35):linear(0.5):addx(420)
	end;
	OffCommand=function(s) s:linear(0.5):addx(-420) end;
	CancelMessageCommand=function(s) if GAMESTATE:Env()["WorkoutMode"] then s:linear(0.5):addx(-420) end end;

	Def.Sprite{ Texture="WheelItems/"..style.."WheelSong NormalPart" },
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=function(s)
		s:zoom(1):y(0):x(100):maxwidth(280)
	end;
	SetMessageCommand=function(s,params)
	s:shadowlength(1)
	local song = params.Course;
		if song then
			s:diffuse(params.Color)
			:settext(song:GetDisplayFullTitle())
		end
		s:halign(1)
	end
	},
}