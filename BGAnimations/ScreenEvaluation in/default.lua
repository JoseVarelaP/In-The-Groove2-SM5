local function failed(g)
	if g == "Grade_Failed" then
		return true;
	else
		return false;
	end
end

local img = "cleared"

if (GAMESTATE:IsHumanPlayer(PLAYER_1) and failed(gradeP1) and not GAMESTATE:IsHumanPlayer(PLAYER_2)) then
	img = "failed"
	
-- if (only P2) and (P2 failed)	
elseif (GAMESTATE:IsHumanPlayer(PLAYER_2) and failed(gradeP2) and not GAMESTATE:IsHumanPlayer(PLAYER_1)) then
	img = "failed"

-- if (both P1 and P2) and (both P1 and P2 failed)	
elseif (GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2) and failed(gradeP1) and failed(gradeP2) ) then
	img = "failed"
	
end

local stylepick = ThemePrefs.Get("ITG1") and "ITG1/" or ""
return Def.ActorFrame{
	LoadActor("../_fade in normal"),
	Def.ActorFrame{

		LoadActor( stylepick..img.." text")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-240+340):cropright(1.3):faderight(0.1):sleep(0.25):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffuse(0,0,0,0)
		end;
		},

		LoadActor( stylepick..img.." glow")..{
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-240+340):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(0.25):linear(0.7):cropleft(1):cropright(-0.3)
		end;
		},
	},
}