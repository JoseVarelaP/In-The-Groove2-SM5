return Def.ActorFrame{

	Def.ActorFrame{
	OnCommand=cmd(fov,58;x,-10;y,2;zoomy,0.985;rotationy,-20;addx,450;decelerate,0.75;addx,-450);
	OffCommand=cmd(accelerate,0.75;addx,450);

  		Def.ActorFrame{
		InitCommand=cmd(x,40;y,-110);

			LoadActor( "../ScreenSelectMusic banner mask" ) .. {
				InitCommand=cmd(zoom,1.1;x,18;y,8;z,1;blend,'BlendMode_NoEffect');
			};
			Def.ActorProxy{
				BeginCommand=function(self) local banner = SCREENMAN:GetTopScreen():GetChild('Banner'); self:SetTarget(banner); end,
				InitCommand=cmd(x,61;y,18;zoom,2.2);
			};

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
	OffCommand=cmd(accelerate,0.75;addx,500);

		Def.BitmapText{
		Text="ARTIST",
		Font="_eurostile normal",
		OnCommand=cmd(shadowlength,2;zoom,0.5;x,-140;y,-38;diffusealpha,0.5);
		},

		Def.BitmapText{
		Text="This will change",
		Font="_eurostile normal",
		OnCommand=cmd(horizalign,left;shadowlength,2;zoom,0.5;x,-155;y,-20;diffusealpha,1);
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
		OnCommand=cmd(horizalign,left;shadowlength,2;zoom,0.5;x,40;y,-18;diffusealpha,1);
		CurrentSongChangedMessageCommand=function(self)
			local songCourse = GAMESTATE:GetCurrentSong()
			local val
			if songCourse then
				local bpms = songCourse:GetDisplayBpms()

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

		Def.BitmapText{
		Text="POP",
		Font="_eurostile normal",
		OnCommand=cmd(shadowlength,2;zoom,0.5;x,150;y,-30;diffusealpha,0.5);
		},

	},

	LoadActor("left frame")..{
	OnCommand=cmd(x,-380;y,1;addx,-150;decelerate,0.5;addx,150);
	OffCommand=cmd(sleep,0.2;accelerate,0.6;addx,-150);
	},
}
-- 		<AutoActor 
-- 			File="left frame"
-- 			OnCommand="x,-380;y,1;addx,-150;decelerate,0.5;addx,150"
-- 			OffCommand="sleep,0.2;accelerate,0.6;addx,-150"
-- 		/>
-- 	</children>
-- </ActorFrame>
