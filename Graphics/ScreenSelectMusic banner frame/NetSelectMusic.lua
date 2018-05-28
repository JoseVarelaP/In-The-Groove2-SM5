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

		LoadActor("right frame edge")..{
		OnCommand=cmd(x,-200;horizalign,left;zoomx,1);
		},

		LoadActor("right frame middle")..{
		OnCommand=cmd(x,-200+158;horizalign,left;zoomx,40);
		},

		LoadActor("right frame right")..{
		OnCommand=cmd(x,200+78;horizalign,left);
		},

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

			Def.ActorProxy{
				BeginCommand=function(self) local banner = SCREENMAN:GetTopScreen():GetChild('ChatOutput'); self:SetTarget(banner); end,
				InitCommand=cmd(x,-170;y,-85)
			};
		};

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
