return Def.ActorFrame{

	Def.ActorFrame{
	OnCommand=cmd(fov,58;x,-10;y,2;zoomy,0.985;rotationy,-20;addx,450;decelerate,0.75;addx,-450);
	OffCommand=function(self)
	self:accelerate(0.75);
	if IsUsingWideScreen() then
		self:addx(500);
	else
		self:addx(450);
	end
	end,

  		Def.ActorFrame{
		InitCommand=cmd(x,40;y,-110);

			LoadActor( "../ScreenSelectMusic banner mask" ) .. {
				InitCommand=cmd(zoom,1.12;x,17;y,8;zwrite,true;z,1;blend,"BlendMode_NoEffect");
			};
			LoadActor( "../ScreenSelectMusic banner mask" ) .. {
				InitCommand=cmd(zoom,1.12;zoomx,-1.12;x,187;y,8;zwrite,true;z,1;blend,"BlendMode_NoEffect");
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
			OnCommand=cmd(y,126;zoomx,1;zoomy,0.94;)
		},

		Def.ActorFrame{
		Condition=ThemePrefs.Get("MarathonLabel")	== "ITG";
			-- Long/Marathon labels - ITG style
			Def.BitmapText{
			Text=THEME:GetString("Balloons","ITGLong"),
			Font="_big blue glow",
			OnCommand=cmd(shadowlength,2;zoom,1;x,05;y,200;diffuseshift;playcommand,"Hide");
			HideCommand=cmd(diffusealpha,0);
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
			HideCommand=cmd(diffusealpha,0);
			LongCommand=cmd(diffusealpha,1;diffuseshift;effectcolor1,0.8,0.8,0.8,1;effectcolor2,0.5,0.5,0.5,1;);
			MaraCommand=cmd(diffusealpha,1;diffuseshift;effectcolor1,1,0.3,0.3,1;effectcolor2,0.7,0.1,0.1,1;);
			OnCommand=cmd(shadowlength,2;zoom,1;zoomx,1.3;x,-200;horizalign,left;y,45;effectclock,"bgm";diffuseshift;effectcolor1,1,1,1,1;effectcolor2,0.7,0.7,0.7,1;playcommand,"Hide");
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
			OnCommand=cmd(shadowlength,1;zoom,0.5;zoomx,0.55;x,-180;horizalign,left;y,45;playcommand,"Hide");
			HideCommand=cmd(diffusealpha,0);
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

		},

		};

		LoadActor("right frame edge")..{
		OnCommand=cmd(x,-200;horizalign,left;zoomx,1);
		},

		LoadActor("right frame middle")..{
		OnCommand=cmd(x,-200+158;horizalign,left;zoomx,40);
		},

		LoadActor("right frame right")..{
		OnCommand=cmd(x,200+78;horizalign,left);
		},
	},

	Def.ActorFrame{
	OnCommand=cmd(y,1;addx,500;decelerate,0.75;addx,-500);
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
		OnCommand=cmd(horizalign,left;shadowlength,2;zoom,0.5;x,-165;y,-38;diffusealpha,0.5);
		},

		Def.BitmapText{
		Text="This will change",
		Font="_eurostile normal",
		OnCommand=cmd(horizalign,left;shadowlength,2;zoom,0.6;x,-165;y,-22;diffusealpha,1);
		CurrentSongChangedMessageCommand=function(self)
		local songCourse = GAMESTATE:GetCurrentSong()
		if songCourse then
			self:settext(GAMESTATE:GetCurrentSong():GetDisplayArtist())
		else
			self:settext("")
		end
		end,
		},

		Def.BitmapText{
		Text="BPM",
		Font="_eurostile normal",
		OnCommand=cmd(shadowlength,2;zoom,0.5;x,55;y,-32;diffusealpha,0.5);
		},

		Def.BitmapText{
		Text="This will change",
		Font="_eurostile normal",
		OnCommand=cmd(horizalign,left;shadowlength,2;zoom,0.6;x,40;y,-18;diffusealpha,1);
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
		},

		-- need to figure out how to get pop

		-- Def.BitmapText{
		-- Text="POP",
		-- Font="_eurostile normal",
		-- OnCommand=cmd(shadowlength,2;zoom,0.5;x,150;y,-30;diffusealpha,0.5);
		-- },

	},
	LoadActor( "../ScreenSelectMusic wheel mask" ) .. {
				InitCommand=cmd(x,-420;y,1;zwrite,true;z,1;blend,"BlendMode_NoEffect");
			},
	LoadActor("left frame")..{
	OnCommand=cmd(x,-380;y,1;addx,-150;decelerate,0.5;addx,150);
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
