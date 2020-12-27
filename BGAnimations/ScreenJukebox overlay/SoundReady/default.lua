
local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end

local FB = round(round(PPeng:GetFirstBeat())/4)*4
local cha = 0.5;

local Stat = 0;

function LentSeng(num)
	local Pat = "/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/SoundReady/";
	if not OP() then
	SOUND:PlayOnce(Pat.."Hat.mp3");
	else
		if num == 4 then
			SOUND:PlayOnce(Pat.."readys.wav");
		elseif num == 3 then
			SOUND:PlayOnce(Pat.."count3s.wav");
		elseif num == 2 then
			SOUND:PlayOnce(Pat.."count2s.wav");
		elseif num == 1 then
			SOUND:PlayOnce(Pat.."count1s.wav");
		elseif num == 0 then
			SOUND:PlayOnce(Pat.."gos.wav");
		end
	end
end


local function MS(self)
	local this = self:GetChildren()
if GAMESTATE:GetSongBeat() >= FB-1-cha  and Stat == 4 then
Stat = Stat + 1;
this.Ma:settext("IKU")
LentSeng(0)
--Go
elseif GAMESTATE:GetSongBeat() >= FB-2-cha and Stat == 3 then
Stat = Stat + 1;
this.Ma:settext("1")
LentSeng(1)
--1
elseif GAMESTATE:GetSongBeat() >= FB-3-cha and Stat == 2 then
Stat = Stat + 1;
this.Ma:settext("2")
LentSeng(2)
--2
elseif GAMESTATE:GetSongBeat() >= FB-4-cha and Stat == 1 then
Stat = Stat + 1;
this.Ma:settext("3")
LentSeng(3)
--3
elseif GAMESTATE:GetSongBeat() >= FB-8-cha and Stat == 0 then
Stat = Stat + 1;
this.Ma:settext("READY")
LentSeng(4)
--R U Ready
end


end


local Tune = Def.ActorFrame{
InitCommand=cmd(SetUpdateFunction,MS);

LoadFont("Common Normal")..{
Name = "Ma";
InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.65;zoom,0;rainbow;settext,"Nope");
};




};
return Tune;