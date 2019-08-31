local t = Def.ActorFrame{}

local bnhelp = Def.ActorFrame{}

bnhelp[#bnhelp+1] = Def.ActorFrame{
	Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()=="Difficulty_Beginner" or GAMESTATE:IsHumanPlayer(PLAYER_2) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()=="Difficulty_Beginner";
	InitCommand=function(s) s:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y-30) end;
	Def.ActorFrame{
		Def.Sprite{ Texture=ThemePrefs.Get("ITG1") and "light_frame1" or "light_frame2" };
		Def.ActorFrame{
			Def.Sprite{
				Texture="light_green",
				InitCommand=function(s)
					s:y(-96):diffusealpha(0):rotationz(0):blend(Blend.Add)
				end;
				NoteCrossedMessageCommand=function(s)
					s:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):diffusealpha(0)
				end;
			};
		};
	};
};

local Inputs = {"Left","Down","Up","Right","Jump"}
local lights = { {1200,96,"red"},{800,32,"yellow"},{400,-32,"yellow"} }

for av,inp in ipairs(lights) do
	local ypos = SCREEN_CENTER_Y-30+inp[2]
	bnhelp[#bnhelp+1] = Def.ActorFrame{
		InitCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-30) end;
		Def.Sprite{
			Texture="light_"..inp[3],
			InitCommand=function(s) s:diffusealpha(0):y(inp[2]):rotationz( 45*av ):blend(Blend.Add) end;
			["NoteWillCrossIn"..inp[1].."MsMessageCommand"]=function(s)
				s:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(.8):diffusealpha(0)
			end;
		};
		Def.Sprite{
			Texture="light_dot",
			InitCommand=function(s) s:diffusealpha(0) end;
			["NoteWillCrossIn"..inp[1].."MsMessageCommand"]=function(s)
				s:finishtweening():y(inp[2]):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0)
			end;
		};
	}
end

for av,inp in ipairs(Inputs) do
	bnhelp[#bnhelp+1] = Def.BitmapText{
		Font="_eurostile outline",
		Text=THEME:GetString("ScreenGameplay",inp);
		InitCommand=function(s)
			s:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y-30-96):diffusealpha(0):maxwidth(70)
		end;
		NoteCrossedJumpMessageCommand=function(s)
			if av == 5 then
				s:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
			else
				s:finishtweening():diffusealpha(0)
			end
		end;
		NoteCrossedMessageCommand=function(s,param) if param.ButtonName == inp then s:playcommand("Cross") end end;
		CrossCommand=function(s)
			s:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0)
		end;
	};
end

t[#t+1] = bnhelp
for player in ivalues(PlayerNumber) do
	local panel = Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(player) and GAMESTATE:GetPlayMode()=="PlayMode_Regular" and GAMESTATE:GetCurrentSteps(player):GetDifficulty()=="Difficulty_Beginner";
		OnCommand=function(s)
			local spacing = player == PLAYER_1 and SCREEN_CENTER_X-WideScale(160,210) or SCREEN_CENTER_X+WideScale(160,210)
			s:x(spacing):y(SCREEN_CENTER_Y+40):zoom(1.2):rotationx(-20):fov(45):vanishpoint( spacing, SCREEN_CENTER_Y+40 )
		end;
	};

	panel[#panel+1]=Def.Sprite{Texture="platform",OnCommand=function(s)s:y(7):diffuse(0.6,0.6,0.6,0.8)end};

	local glows = {{-45,0,"Left"},{45,0,"Right"},{0,-45,"Up"},{0,45,"Down"}}

	for v in ivalues(glows) do
		panel[#panel+1] = Def.Sprite{ Texture="panelglow",
		OnCommand=function(s) s:xy(v[1],v[2]):blend("BlendMode_Add"):diffusealpha(0) end;
		CrossCommand=function(s) s:finishtweening():diffusealpha(1):zoom(1.1):linear(0.3):zoom(1):diffusealpha(0) end;
		NoteCrossedMessageCommand=function(s,param) if param.ButtonName == v[3] then s:playcommand("Cross"); end end;
		};
	end

	t[#t+1] = panel
end

-- Additional scripts
t[#t+1] = LoadActor("dangeractor");
t[#t+1] = LoadActor("dead");

return t;