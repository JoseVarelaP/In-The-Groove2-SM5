local c;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = THEME:GetMetric("Combo", "PulseCommand");
local PulseLabel = THEME:GetMetric("Combo", "PulseLabelCommand");

local FullComboGreats = THEME:GetMetric("Combo", "FullComboGreatsCommand");
local FullComboPerfects = THEME:GetMetric("Combo", "FullComboPerfectsCommand");
local FullComboMarvelouses = THEME:GetMetric("Combo", "FullComboMarvelousesCommand");

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");

local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");

local t = Def.ActorFrame {
	InitCommand=cmd(vertalign,bottom);

	LoadFont( "_xenotron", "metal" ) .. {
		Name="Number";
		OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
	};
	LoadActor("../combo label") .. {
		Name="Label";
		OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
	};


	-- 100 Combo milestone
	LoadActor("explosion")..{
	InitCommand=cmd(diffusealpha,0;blend,"BlendMode_Add");
	HundredMilestoneCommand=cmd(rotationz,0;zoom,2.6;diffusealpha,0.5;linear,0.5;rotationz,90;zoom,2;diffusealpha,0);
	},

	LoadActor("explosion")..{
	InitCommand=cmd(diffusealpha,0;blend,"BlendMode_Add");
	HundredMilestoneCommand=cmd(rotationz,0;zoom,2.6;diffusealpha,0.5;linear,0.5;rotationz,-90;zoom,2;diffusealpha,0);
	},

	-- 1000 Combo milestone
	LoadActor("explosion")..{
	InitCommand=cmd(diffusealpha,0;blend,"BlendMode_Add");
	ThousandMilestoneCommand=cmd(rotationz,0;zoom,2.6;diffusealpha,0.5;linear,0.5;rotationz,90;zoom,2;diffusealpha,0);
	},

	LoadActor("explosion")..{
	InitCommand=cmd(diffusealpha,0;blend,"BlendMode_Add");
	ThousandMilestoneCommand=cmd(rotationz,0;zoom,2.6;diffusealpha,0.5;linear,0.5;rotationz,-90;zoom,2;diffusealpha,0);
	},

	LoadActor("shot")..{
	InitCommand=cmd(diffusealpha,0;blend,"BlendMode_Add");
	ThousandMilestoneCommand=cmd(zoomx,-2;zoomy,2;diffusealpha,1;x,0;linear,0.5;diffusealpha,0;x,-150);
	},
	LoadActor("shot")..{
	InitCommand=cmd(diffusealpha,0;blend,"BlendMode_Add");
	ThousandMilestoneCommand=cmd(zoomx,2;zoomy,2;diffusealpha,1;x,0;linear,0.5;diffusealpha,0;x,150);
	},

	
	InitCommand = function(self)
		c = self:GetChildren();
		c.Number:visible(false);
		c.Label:visible(false);
	end;
	-- Milestones:
	-- 25,50,100,250,600 Multiples;
--[[ 		if (iCombo % 100) == 0 then
			c.OneHundredMilestone:playcommand("Milestone");
		elseif (iCombo % 250) == 0 then
			-- It should really be 1000 but thats slightly unattainable, since
			-- combo doesnt save over now.
			c.OneThousandMilestone:playcommand("Milestone");
		else
			return
		end; --]]
	TwentyFiveMilestoneCommand=function(self,parent)
		(cmd(skewy,-0.125;decelerate,0.325;skewy,0))(self);
	end;
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			c.Number:visible(false);
			c.Number:y(15);
			c.Label:visible(false);
			c.Label:y(10);
			return;
		end

		c.Label:visible(false);

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );
		
		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );
		
		c.Number:visible(true);
		c.Label:visible(true);
		c.Number:settext( string.format("%i", iCombo) );
		-- FullCombo Rewards
		if param.FullComboW1 then
			(cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#94EBFE");effectperiod,0.5))(c.Number);
			(cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#94EBFE");effectperiod,0.5))(c.Label);
		elseif param.FullComboW2 then
			(cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#FDD599");effectperiod,0.5))(c.Number);
			(cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#FDD599");effectperiod,0.5))(c.Label);
		elseif param.FullComboW3 then
			c.Number:stopeffect();
			c.Label:stopeffect();
		elseif param.Combo then
			c.Number:diffuse(Color("White"));
			c.Number:stopeffect();
			c.Label:stopeffect();
			(cmd(diffuse,Color("White");))(c.Label);
		else
			c.Number:diffuse(color("#ffffff"));
			c.Number:stopeffect();
		end

		c.Number:finishtweening();
		c.Label:finishtweening();
		-- Pulse
		Pulse( c.Number, param );
		PulseLabel( c.Label, param );
		-- Milestone Logic
	end;
};

return t;
