ratemod = string.match(GAMESTATE:GetSongOptionsString(), "%d.%d");
if ratemod then
	ratemod = tonumber(ratemod);
else
	ratemod = 1.0
end

local Bpm1 = 0;
local Bpm2 = 0;
local Bpm = 0;

local fz = 0.7;

local t = Def.ActorFrame{
	OnCommand=cmd(y,24);
LoadFont("Common Normal")..{
OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-212;diffuse,color("#FFFFFF");zoom,0.7;playcommand,'loop');
		loopCommand=function(self)
		--[[if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		Bpm1 = GAMESTATE:GetPlayerState(PLAYER_1):GetSongPosition():GetCurBPS() * 60;
		end
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		Bpm2 = GAMESTATE:GetPlayerState(PLAYER_2):GetSongPosition():GetCurBPS() * 60;
		end
		
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		Bpm=(Bpm1+Bpm2)/2;
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		Bpm=Bpm2
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		Bpm=Bpm1
		end]]--GetTrueBPS
		Bpm = GAMESTATE:GetSongPosition():GetCurBPS() * 60*
		SCREENMAN:GetTopScreen():GetHasteRate();

		if Bpm > 600 then
		self:rainbowscroll(true)
		else
		self:rainbowscroll(false)
		end
		
		if ratemod == 1 then
		self:settext(round(Bpm))
		end
		self:diffuse(BPMColor(Bpm))
		self:strokecolor(ColorTone(BPMColor(Bpm)))
		
		
		self:sleep(1/30)
		self:queuecommand('loop')
		end;

};




LoadFont("Common Normal")..{
Condition=(ratemod ~= 1);
OnCommand=cmd(x,SCREEN_CENTER_X-27.5;y,SCREEN_CENTER_Y-212;diffuse,color("#FFFFFF");zoom,0.6;playcommand,'loop');
		loopCommand=function(self)
		self:settextf("%d x %.1f =",round(Bpm),ratemod)
		self:diffuse(BPMColor(Bpm))
		self:sleep(1/30)
		self:queuecommand('loop')
		end;
};
LoadFont("Common Normal")..{
Condition=(ratemod ~= 1);
OnCommand=cmd(x,SCREEN_CENTER_X+20;y,SCREEN_CENTER_Y-212;diffuse,color("#FFFFFF");zoom,0.7;playcommand,'loop');
		loopCommand=function(self)

		if Bpm*ratemod > 600 then
		self:rainbowscroll(true)
		else
		self:rainbowscroll(false)
		end
		if round(Bpm)*ratemod >= 1000 then
		self:settextf("%.d",round(Bpm)*ratemod)
		else
		self:settextf("%.1f",round(Bpm)*ratemod)
		end
		self:diffuse(BPMColor(Bpm*ratemod))
		self:sleep(1/30)
		self:queuecommand('loop')
		end;
};
};
return t;