
-- fuck it i'll make my own grade tier system
local GradePercentages = {
	-- quad star
	1.00,
	-- triple star
	0.99,
	-- double star
	0.98,
	-- single star
	0.96,
	-- S+
	0.94,
	-- S
	0.92,
	-- S-
	0.89,
	-- A+
	0.86,
	-- A
	0.83,
	-- A-
	0.80,
	-- B+
	0.76,
	-- B
	0.72,
	-- B-
	0.68,
	-- C+
	0.64,
	-- C
	0.60,
	-- C-
	0.55,
};

PlayerTier = {
	["PlayerNumber_P1"] = "Grade_Tier17",
	["PlayerNumber_P2"] = "Grade_Tier17",
};

for player in ivalues(PlayerNumber) do
	local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	for index, Perc in ipairs(GradePercentages) do
		-- If the player fails, give them a big F.
		if PSS:GetFailed( player ) then
			PlayerTier[player] = "Grade_Failed"
			break
		end
		if (CalPerNum( player ) >= Perc) then
			PlayerTier[player] = "Grade_Tier"..index
			break
		end
	end
end

local t = Def.ActorFrame{};

local function side(pn)
	local s = 1
	if pn == PLAYER_1 then return s end
	return s*(-1)
end

local function Gradeside(pn)
	local s = -230
	if pn == PLAYER_2 then s = 56 end
	return s
end

local function pnum(pn)
	if pn == PLAYER_2 then return 2 end
	return 1
end

-- Grade and Frame Info
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame{
	Condition=GAMESTATE:IsPlayerEnabled(player);
		LoadActor( THEME:GetPathG("","ScreenEvaluation grade frame"), player )..{
		InitCommand=function(self)
		self:xy(SCREEN_CENTER_X+(-145*side(player)),SCREEN_CENTER_Y+54)
		end,
		OnCommand=function(self)
			self:addx( (-SCREEN_WIDTH/2)*side(player) )
			:sleep(3):decelerate(0.3)
			:addx( (SCREEN_WIDTH/2)*side(player) )
		end;
		OffCommand=function(self)
			self:accelerate(0.3):addx( (-SCREEN_WIDTH/2)*side(player) )
		end;
		};
	};

	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(player);
		BeginCommand=function(self)
			self:xy(SCREEN_CENTER_X+(-145*side(player)),SCREEN_CENTER_Y-60)
			:zoom(2):addx( (-SCREEN_WIDTH)*side(player) ):decelerate(0.5)
			:addx( SCREEN_WIDTH*side(player) ):sleep(2.2):decelerate(0.5):zoom(0.9)
			self:xy(SCREEN_CENTER_X+Gradeside(player),SCREEN_CENTER_Y-38);
		end;
		OffCommand=cmd(accelerate,0.3;addx,-SCREEN_WIDTH/2*side(player));
			LoadActor( THEME:GetPathG("", "_grade models/"..PlayerTier[player] ) );
		};
end

t[#t+1] = Def.ActorFrame{
	-- The biggest challenge here was to compesate the positions because of SM5's TextureFiltering.
	-- It is different from 3.95/OpenITG's filters, which differ a lot with the original positions.
	-- IN ADDITION of the different x and y handling anyways.
	-- 																			Jose_Varela

	Def.ActorFrame{
		OnCommand=cmd(xy,SCREEN_LEFT+35,SCREEN_TOP+38);

		Def.BitmapText{
		Font="_eurostile blue glow",
		Text=string.upper(THEME:GetString("ScreenEvaluation","HeaderText")),
			InitCommand=function(self) self:shadowlength(4); self:x(self:GetWidth()/2) self:skewx(-0.16) end,
			OnCommand=cmd(zoomx,0;zoomy,6;sleep,0.3;bounceend,0.3;zoom,1);
			OffCommand=cmd(accelerate,0.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

		LoadActor( THEME:GetPathG("ScreenWithMenuElements Items/stage",""..ToEnumShortString(GAMESTATE:GetCurrentStage() ) ) )..{
		OnCommand=cmd(x,30;y,34;addx,-SCREEN_WIDTH;sleep,3;decelerate,0.3;addx,SCREEN_WIDTH);
		OffCommand=cmd(accelerate,.2;zoomx,2;zoomy,0;diffusealpha,0);
		},

	},

	-- Banner frame


	LoadActor( THEME:GetPathG("Evaluation","banner frame mask") )..{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
	OnCommand=cmd(zwrite,1;z,1;blend,"BlendMode_NoEffect";y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-125;zoom,1.02);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},

	Def.Banner{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126)
	if GAMESTATE:IsCourseMode() then
		self:LoadFromCourse( GAMESTATE:GetCurrentCourse() )
	else
		self:LoadFromSong( GAMESTATE:GetCurrentSong() )
	end
	end,
	OnCommand=cmd(setsize,418/2,164/2;ztest,1;y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-124);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},

	LoadActor( THEME:GetPathG("","ScreenEvaluation banner frame") )..{
	InitCommand=function(self) self:xy(SCREEN_CENTER_X-1,SCREEN_CENTER_Y-126) end,
	OnCommand=cmd(y,SCREEN_TOP-100;sleep,3;decelerate,0.3;y,SCREEN_CENTER_Y-124);
	OffCommand=cmd(accelerate,0.3;addy,-SCREEN_CENTER_X);
	},
}

return t;