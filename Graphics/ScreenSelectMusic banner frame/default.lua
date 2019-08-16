return Def.ActorFrame{

	Def.ActorFrame{
	OnCommand=function(self)
		self:fov(58):x(-10):y(2):zoomy(0.985):rotationy(-20):addx(450):decelerate(0.75):addx(-450)
	end;
	OffCommand=function(self)
	self:accelerate(0.75);
	if IsUsingWideScreen() then
		self:addx(500);
	else
		self:addx(450);
	end
	end,

  		Def.ActorFrame{
		InitCommand=function(self)
			self:x(40):y(-110)
		end;

			LoadActor( "../ScreenSelectMusic banner mask" ) .. {
				InitCommand=function(self)
					self:zoom(1.12):x(17):y(8):zwrite(true):z(1):blend("BlendMode_NoEffect")
				end;
			};
			LoadActor( "../ScreenSelectMusic banner mask" ) .. {
				InitCommand=function(self)
					self:zoom(1.12):zoomx(-1.12):x(187):y(8):zwrite(true):z(1):blend("BlendMode_NoEffect")
				end;
			};
			Def.ActorProxy{
				BeginCommand=function(self) local banner = SCREENMAN:GetTopScreen():GetChild('Banner'); self:SetTarget(banner); end,
				InitCommand=function(self)
				if IsUsingWideScreen() then
					self:x(61):y(-3):setsize(418,164):zoomx(2.2):zoomy(1.6)
				else
					self:x(10):y(-3):setsize(418,164):zoomx(1.8):zoomy(1.6)
				end
				end;
			};

			LoadActor( THEME:GetPathG('ScreenSelectMusic','StepsDisplayList') )..{
				OnCommand=function(self)
					self:y(126):zoomx(1):zoomy(0.94)
				end
			},

			LoadActor( THEME:GetPathG('ScreenSelectMusic','CourseDisplayList') )..{
				OnCommand=function(self)
					self:y(126):zoomx(1):zoomy(0.94)
				end
			},

		Def.ActorFrame{
		Condition=ThemePrefs.Get("MarathonLabel")	== "ITG";
			-- Long/Marathon labels - ITG style
			Def.BitmapText{
			Text=THEME:GetString("Balloons","ITGLong"),
			Font="_big blue glow",
			OnCommand=function(self)
				self:shadowlength(2):zoom(1):x(05):y(200):diffuseshift():playcommand("Hide")
			end;
			HideCommand=function(self)
				self:diffusealpha(0)
			end;
			ShowLongCommand=function(self) self:diffusealpha(1):settext( THEME:GetString("Balloons","ITGLong") ); end,
			ShowMarathonCommand=function(self) self:diffusealpha(1):settext( THEME:GetString("Balloons","ITGMarathon") ); end,
			CurrentSongChangedMessageCommand=function(self)
			self:queuecommand("Hide")
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():IsLong() then self:queuecommand("ShowLong") end
				if GAMESTATE:GetCurrentSong():IsMarathon() then self:queuecommand("ShowMara") end
			end
			end,
			},

		},


		Def.ActorFrame{
		Condition=ThemePrefs.Get("MarathonLabel")	== "OITG";
			-- Long/Marathon labels - OITG style

			LoadActor( "OITG Balloon" )..{
			HideCommand=function(self)
				self:diffusealpha(0)
			end;
			LongCommand=function(self)
				self:diffusealpha(1):diffuseshift():effectcolor1(0.8,0.8,0.8,1):effectcolor2(0.5,0.5,0.5,1)
			end;
			MaraCommand=function(self)
				self:diffusealpha(1):diffuseshift():effectcolor1(1,0.3,0.3,1):effectcolor2(0.7,0.1,0.1,1)
			end;
			OnCommand=function(self)
				self:shadowlength(2):zoom(1):zoomx(1.3):x(-200):horizalign(left):y(45):effectclock("bgm"):diffuseshift():effectcolor1(1,1,1,1):effectcolor2(0.7,0.7,0.7,1):playcommand("Hide")
			end;
			CurrentSongChangedMessageCommand=function(self)
			self:queuecommand("Hide")
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():IsLong() then self:queuecommand("Long") end
				if GAMESTATE:GetCurrentSong():IsMarathon() then self:queuecommand("Mara") end
			end
			end,

			},

			Def.BitmapText{
			Text=THEME:GetString("Balloons","OITGLong"),
			Font="_eurostile normal",
			OnCommand=function(self)
				self:shadowlength(1):zoom(0.5):zoomx(0.55):x(-180):horizalign(left):y(45):playcommand("Hide")
			end;
			HideCommand=function(self)
				self:diffusealpha(0)
			end;
			ShowLongCommand=function(self) self:diffusealpha(1):settext( THEME:GetString("Balloons","OITGLong") ); end,
			ShowMarathonCommand=function(self) self:diffusealpha(1):settext( THEME:GetString("Balloons","OITGMarathon") ); end,
			CurrentSongChangedMessageCommand=function(self)
			self:queuecommand("Hide")
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():IsLong() then self:queuecommand("ShowLong") end
				if GAMESTATE:GetCurrentSong():IsMarathon() then self:queuecommand("ShowMarathon") end
			end
			end,
			},

			Def.BitmapText{ Text="MODS", Font="_eurostile normal",
			OnCommand=function(s)
				s:shadowlength(2):zoom(1.3):xy(-130,35):diffuseshift():effectcolor1(color("0.4,0.4,0.4,1")):visible(false)
				s:visible( (GAMESTATE:GetCurrentCourse() and GAMESTATE:GetCurrentCourse():HasMods()) and true or false )
			end;
			CurrentCourseChangedMessageCommand=function(s)
				s:visible( (GAMESTATE:GetCurrentCourse() and GAMESTATE:GetCurrentCourse():HasMods()) and true or false )
			end;
			},

		},

		};

		LoadActor("right frame edge")..{
		OnCommand=function(self)
			self:x(-200):horizalign(left):zoomx(1)
		end;
		},

		LoadActor("right frame middle")..{
		OnCommand=function(self)
			self:x(-200+158):horizalign(left):zoomx(40)
		end;
		},

		LoadActor("right frame right")..{
		OnCommand=function(self)
			self:x(200+78):horizalign(left)
		end;
		},
	},

	Def.ActorFrame{
	OnCommand=function(self)
		self:y(1):addx(500):decelerate(0.75):addx(-500)
	end;
	OffCommand=function(self)
	self:accelerate(0.75);
	if IsUsingWideScreen() then
		-- FIVE FIVE FIVE GUYS
		self:addx(555);
	else
		self:addx(450);
	end
	end,

		Def.BitmapText{
		Text=string.upper(THEME:GetString("BannerFrame","Artist"));
		Font="_eurostile normal",
		OnCommand=function(self)
			self:horizalign(left):shadowlength(2):zoom(0.5):x(-165):y(-38):diffusealpha(0.5)
		end;
		},

		Def.BitmapText{
		Text="This will change",
		Font="_eurostile normal",
		OnCommand=function(self)
			self:horizalign(left):shadowlength(2):zoom(0.6):x(-165):y(-22):diffusealpha(1)
		end;
		CurrentSongChangedMessageCommand=function(self)
		self:settext("")
		if GAMESTATE:GetCurrentSong() then
			self:settext( GAMESTATE:GetCurrentSong():GetDisplayArtist() )			
		end
		end,
		},

		Def.HelpDisplay {
			File="_eurostile normal",
			OnCommand=function(self)
				self:horizalign(left):shadowlength(2):zoom(0.6):x(-165):y(-22):diffusealpha(1)
				self:SetSecsBetweenSwitches(1.5)
			end;
			OffCommand=function(self)
				self:linear(0.5):zoomy(0)
			end;
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
		OnCommand=function(self)
			self:shadowlength(2):zoom(0.5):x(55):y(-32):diffusealpha(0.5)
		end;
		},

		Def.BitmapText{
		Text="This will change",
		Font="_eurostile normal",
		OnCommand=function(self)
			self:horizalign(left):shadowlength(2):zoom(0.6):x(40):y(-18):diffusealpha(1)
		end;
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local val
			if song then
				local bpms = song:GetDisplayBpms()

				if bpms[1] == bpms[2] then
					val = string.format("%i",bpms[1])
				else
					val = string.format("%i-%i",bpms[1],bpms[2])
				end
			else
				val = " "
			end
			self:settext(val)
		end;
		CurrentCourseChangedMessageCommand=function(self)
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
				self:settext(val == "0" and "???" or val)
			end
		end;
		},

		-- need to figure out how to get pop

		Def.BitmapText{ Text="POP", Font="_eurostile normal",
		OnCommand=function(s)
			s:shadowlength(2):zoom(0.5):xy(150,-30):diffusealpha(0.5)
		end;
		},

		Def.BitmapText{ Text="POP", Font="_eurostile normal",
		OnCommand=function(s)
			s:shadowlength(2):zoom(0.6):xy(138,-16):diffusealpha(1):halign(0)
		end;
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local val
			if song then
				val = SONGMAN:GetSongRank(song)
			else
				val = " "
			end
			self:settext(val)
		end;
		},

	},
	LoadActor( "../ScreenSelectMusic wheel mask" ) .. {
				InitCommand=function(self)
					self:x(-420):y(1):zwrite(true):z(1):blend("BlendMode_NoEffect")
				end;
			},
	LoadActor("left frame")..{
	OnCommand=function(self)
		self:x(-380):y(1):addx(-150):decelerate(0.5):addx(150)
	end;
	OffCommand=function(self)
	self:sleep(0.2);
	self:accelerate(0.6);
	if IsUsingWideScreen() then
		self:addx(-225);
	else
		self:addx(-150);
	end
	end,
	},
}
