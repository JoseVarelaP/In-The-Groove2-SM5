return Def.ActorFrame{
	OnCommand=function(s)
		s:ztest(1):addx(-420):sleep(0.35):linear(0.5):addx(420)
	end;
	OffCommand=function(s) s:linear(0.5):addx(-420) end;
	CancelMessageCommand=function(s) if GAMESTATE:Env()["WorkoutMode"] then s:linear(0.5):addx(-420) end end;

	Def.Sprite{ Texture="WheelItems/WheelSong NormalPart" },
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=function(s)
		s:zoom(1):x(100):maxwidth(280)
	end;
	SetMessageCommand=function(s,params)
	s:shadowlength(1)
	local song = params.Song;
		if song then
			s:diffuse( params.Color )
			:settext(song:GetDisplayMainTitle())
			if string.len( song:GetDisplaySubTitle() ) > 2 then
				s:zoom(0.9):y(-7)
			else
				s:zoom(0.95):y(0)
			end
		end
		s:halign(1)
	end
	},
	Def.BitmapText{
	Font="_eurostile normal", InitCommand=function(s)
		s:zoom(1):xy(-110,-10):maxwidth(460)
	end;
	SetMessageCommand=function(s,params)
	s:shadowlength(1)
	local song = params.Song;
		if song then
			s:diffuse( params.Color )
			:settext(song:GetDisplaySubTitle()):zoom(0)
			if string.len( song:GetDisplaySubTitle() ) > 2 then
				s:zoom(0.6):xy(100,8)
			end
		end
		s:halign(1)
	end
	},
}