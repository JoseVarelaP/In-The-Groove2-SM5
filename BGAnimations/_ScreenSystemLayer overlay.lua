-- SystemMessage Text
return Def.ActorFrame {
    SystemMessageMessageCommand=function(self, params)
        SystemMessageText:settext( params.Message )
        self:playcommand( "On" )
        if params.NoAnimate then
            self:finishtweening()
        end
        self:playcommand( "Off" )
    end,
    HideSystemMessageMessageCommand=function(self)
    	self:finishtweening()
    end,

    Def.Quad {
        InitCommand=function(self)
            self:zoomto(_screen.w, 40):horizalign(left):vertalign(top)
                :diffusebottomedge(0,0,0,1):diffusealpha(0):y(30)
        end,
        OnCommand=function(self)
            self:finishtweening():linear(1):diffusealpha(0.85)
                :zoomto(_screen.w, (SystemMessageText:GetHeight() + 16) * 0.8 )
        end,
        OffCommand=function(self) self:sleep(2.5):linear(0.5):diffusealpha(0) end,
    },

    LoadFont("_eurostile outline")..{
        Name="Text",
        InitCommand=function(self)
            self:maxwidth(750):horizalign(left):vertalign(top)
                :xy(SCREEN_LEFT+20, 35):diffusealpha(0):zoom(0.7)
            SystemMessageText = self
        end,
        OnCommand=function(self) self:finishtweening():diffusealpha(1):addx(-SCREEN_WIDTH):linear(0.5):addx(SCREEN_WIDTH) end,
        OffCommand=function(self) self:sleep(3):linear(0.5):diffusealpha(0) end,
    }
}
-- <Quad InitCommand="zoomtowidth,SCREEN_WIDTH;zoomtoheight,40;diffusebottomedge,0,0,0,1" />