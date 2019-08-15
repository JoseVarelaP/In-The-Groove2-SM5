return Def.ActorFrame{
	OnCommand=function(s)
		s:xy(SCREEN_CENTER_X,SCREEN_TOP+24):addy(-100):sleep(0.5):queuecommand("TweenOn")
	end;
	OffCommand=function(s)
		s:sleep(1):queuecommand("TweenOff")
	end;
	ShowGameplayTopFrameMessageCommand=function(s)
		s:playcommand("TweenOn")
	end;
	HideGameplayTopFrameMessageCommand=function(s)
		s:playcommand("TweenOff")
	end;
	TweenOnCommand=function(s)
		s:decelerate(0.8):addy(100)
	end;
	TweenOffCommand=function(s)
		s:accelerate(0.8):addy(-100)
	end;

		Def.SongMeterDisplay{
        InitCommand=function(s)
        	s:SetStreamWidth(SCREEN_WIDTH/1.58)
        end;
        
        Stream=LoadActor("meter stream")..{
        	InitCommand=function(s)
        		s:diffusealpha(1)
        	end
        };
        Tip=LoadActor("tip")..{
            OnCommand=function(s)
            	s:diffuseshift():effectcolor1(1,1,1,0.6):effectcolor2(1,1,1,1.0)
            end;
        },
    },

    -- History Time
    
    -- I've made this trickery with the original meter frame texture back in 2016, when I was messing around with
    -- ITGPC and suddenly got the realization of how could I make the meter frame stretch to fit, without distoring it.
    -- I kept the code I did for this, and now it is used for Widescreen SM setups.
    																						-- Jose_Varela

    	
    	LoadActor("meter frame")..{
    		 OnCommand=function(s)
    			s:zoomtowidth(SCREEN_WIDTH/2):cropleft(0.5):x(SCREEN_WIDTH/11.5)
    		end
    	},
    	
    	LoadActor("meter frame")..{
    		 OnCommand=function(s)
    			s:zoomtowidth(SCREEN_WIDTH/2):cropright(0.5):x(SCREEN_WIDTH/-11.5)
    		end
    	},
    	
    	LoadActor("meter frame")..{
    		 OnCommand=function(s)
    			s:zoomtowidth(SCREEN_WIDTH/2):cropright(0.326):cropleft(0.326):x(0)
    		end
    	},
}
