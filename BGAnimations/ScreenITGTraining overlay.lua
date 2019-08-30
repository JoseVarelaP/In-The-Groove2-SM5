local function BasicFadeInandOut(s,xpos,ypos)
	s:xy(xpos,ypos):shadowlength(4):diffusealpha(0):sleep(1):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0)
	return s
end

local dialogs = {
	{0, function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-112):diffusealpha(0):linear(0.3):diffusealpha(1):sleep(6):linear(0.3):diffusealpha(0) end,
	"ScreenStage","Welcome to the tutorial program", "HideGameplayFrame"},
	{0, function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+120):diffusealpha(0):sleep(4):linear(0.3):diffusealpha(1):sleep(2):linear(0.3):diffusealpha(0) end,
	"ScreenGameplayTraining","Welcome", nil},
	{15, function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-70):shadowlength(4):diffusealpha(0):sleep(1):queuemessage("ShowFloor"):linear(0.3):diffusealpha(1):
		sleep(4):queuemessage("HideFloor"):linear(0.3):diffusealpha(0) end,
	"ScreenGameplayTraining","HowToPlay1", nil},
	{24, function(s) BasicFadeInandOut(s,SCREEN_CENTER_X,SCREEN_CENTER_Y-30) end, "ScreenGameplayTraining","HowToPlay2", "ShowPointers"},
	{28, function(s) BasicFadeInandOut(s,SCREEN_CENTER_X,SCREEN_CENTER_Y-30) end, "ScreenGameplayTraining","HowToPlay3", nil},
	{28, function(s) BasicFadeInandOut(s,SCREEN_CENTER_X,SCREEN_CENTER_Y+80) end, "ScreenGameplayTraining","HowToPlay4", nil},
	{41, function(s) BasicFadeInandOut(s,SCREEN_CENTER_X,SCREEN_CENTER_Y+110) end, "ScreenGameplayTraining","NotesIntro", nil},
	{50, function(s) BasicFadeInandOut(s,SCREEN_CENTER_X,SCREEN_CENTER_Y+110) end, "ScreenGameplayTraining","NotesDemo1", nil},
	--[[
	{"ScreenGameplayTraining","GoodbyeGoodLuck"},
	{"ScreenGameplayTraining","HowToPlay2"},
	{"ScreenGameplayTraining","HowToPlay3"},
	{"ScreenGameplayTraining","HowToPlay4"},
	{"ScreenGameplayTraining","Jumps1"},
	{"ScreenGameplayTraining","Jumps2"},
	{"ScreenGameplayTraining","Meters1"},
	{"ScreenGameplayTraining","Meters2"},
	{"ScreenGameplayTraining","MoveFaster1"},
	{"ScreenGameplayTraining","MoveFaster2"},
	{"ScreenGameplayTraining","MoveFaster3"},
	{"ScreenGameplayTraining","NotesIntro"},
	{"ScreenGameplayTraining","WrapUp1"},
	{"ScreenGameplayTraining","WrapUp2"},
	{"ScreenGameplayTraining","Flashes1"},
	{"ScreenGameplayTraining","Flashes2"},
	{"ScreenGameplayTraining","Go"},
	{"ScreenGameplayTraining","Go1"},
	{"ScreenGameplayTraining","Go2"},
	{"ScreenGameplayTraining","Go3"},
	{"ScreenGameplayTraining","Go4"},
	{"ScreenGameplayTraining","Go5"},
	{"ScreenGameplayTraining","Go6"},
	{"ScreenGameplayTraining","LifeMeter1"},
	{"ScreenGameplayTraining","LifeMeter2"},
	{"ScreenGameplayTraining","LifeMeter3"},
	{"ScreenGameplayTraining","LifeMeter4"},
	{"ScreenGameplayTraining","LifeMeter5"},
	{"ScreenGameplayTraining","LifeMeter6"},
	{"ScreenGameplayTraining","NotesDemo1"},
	{"ScreenGameplayTraining","Now"},
	{"ScreenGameplayTraining","PickSongs"},
	{"ScreenGameplayTraining","SongBar1"},
	{"ScreenGameplayTraining","SongBar2"},
	{"ScreenGameplayTraining","TryIt1a"},
	{"ScreenGameplayTraining","TryIt1b"},
	{"ScreenGameplayTraining","TryIt1c"},
	{"ScreenGameplayTraining","TryIt2"},
	{"ScreenGameplayTraining","TryIt3a"},
	{"ScreenGameplayTraining","TryIt3b"},
	{"ScreenGameplayTraining","Final"},
	{"ScreenGameplayTraining","FinalIntro"},
	{"ScreenGameplayTraining","Welcome"},
	]]
}

local beat,last_beat = 0,0
local function UpdateRate()
	beat = GAMESTATE:GetSongBeat()
	SCREENMAN:SystemMessage("Current Beat: ".. beat)
	for i,m in ipairs(dialogs) do
		if (beat >= m[1] and last_beat < m[1]) then
			MESSAGEMAN:Broadcast("StartAction",{ Actor=i })
		elseif (beat < m[1]) then
			break
		end
	end
	last_beat = beat
	return s;
end

local t = Def.ActorFrame{
	OnCommand=function(s)
		s:SetUpdateFunction( UpdateRate )
	end;
};

t[#t+1] = LoadActor("ScreenGameplay overlay");

for i,v in ipairs(dialogs) do
	t[#t+1] = Def.BitmapText{
		Name="Text"..i,
		Font="_big blue glow",
		Text=THEME:GetString(v[3],v[4]),
		OnCommand=function(s)
			s:visible(false):zoom( 0.9 ):wrapwidthpixels( SCREEN_WIDTH/1.02 )
		end;
		StartActionMessageCommand=function(s,param)
			if param.Actor == i then
				s:visible(true)
				if v[2] then v[2](s) end
				if v[5] then MESSAGEMAN:Broadcast(v[5]) end
			end
		end;
	}
end

return t;