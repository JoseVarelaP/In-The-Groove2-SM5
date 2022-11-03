local style = ThemePrefs.Get("ITG1") and "ITG1/" or ""

local function IsValidUSBProfileFolder( Player )
	if GAMESTATE:GetCurrentSong() == nil then return false end
	if type(PROFILEMAN:GetProfile(Player):GetDisplayName()) ~= "string" then return false end
	return GAMESTATE:GetCurrentSong():GetGroupName() == PROFILEMAN:GetProfile(Player):GetDisplayName()
end

return Def.ActorFrame{

	Def.ActorFrame{
	OnCommand=function(s) s:fov(58):xy(-10,2):zoomy(0.985):rotationy(-20):addx(450):decelerate(0.75):addx(-450) end;
	OffCommand=function(s) s:accelerate(0.75):addx( IsUsingWideScreen() and 500 or 450); end,
	CancelMessageCommand=function(s) if GAMESTATE:Env()["WorkoutMode"] then s:accelerate(0.75):addx( IsUsingWideScreen() and 500 or 450); end end,

  		Def.ActorFrame{
		InitCommand=function(s) s:xy(40,-110) end;

			Def.Sprite{ Texture="../ScreenSelectMusic banner mask",
				InitCommand=function(s)
					s:zoom(1.12):xy(17,8):zwrite(true):z(1):blend("BlendMode_NoEffect")
				end;
			};
			Def.Sprite{ Texture="../ScreenSelectMusic banner mask",
				InitCommand=function(s)
					s:zoom(1.12):zoomx(-1.12):x(187,7):zwrite(true):z(1):blend("BlendMode_NoEffect")
				end;
			};
			Def.ActorProxy{
				BeginCommand=function(s) s:SetTarget( SCREENMAN:GetTopScreen():GetChild('Banner') ); end,
				InitCommand=function(self)
					if IsUsingWideScreen() then
						self:x(61):zoomx(2.2)
					else
						self:x(10):zoomx(1.8)
					end
					self:y(-3):setsize(418,164):zoomy(1.6)
				end
			},

			Def.Sprite{
				Texture=THEME:GetPathG("Banner","Custom"),
				OnCommand=function(s)
					s:ztest(1)
					if IsUsingWideScreen() then
						s:x(63):y(-3):setsize(418,164):zoomy(0.8):zoomx(1.34)
					else
						s:x(10):y(-3):setsize(418,164):zoomy(0.8):zoomx(1.1)
					end
				end;
				CurrentSongChangedMessageCommand=function(s)
					s:stoptweening():linear(0.3):diffusealpha(0)
					if GAMESTATE:GetCurrentSong() then
						for pn in ivalues(PlayerNumber) do
							if IsValidUSBProfileFolder(pn) then
								s:diffusealpha(1)
							end
						end
					end
				end;
			};

			Def.Sprite{
				Texture=ThemePrefs.Get("ITG1") and "../ITG1/Common fallback banner" or "../ITG2 Common fallback banner",
				InitCommand=function(s)
					s:ztest(1)
					if IsUsingWideScreen() then
						s:x(63):y(-3):setsize(418,164):zoomy(0.8):zoomx(1.34)
					else
						s:x(10):y(-3):setsize(418,164):zoomy(0.8):zoomx(1.1)
					end
				end;
				CurrentCourseChangedMessageCommand=function(s)
					if GAMESTATE:GetCurrentCourse() then
						s:stoptweening():linear(0.3):diffusealpha(1)
						if GAMESTATE:GetCurrentCourse():GetBannerPath() ~= nil then 
							s:diffusealpha(0)
						end
					end
				end;
				CurrentSongChangedMessageCommand=function(s)
					s:stoptweening():linear(0.3):diffusealpha(1)
					if GAMESTATE:GetCurrentSong() then
						if GAMESTATE:GetCurrentSong():GetBannerPath() ~= nil then 
							s:diffusealpha(0)
						end
						for pn in ivalues(PlayerNumber) do
							if GAMESTATE:GetCurrentSong():IsCustomSong() then
								s:diffusealpha(0)
							end
						end
					else
						if GAMESTATE:Env()["CurrentGroupSelected"] then
							if SONGMAN:GetSongGroupBannerPath( GAMESTATE:Env()["CurrentGroupSelected"] ) ~= "" then
								s:diffusealpha(0)
							end
						end
					end
				end;
			};

			LoadActor( THEME:GetPathG('ScreenSelectMusic','StepsDisplayList') )..{ OnCommand=function(s) s:ztest(0):y(128):zoomx(1):zoomy(0.94) end };
			LoadActor( THEME:GetPathG('ScreenSelectMusic','CourseDisplayList') )..{ OnCommand=function(s) s:ztest(0):y(126):zoomx(1):zoomy(0.94) end };

		Def.ActorFrame{
		Condition=ThemePrefs.Get("MarathonLabel") == "ITG";
			-- Long/Marathon labels - ITG style
			Def.BitmapText{
			Text=THEME:GetString("Balloons","ITGLong"),
			Font=ThemePrefs.Get("ITG1") and "_big blue glow" or "_big red glow",
			OnCommand=function(s) s:shadowlength(2):zoom(1):xy(5,200):diffuseshift():playcommand("Set") end;
			CurrentSongChangedMessageCommand=function(s) s:playcommand("Set") end;
			SetCommand=function(s) s:diffusealpha(0)
				if GAMESTATE:GetCurrentSong() then
					local checks = {
						{GAMESTATE:GetCurrentSong():IsLong(), THEME:GetString("Balloons","ITGLong") },
						{GAMESTATE:GetCurrentSong():IsMarathon(), THEME:GetString("Balloons","ITGMarathon") }
					}
					for v in ivalues(checks) do if v[1] then s:diffusealpha(1):settext(v[2]) end end
				end
			end
			};
		};


		Def.ActorFrame{
		Condition=ThemePrefs.Get("MarathonLabel") == "OITG" and not GAMESTATE:IsCourseMode(),
		OnCommand=function(self) self:playcommand("Set") end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if not song then return end
			local cost = song:GetStageCost()
			self:visible( song ~= nil and cost > 1 )
			if cost < 2 then return end

			local state = cost == 2 and "Long" or "Marathon"

			local colset = { color("0.8,0.8,0.8,1"), color("0.5,0.5,0.5,1")  }

			if song:IsMarathon() then
				colset = { color("1,0.3,0.3,1"), color("0.7,0.1,0.1,1") }
			end

			self:GetChild("Ballon"):effectcolor1(colset[1]):effectcolor2(colset[2])

			self:GetChild("Desc"):settext( THEME:GetString("Balloons","OITG"..state) )
		end,
			-- Long/Marathon labels - OITG style
			Def.Sprite{
				Name="Ballon",
				Texture="OITG Balloon",
				InitCommand=function(s)
					s:shadowlength(2):zoom(1):zoomx(1.22):xy(-200,45):halign(0):effectclock("bgm")
					:diffuseshift():effectoffset(0.2)
				end;
			},

			Def.BitmapText{
				Name="Desc",
				Font="_eurostile normal",
				InitCommand=function(self)
					self:shadowlength(1):zoom(0.5):zoomx(0.55):xy(-180,45):halign(0)
				end
			},

			Def.BitmapText{
				Text="MODS",
				Font="_eurostile normal",
				Condition=GAMESTATE:IsCourseMode(),
				InitCommand=function(self)
					self:shadowlength(2):zoom(1.3):xy(-130,35):diffuseshift():effectcolor1(color("0.4,0.4,0.4,1"))
					:visible( (GAMESTATE:GetCurrentCourse() and GAMESTATE:GetCurrentCourse():HasMods()) )
				end,
				CurrentCourseChangedMessageCommand=function(self)
					self:visible( (GAMESTATE:GetCurrentCourse() and GAMESTATE:GetCurrentCourse():HasMods()) )
				end
			},

		},

		};

		Def.Sprite{ Texture=style.."right frame edge", OnCommand=function(s) s:x(-200):halign(0):zoomx(1) end };
		Def.Sprite{ Texture=style.."right frame middle", OnCommand=function(s) s:x(-200+158):halign(0):zoomx(40) end };
		Def.Sprite{ Texture=style.."right frame right", OnCommand=function(s) s:x(200+78):halign(0) end };
	},

	Def.ActorFrame{
	OnCommand=function(s)
		s:y(1):addx(500):decelerate(0.75):addx(-500)
	end;
	-- FIVE FIVE FIVE GUYS
	OffCommand=function(s) s:accelerate(0.75):addx( IsUsingWideScreen() and 555 or 450); end,
	CancelMessageCommand=function(s) if GAMESTATE:Env()["WorkoutMode"] then s:accelerate(0.75):addx( IsUsingWideScreen() and 555 or 450); end end,

		Def.BitmapText{
		Text=string.upper(THEME:GetString("BannerFrame","Artist"));
		Font="_eurostile normal",
		OnCommand=function(s)
			s:halign(0):shadowlength(2):zoom(0.5):xy(-165,-38):diffusealpha(0.5)
		end;
		},

		Def.BitmapText{
		Font="_eurostile normal",
		OnCommand=function(s)
			s:halign(0):shadowlength(2):zoom(0.6):xy(-165,-22):diffusealpha(1)
		end;
		CurrentSongChangedMessageCommand=function(s)
			s:settext( GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetDisplayArtist() or "" )
		end,
		},

		Def.HelpDisplay {
			File="_eurostile normal",
			OnCommand=function(s) s:halign(0):shadowlength(2):zoom(0.6):xy(-165,-22):diffusealpha(1):SetSecsBetweenSwitches(1.5) end;
			OffCommand=function(s) s:linear(0.5):zoomy(0) end;
			CurrentCourseChangedMessageCommand=function(s)
				if GAMESTATE:GetCurrentCourse() then
					local Artists = GAMESTATE:GetCurrentCourse():GetCourseEntries()
					rec_print_table(Artists)
					local complete = ""
					for v in ivalues(Artists) do
						if v and v:GetSong() then
							complete = complete .. v:GetSong():GetDisplayArtist() .. "::"
						else
							complete = "???"
						end
					end
					s:SetTipsColonSeparated(complete)
				end
			end;
		},

		Def.BitmapText{
		Text="BPM",
		Font="_eurostile normal",
		OnCommand=function(s)
			s:shadowlength(2):zoom(0.5):xy(55,-32):diffusealpha(0.5)
		end;
		},

		Def.BitmapText{
		Font="_eurostile normal",
		OnCommand=function(s)
			s:halign(0):shadowlength(2):zoom(0.6):xy(40,-18)
		end;
		CurrentSongChangedMessageCommand=function(s)
			local song = GAMESTATE:GetCurrentSong()
			local val = ""
			if song then
				local bpms = song:GetDisplayBpms()
				if bpms[1] == bpms[2] then
					val = string.format("%i",bpms[1])
				else
					val = string.format("%i-%i",bpms[1],bpms[2])
				end
			end
			s:settext(val)
		end;
		CurrentCourseChangedMessageCommand=function(s)
			local course = GAMESTATE:GetCurrentCourse()
			local val = {0,0}
			if course then
				local entries = course:GetCourseEntries()
				for v in ivalues(entries) do
					if v and v:GetSong() then
						local bpms = v:GetSong():GetDisplayBpms()
						for i=1,2 do
							if bpms[i] > val[i] then val[i] = bpms[i] end
						end
					end
				end
				if val[1] == val[2] then
					val = string.format("%i",val[1])
				else
					val = string.format("%i-%i",val[1],val[2])
				end
				s:settext(val == "0" and "???" or val)
			end
		end;
		},

		-- need to figure out how to get pop
		Def.BitmapText{ Text="POP", Font="_eurostile normal",
		OnCommand=function(s) s:shadowlength(2):zoom(0.5):xy(150,-30):diffusealpha(0.5) end;
		},

		-- Ordinal Number conversion based on einpoklum's c++ implementation.
		-- https://stackoverflow.com/a/40350026
		Def.BitmapText{ Font="_eurostile normal",
		OnCommand=function(s) s:shadowlength(2):zoom(0.6):xy(138,-16):diffusealpha(1):halign(0) end;
		CurrentSongChangedMessageCommand=function(s)
			local sufixes = {"th","st","nd","rd"}
			local song = GAMESTATE:GetCurrentSong()
			local val = ""
			if song and SONGMAN:GetSongRank(song) then
				local ord = SONGMAN:GetSongRank(song) % 100
				if (ord / 10 == 1) then ord = 0 end
				ord = ord % 10
				if (ord > 3) then ord = 0 end
				val = SONGMAN:GetSongRank(song) .. THEME:GetString("OrdinalNumbers",sufixes[ord+1])
			end
			s:settext(val)
		end;
		},

	},
	Def.Sprite{ Texture="../ScreenSelectMusic wheel mask",
		InitCommand=function(s) s:xy(-420,1):zwrite(true):z(1):blend("BlendMode_NoEffect") end;
	},
	Def.Sprite{ Texture="left frame",
	OnCommand=function(s) s:xy(-380,1):addx(-150):decelerate(0.5):addx(150) end;
	OffCommand=function(s) s:sleep(0.2):accelerate(0.6):addx( IsUsingWideScreen() and -225 or -150) end,
	CancelMessageCommand=function(s) if GAMESTATE:Env()["WorkoutMode"] then s:sleep(0.2):accelerate(0.6):addx( IsUsingWideScreen() and -225 or -150) end end,
	},
}
