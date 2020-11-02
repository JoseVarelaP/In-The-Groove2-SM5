local t = Def.ActorFrame{
	InitCommand=function(s) s:MaskDest() end;
	Def.Sprite{ Texture="ScreenRanking song frame" };

	LoadFont("_eurostile normal")..{
		--maxwidth,264
		InitCommand=function(s)
			s:x(-292):halign(0):zoom(0.8):shadowlength(1):wrapwidthpixels(224):maxheight(48):maxwidth(210)
		end;
		SetCommand=function(self, params)
			if params.Song then
				self:settext( params.Song:GetDisplayFullTitle() );
			end
			if params.Course then
				self:settext( params.Course:GetDisplayFullTitle() );
			end
		end;
	};
};

local c
local Scores = Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren(); end;
};

for i=1,THEME:GetMetric(Var "LoadingScreen","NumColumns") do
	Scores[#Scores+1] = LoadFont("_eurostile normal")..{ Name="Name"..i; Text="Name"..i;
		InitCommand=function(s) s:x( scale(i,1,THEME:GetMetric(Var "LoadingScreen","NumColumns"),THEME:GetMetric(Var "LoadingScreen","DifficultyStartX")-WideScale(230,330),240) ):y(-8):zoom(0.7):diffuse( color("0.8,0.8,1,1") ) end;
	};
	Scores[#Scores+1] = LoadFont("_eurostile normal")..{ Name="Score"..i; Text="Score"..i;
		InitCommand=function(s) s:x( scale(i,1,THEME:GetMetric(Var "LoadingScreen","NumColumns"),THEME:GetMetric(Var "LoadingScreen","DifficultyStartX")-WideScale(230,330),240) ):y(10):zoom(0.7):diffuse( color("0.8,0.8,1,1") ) end;
	};
end

Scores.SetCommand=function(self,param)
	local profile = PROFILEMAN:GetMachineProfile();
	for name, child in pairs(c) do child:visible(false); end
	local sel = param.Song and param.Song or param.Course
	if not sel then return end

	for i, item in pairs(param.Entries) do
		local hsl = profile:GetHighScoreList(sel, item);
		local hs = hsl and hsl:GetHighScores();

		c["Name"..i]:visible(true)
		c["Score"..i]:visible(true)
		if hs and #hs > 0 then
			c["Name"..i]:settext( hs[1]:GetName() );
			c["Score"..i]:settext( FormatPercentScore( hs[1]:GetPercentDP() ) );
		else
			c["Name"..i]:settext( "-----" );
			c["Score"..i]:settext( FormatPercentScore( 0 ) );
		end
	end
end;

t[#t+1] = Scores

return t