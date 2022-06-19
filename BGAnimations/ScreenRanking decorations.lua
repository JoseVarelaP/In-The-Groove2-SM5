local t = Def.ActorFrame{}
for i=1,2 do
    t[#t+1] = Def.Quad{
        OnCommand=function(self)
            self:xy( SCREEN_CENTER_X, i == 1 and 0 or SCREEN_BOTTOM ):vertalign( i == 1 and top or bottom )
            :zoomto( SCREEN_WIDTH,70 ):MaskSource()
        end
    }

    t[#t+1] = Def.Quad{
        OnCommand=function(self)
            self:xy( SCREEN_CENTER_X, i == 1 and 68 or SCREEN_BOTTOM-68 ):vertalign( i == 1 and top or bottom )
            :zoomto( 640,2 )
        end
    }
end

for i=1,THEME:GetMetric(Var "LoadingScreen","NumColumns") do
    local coldiff = THEME:GetMetric(Var "LoadingScreen","ColumnDifficulty"..i)
    t[#t+1] = Def.BitmapText{
        Font="Common Normal",
        Text=THEME:GetString("Difficulty", ToEnumShortString(coldiff)),
        OnCommand=function(s)
            s:zoom(0.6):xy( THEME:GetMetric(Var "LoadingScreen", "DifficultyStartX")-6+( 100*i ), 36 )
            :diffusealpha(0):sleep(0.3+0.05*i):linear(0.2):diffusealpha(1)
        end,
        OffCommand=function(s) s:sleep(0.05*i):linear(0.15):diffusealpha(0) end
    }
    t[#t+1] = Def.Sprite{
        Texture=THEME:GetPathG("_difficulty","icons"),
        OnCommand=function(self)
            self:animate(0):setstate( THEME:GetMetric(Var "LoadingScreen","ColumnDifficulty1") == "Difficulty_Easy" and i or i+1 )
            :xy( THEME:GetMetric(Var "LoadingScreen", "DifficultyStartX")-6+( 100*i ), 36 )
            :diffusealpha(0):sleep(0.3+0.05*i):linear(0.2):diffusealpha(1)
        end,
        OffCommand=function(s) s:sleep(0.05*i):linear(0.15):diffusealpha(0) end
    }
end

t[#t+1] = Def.BitmapText{
    Font=_eurostileColorPick(),
    OnCommand=function(self)
        self:xy( 40, 40 ):halign(0):zoom(0.8)
        local highScoresType = THEME:GetMetric(Var "LoadingScreen","HighScoresType")
        local stepstype = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
		self:settext(
            THEME:GetString("HighScoresType",ToEnumShortString(highScoresType)) .. " " ..
            THEME:GetString("StepsType", ToEnumShortString(stepstype) )
        )
        :diffusealpha(0):sleep(0.3):linear(0.2):diffusealpha(1)
    end,
    OffCommand=function(s) s:linear(0.3):diffusealpha(0) end
}

return t