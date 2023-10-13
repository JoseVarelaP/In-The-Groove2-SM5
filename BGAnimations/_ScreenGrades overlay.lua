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
    end,
    OffCommand=function(self)
        SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler)
    end
}

local numGrades = 10

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

-- Draw grade medals.
for i = 1,numGrades do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self)
            self:xy( xScaleItem(i), SCREEN_CENTER_Y - 150 ):zoom(0.4)
        end,
        OnCommand=function(self)
            self:diffusealpha(0):linear(0.1):diffusealpha(1)
        end,
        OffCommand=function(self)
            self:linear(0.1):diffusealpha(0)
        end,
        LoadActor( THEME:GetPathG("", "_grade models/Grade_Tier".. ("%02i"):format(i) ..".lua" ) )
    }
end

-- Draw the diff labels.
local isITG1 = ThemePrefs.Get("ITG1")
local diffIconGraphic = isITG1 and THEME:GetPathG('_evaluation difficulty','icons') or THEME:GetPathG('_difficulty','icons');
for difIndx,diff in ipairs(diffs) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self)
            self:xy( SCREEN_LEFT + 80 , SCREEN_CENTER_Y - 144 + (40 * difIndx) )
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
end
for difIndx,diff in ipairs(trails) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self)
            self:xy( SCREEN_LEFT + 80 , SCREEN_CENTER_Y + 16 + (40 * difIndx) )
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
end

for i = 1,numGrades do
    for difIndx,diff in ipairs(diffs) do
        t[#t+1] = Def.BitmapText{
            Font="_futurist metalic",
            Text=PROFILEMAN:GetMachineProfile():GetTotalStepsWithTopGrade(StepsType, diff, ("Grade_Tier%02i"):format(i)),
            InitCommand=function(self)
                self:xy( xScaleItem(i), SCREEN_CENTER_Y - 140 + (40 * difIndx) ):zoom(0.6)
            end,
            OnCommand=function(self)
                self:diffusealpha(0):linear(0.1):diffusealpha(1)
            end,
            OffCommand=function(self)
                self:linear(0.1):diffusealpha(0)
            end,
        }
    end
end

for i = 1,numGrades do
    for difIndx,diff in ipairs(trails) do
        t[#t+1] = Def.BitmapText{
            Font="_futurist metalic",
            Text=PROFILEMAN:GetMachineProfile():GetTotalTrailsWithTopGrade(StepsType, diff, ("Grade_Tier%02i"):format(i)),
            InitCommand=function(self)
                self:xy( xScaleItem(i), SCREEN_CENTER_Y + 20 + (40 * difIndx) ):zoom(0.6)
            end,
            OnCommand=function(self)
                self:diffusealpha(0):linear(0.1):diffusealpha(1)
            end,
            OffCommand=function(self)
                self:linear(0.1):diffusealpha(0)
            end,
        }
    end
end

t[#t+1] = Def.HelpDisplay {
    File="_eurostile normal",
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

return t