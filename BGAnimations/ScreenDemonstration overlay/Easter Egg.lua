local I = math.random(1,6);
local P = 0;
local beat = 16;
local r = 0;
local M = 0;
local tick = 0;
local tick2 = 0;
local tick3 = 0;
local tick4 = 0;
local WTF = 0;
local Hi = 0;
local W = 0;
local p1score = 0;
local p1scorefin = 0;
local cursound = 1;
local H = 0;
local Nep = 0;
local t = Def.ActorFrame{};


t[#t+1] = Def.ActorFrame{
--OnCommand=cmd(effectclock,'beat';diffuseramp;effectcolor1,0.25,0.25,1,1;effectcolor2,1,0.25,0.25,1;effectperiod,0.5;effecttiming,0.25,0.50,0,0.25;effectoffset,-0.25);--Condition=MonthOfYear() == 12 or MonthOfYear() < 3
Def.ActorFrame{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,-30;diffusealpha,0;zoomx,0;sleep,0.15+0.15+0.15+0.15+0.15+0.15+2+3;diffusealpha,1;linear,0.11126465746435357;zoomx,1);
		LoadFont("_determination mono 24px") .. {
			OnCommand=cmd(diffuse,color("#ff1100");playcommand,"Update");
			CurrentSongChangedMessageCommand=cmd(playcommand,"Update");
			UpdateCommand=function(self)
				local text = ""
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if song then
					text = song:GetDisplayFullTitle()
					self:y(20)
				end
				if course then
					text = course:GetDisplayFullTitle() .. " \n " .. text;
				end
				self:settext(string.upper(text));
			end;
		};
		};
		
		LoadFont("_determination mono 24px") .. {
		OnCommand=cmd(x,SCREEN_CENTER_X;playcommand,'loop';diffuse,color("#0011FF");zoom,0.8);
		loopCommand=function(self)
					WTF=GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds()
					Hi=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())
					kuy=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond())
					Clockmin = math.floor((GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())/60)
					Clocksec = math.floor((GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())-Clockmin*60)
					ClockWTF = (string.format('%.2f',((GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())-Clockmin*60) - Clocksec))*100
					COLON = ""
					if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
						COLON = ":"
						if ClockWTF < 10 then
							RClockWTF = '0'..ClockWTF
						else
							RClockWTF = ClockWTF
						end
						if ClockWTF >= 50 then
						clocknow = " :  :  "
						else
						if Clocksec < 10 then
						clocknow = Clockmin..COLON.."0"..Clocksec..COLON..RClockWTF
						else
						clocknow = Clockmin..COLON..Clocksec..COLON..RClockWTF
						end
						end
					else
						if ClockWTF >= 50 then
						COLON = ":"
						else
						COLON = " "
						end
						if ClockWTF < 10 then
						RClockWTF = '0'..ClockWTF
						else
							RClockWTF = ClockWTF
						end
						if Clocksec < 10 then
						clocknow = Clockmin..COLON.."0"..Clocksec..COLON..RClockWTF
						else
						clocknow = Clockmin..COLON..Clocksec..COLON..RClockWTF
						end
					end
					
		if GAMESTATE:IsCourseMode() then
		self:zoom(0.7)
		self:y(-378)
		else
		self:zoom(1)
		self:y(-383)
		end					
		
		if WTF <= 0 then
		self:settext("0"..COLON.."00"..COLON.."00")
		elseif P >= 50 and P <= 55 then
		self:diffusealpha(0)
		elseif P >= 55 and P <= 100 then
		self:diffusealpha(1)
		self:settext(clocknow)
		elseif P >= 100 then
		self:settext("0"..COLON.."00"..COLON.."00")
		else
		self:settext(clocknow)
		end
		
		self:sleep(0.02)
		self:queuecommand('loop')
		end;
		};
	LoadFont("Common","Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X+2.5-160;y,56.75214415523215378951351-SCREEN_BOTTOM+40;zoom,0.7;horizalign,left);
		OnCommand=cmd(playcommand,'Super');--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
							self:diffuse(color("#ff0000"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_1);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
						if name=="" then
							self:settext("P1 Guy");
						else
							if name == "Frisk" or name == "Chara" or name == "Sans" or name == "Papyrus" or name == "Toriel" or name == "Asgore" or name == "Asriel" or name == "Undyne" or name == "Alphy" or name == "Alphys" then
							self:diffusealpha(0)
							else
							self:settext( name );
							end
						end
					end
					
				end;
};
	LoadFont("Common","Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X+2.5-160;y,56.75214415523215378951351-SCREEN_BOTTOM+40;zoom,0.7;horizalign,left);
		OnCommand=cmd(playcommand,'Super');--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
							self:diffuse(color("#ff0000"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_1);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
						if name=="" then
							self:settext("P1 Guy");
						else
							if name == "Frisk" or name == "Chara" or name == "Sans" or name == "Papyrus" or name == "Toriel" or name == "Asgore" or name == "Asriel" or name == "Undyne" or name == "Alphy" or name == "Alphys" then
							self:diffusealpha(0)
							else
							self:settext( name );
							end
						end
					end
					
				end;
};
LoadFont("_determination mono 24px") .. {
				InitCommand=cmd(x,SCREEN_CENTER_X+2.5-160;y,56.75214415523215378951351-SCREEN_BOTTOM+40;zoom,0.7;horizalign,left);
		OnCommand=cmd(playcommand,'Super');--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
							self:diffuse(color("#ff0000"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_1);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
						if name=="" then
							self:settext("P1 Guy");
						else
						self:stopeffect()
							if name == "Frisk" or name == "Chara" or name == "Sans" or name == "Papyrus" or name == "Toriel" or name == "Asgore" or name == "Undyne" or name == "Alphy" or name == "Alphys" then
							self:settext( name );
							elseif name == "Asriel" then
							self:settext( name );
							self:rainbow()
							else
							self:diffusealpha(0)
							end
						end
					end
					
				end;
};
	LoadFont("Common","Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-2.5+160;y,56.75214415523215378951351-SCREEN_BOTTOM+40;zoom,0.7;horizalign,right);
		OnCommand=cmd(playcommand,'Super');--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
							self:diffuse(color("#5555FF"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_2);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
						if name=="" then
							self:settext("P2 Guy");
						else
							if name == "Frisk" or name == "Chara" or name == "Sans" or name == "Papyrus" or name == "Toriel" or name == "Asgore" or name == "Asriel" or name == "Undyne" or name == "Alphy" or name == "Alphys" then
							self:diffusealpha(0)
							else
							self:settext( name );
							end
						end
					end
					
				end;
};
LoadFont("_determination mono 24px") .. {
				InitCommand=cmd(x,SCREEN_CENTER_X-2.5+160;y,56.75214415523215378951351-SCREEN_BOTTOM+40;zoom,0.7;horizalign,right);
		OnCommand=cmd(playcommand,'Super');--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
							self:diffuse(color("#5555FF"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_2);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
						if name=="" then
							self:settext("P2 Guy");
						else
						self:stopeffect()
							if name == "Frisk" or name == "Chara" or name == "Sans" or name == "Papyrus" or name == "Toriel" or name == "Asgore" or name == "Undyne" or name == "Alphy" or name == "Alphys" then
							self:settext( name );
							elseif name == "Asriel" then
							self:settext( name );
							self:rainbow()
							else
							self:diffusealpha(0)
							end
						end
					end
					
				end;
};
	Def.Sprite {
		Texture="Half 1x2";
		Frame0000=0;
		Delay0000=1;
		Frame0001=1;
		Delay0001=1;
		OnCommand=cmd(effectclock,'beat';x,SCREEN_CENTER_X+10;zoom,0.7;y,-383+2;playcommand,'loop';);
		loopCommand=function(self)
		WTF=GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds()
		Hi=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())
		kuy=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond())
		if P <= 50 then
		self:diffusealpha(0);
		elseif P >= 50 and P <= 55 then
		self:diffusealpha(1);
		elseif P >= 55 and P <= 100 then
		self:diffusealpha(0);
		end
		self:sleep(0.02)
		self:queuecommand('loop')
		end;
};
};

if GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(y,-SCREEN_BOTTOM+40);
		 LoadFont("_8-bit madness 72px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-135-85-55-85-17;y,SCREEN_TOP+40;zoom,1);
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
								self:diffuse(color("#FF0000"))
		end;
		BeginCommand=function(self)
					local steps = GAMESTATE:GetCurrentTrail(PLAYER_1)
			local meter = steps:GetMeter()

			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	 LoadFont("_8-bit madness 72px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+135+85+55+85+17;y,SCREEN_TOP+40;zoom,1);
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
								self:diffuse(color("#5555ff"))
		end;
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentTrail(PLAYER_2)
			local meter = steps:GetMeter()
			if meter then	
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	};
else
	t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(y,-SCREEN_BOTTOM+40);
		 LoadFont("_8-bit madness 72px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-135-85-55-85-17;y,SCREEN_TOP+40;zoom,1);
		OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
								self:diffuse(color("#FF0000"))
		end;
		BeginCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local meter = steps:GetMeter()

			if meter then	
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	 LoadFont("_8-bit madness 72px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+135+85+55+85+17;y,SCREEN_TOP+40;zoom,1);
				OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
								self:diffuse(color("#5555ff"))
		end;
		BeginCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local meter = steps:GetMeter()

			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	};
end

return t;
