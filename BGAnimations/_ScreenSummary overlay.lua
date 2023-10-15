local StepsType = ...
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end
    local ET = ToEnumShortString(event.type)
    -- Input that occurs at the moment the button is pressed.
    if ET == "FirstPress" then
        if event.GameButton == "Start" or event.GameButton == "Back" then
            SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
        end
    end
end
local t = Def.ActorFrame{
    OnCommand=function(self)
        SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
        -- Go through all text items, and add a shadow.
        self:RunCommandsRecursively(function(actor)
            if actor.settext and actor:GetName() ~= "Help" then
                actor:shadowlength(2)
            end
        end)
    end,
    OffCommand=function(self)
        SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler)
    end
}

local function GetActual(stepsType)
    return PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,"Difficulty_Easy")+
        PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,"Difficulty_Medium")+
        PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,"Difficulty_Hard")+
        PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,"Difficulty_Challenge")+
        PROFILEMAN:GetMachineProfile():GetCoursesActual(stepsType,"Difficulty_Medium")+
        PROFILEMAN:GetMachineProfile():GetCoursesActual(stepsType,"Difficulty_Hard")
end

local function GetPossible( stepsType )
	return 
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,"Difficulty_Easy")+
        PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,"Difficulty_Medium")+
        PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,"Difficulty_Hard")+
        PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,"Difficulty_Challenge")+
        PROFILEMAN:GetMachineProfile():GetCoursesPossible(stepsType,"Difficulty_Medium")+
        PROFILEMAN:GetMachineProfile():GetCoursesPossible(stepsType,"Difficulty_Hard")
end

local function GetTotalPercentComplete( stepsType )
	return GetActual(stepsType) / (0.96*GetPossible(stepsType))
end

local function GetSongsPercentComplete( stepsType, difficulty )
	return PROFILEMAN:GetMachineProfile():GetSongsPercentComplete(stepsType,difficulty)/0.96
end

local function GetCoursesPercentComplete( stepsType, difficulty )
	return PROFILEMAN:GetMachineProfile():GetCoursesPercentComplete(stepsType,difficulty)/0.96
end

-- Set position columns for Actual, Possible and star complete.
local PositionColumns = {
    SCREEN_CENTER_X - 100,
    SCREEN_CENTER_X + 60,
    SCREEN_CENTER_X + 240
}

local diffs = {
    "Difficulty_Easy",
    "Difficulty_Medium",
    "Difficulty_Hard",
    "Difficulty_Challenge",
}

local trails = {
    "Difficulty_Medium",
    "Difficulty_Hard"
}

local function xScaleItem(indx)
    return scale( indx, 1, numGrades, SCREEN_LEFT + 180, SCREEN_RIGHT - 60 )
end

-- Draw the diff labels.
local isITG1 = ThemePrefs.Get("ITG1")
local diffIconGraphic = isITG1 and THEME:GetPathG('_evaluation difficulty','icons') or THEME:GetPathG('_difficulty','icons');
local labelX = SCREEN_CENTER_X - 240
for difIndx,diff in ipairs(diffs) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self)
            self:xy( labelX , SCREEN_CENTER_Y - 144 + (30 * difIndx) )
        end,
        OnCommand=function(self)
            self:diffusealpha(0):linear(0.1):diffusealpha(1)
        end,
        OffCommand=function(self)
            self:sleep(0.05):linear(0.15):diffusealpha(0)
        end,
        Def.BitmapText{
            Condition=not isITG1,
            Font="Common Normal",
            Text=THEME:GetString("Difficulty", ToEnumShortString(diff)),
            OnCommand=function(self)
                self:zoom(0.6)
            end
        },
        Def.Sprite{
            Texture=diffIconGraphic,
            OnCommand=function(self)
                self:animate(0):setstate( difIndx )
            end
        },
        Def.BitmapText{
            Condition=isITG1,
            Font="Common Normal",
            Text=THEME:GetString("Difficulty", ToEnumShortString(diff)),
            OnCommand=function(self)
                self:diffuse(Color.Black):shadowlength(1):zoom(0.5)
            end
        }
    }

    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=("%5.2f"):format(PROFILEMAN:GetMachineProfile():GetSongsActual(StepsType,diff)),
        InitCommand=function(self)
            self:xy( PositionColumns[1] + 30, SCREEN_CENTER_Y - 146 + (30 * difIndx) ):zoom(0.6):halign(1)
        end
    }

    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=("%5.2f"):format(PROFILEMAN:GetMachineProfile():GetSongsPossible(StepsType,diff)),
        InitCommand=function(self)
            self:xy( PositionColumns[2] + 30, SCREEN_CENTER_Y - 146 + (30 * difIndx) ):zoom(0.6):halign(1)
        end
    }

    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=FormatPercentScore(GetSongsPercentComplete(StepsType,diff)),
        InitCommand=function(self)
            self:xy( PositionColumns[3] + 30, SCREEN_CENTER_Y - 146 + (30 * difIndx) ):zoom(0.6):halign(1)
        end
    }
end
for difIndx,diff in ipairs(trails) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self)
            self:xy( labelX , SCREEN_CENTER_Y - 22 + (30 * difIndx) )
        end,
        OnCommand=function(self)
            self:diffusealpha(0):linear(0.1):diffusealpha(1)
        end,
        OffCommand=function(self)
            self:sleep(0.05):linear(0.15):diffusealpha(0)
        end,
        Def.BitmapText{
            Condition=not isITG1,
            Font="Common Normal",
            Text=THEME:GetString("Difficulty", ToEnumShortString(diff)),
            OnCommand=function(self)
                self:zoom(0.6)
            end
        },
        Def.Sprite{
            Texture=diffIconGraphic,
            OnCommand=function(self)
                self:animate(0):setstate( difIndx )
            end
        },
        Def.BitmapText{
            Condition=isITG1,
            Font="Common Normal",
            Text=THEME:GetString("Difficulty", ToEnumShortString(diff)),
            OnCommand=function(self)
                self:diffuse(Color.Black):shadowlength(1):zoom(0.5)
            end
        }
    }

    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=("%5.2f"):format(PROFILEMAN:GetMachineProfile():GetCoursesActual(StepsType,diff)),
        InitCommand=function(self)
            self:xy( PositionColumns[1] + 30,SCREEN_CENTER_Y - 22 + (30 * difIndx) ):zoom(0.6):halign(1)
        end
    }

    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=("%5.2f"):format(PROFILEMAN:GetMachineProfile():GetCoursesPossible(StepsType,diff)),
        InitCommand=function(self)
            self:xy( PositionColumns[2] + 30,SCREEN_CENTER_Y - 22 + (30 * difIndx) ):zoom(0.6):halign(1)
        end
    }

    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=FormatPercentScore(GetCoursesPercentComplete(StepsType,diff)),
        InitCommand=function(self)
            self:xy( PositionColumns[3] + 30,SCREEN_CENTER_Y - 22 + (30 * difIndx) ):zoom(0.6):halign(1)
        end
    }
end

-- Add static items
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    Text=Screen.String("TotalActual"),
    InitCommand=function(self)
        self:xy( labelX - 50 , SCREEN_CENTER_Y + 70 ):halign(0):zoom(0.6)
    end
}
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    Text=Screen.String("TotalPossible"),
    InitCommand=function(self)
        self:xy( labelX - 50 , SCREEN_CENTER_Y + 90 ):halign(0):zoom(0.6)
    end
}
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    Text=Screen.String("StarComplete"),
    InitCommand=function(self)
        self:xy( labelX - 50 , SCREEN_CENTER_Y + 115 ):halign(0):zoom(0.8)
    end
}

-- Value items for the static items.
t[#t+1] = Def.BitmapText{
    Font="_futurist metalic",
    Text=("%.2f"):format(GetActual(StepsType)),
    InitCommand=function(self)
        self:xy( PositionColumns[3] - 100 , SCREEN_CENTER_Y + 70 ):halign(1):zoom(0.6)
    end
}

t[#t+1] = Def.BitmapText{
    Font="_futurist metalic",
    Text=("%.2f"):format(GetPossible(StepsType)),
    InitCommand=function(self)
        self:xy( PositionColumns[3] - 100 , SCREEN_CENTER_Y + 90 ):halign(1):zoom(0.6)
    end
}

t[#t+1] = Def.BitmapText{
    Font="_futurist metalic",
    Text=FormatPercentScore(GetTotalPercentComplete(StepsType)),
    InitCommand=function(self)
        self:xy( PositionColumns[3] - 72 , SCREEN_CENTER_Y + 115 ):halign(1):zoom(0.9)
    end
}

-- Header items
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    Text=Screen.String("Actual"),
    InitCommand=function(self)
        self:xy( PositionColumns[1] , SCREEN_CENTER_Y - 150 ):zoom(0.6)
    end
}
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    Text=Screen.String("Possible"),
    InitCommand=function(self)
        self:xy( PositionColumns[2] , SCREEN_CENTER_Y - 150 ):zoom(0.6)
    end
}
t[#t+1] = Def.BitmapText{
    Font="Common Normal",
    Text=Screen.String("StarComplete"),
    InitCommand=function(self)
        self:xy( PositionColumns[3] , SCREEN_CENTER_Y - 150 ):zoom(0.6)
    end
}

t[#t+1] = Def.HelpDisplay {
    File="_eurostile normal",
    Name="Help",
    OnCommand=function(self)
        self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+203):zoom(0.7):diffuseblink():maxwidth(SCREEN_WIDTH/0.8)
    end,
    InitCommand=function(self)
        self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
        self:SetTipsColonSeparated( THEME:GetString("ScreenSummary","HelpText") )
    end,
    OffCommand=function(self)
        self:linear(0.5):zoomy(0)
    end
}

t[#t+1] = LoadActor( THEME:GetPathG('', ('_grade models/%s.lua'):format(GetGradeFromPercent(GetTotalPercentComplete(StepsType))) ) ) .. {
    InitCommand=function(self)
        self:xy( PositionColumns[3], SCREEN_CENTER_Y + 90 )
    end
}
return t