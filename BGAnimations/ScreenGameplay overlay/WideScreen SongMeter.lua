return Def.ActorFrame{
	OnCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_TOP+24):addy(-100):sleep(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(self)
		self:sleep(1):queuecommand("TweenOff")
	end;
	ShowGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOn")
	end;
	HideGameplayTopFrameMessageCommand=function(self)
		self:playcommand("TweenOff")
	end;
	TweenOnCommand=function(self)
		self:decelerate(0.8):addy(100)
	end;
	TweenOffCommand=function(self)
		self:accelerate(0.8):addy(-100)
	end;

		Def.SongMeterDisplay{
        InitCommand=function(self)
        	self:SetStreamWidth(SCREEN_WIDTH/1.58)
        end;
        
        Stream=LoadActor("meter stream")..{
        	InitCommand=function(self)
        		self:diffusealpha(1)
        	end
        };
        Tip=LoadActor("tip")..{
            OnCommand=function(self)
            	self:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0)
            end;
        },
    },

    -- History Time
    
    -- I've made this trickery with the original meter frame texture back in 2016, when I was messing around with
    -- ITGPC and suddenly got the realization of how could I make the meter frame stretch to fit, without distoring it.
    -- I kept the code I did for this, and now it is used for Widescreen SM setups.
    																						-- Jose_Varela

    	
    	LoadActor("meter frame")..{
    		 OnCommand=function(self)
    			self:zoomtowidth(SCREEN_WIDTH/2):cropleft(0.5):x(SCREEN_WIDTH/11.5)
    		end
    	},
    	
    	LoadActor("meter frame")..{
    		 OnCommand=function(self)
    			self:zoomtowidth(SCREEN_WIDTH/2):cropright(0.5):x(SCREEN_WIDTH/-11.5)
    		end
    	},
    	
    	LoadActor("meter frame")..{
    		 OnCommand=function(self)
    			self:zoomtowidth(SCREEN_WIDTH/2):cropright(0.326):cropleft(0.326):x(0)
    		end
    	},
}
