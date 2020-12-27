local c;
local player = Var "Player";
local SS = 0;
local PTAM = false;
local judType = "";

local Woosh = THEME:GetPathS("LifeMeterBattery","lose");



local Op = TP[ToEnumShortString(player)].ActiveModifiers.JudgmentGraphic;
judType = GetPicJudPath(Op);

local function ShowProtiming()
	  if GAMESTATE:IsDemonstration() then
	    return false
	  else
	    return GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(player));
	  end
end;
local ProtimingWidth = 240;

local LTAP;
local LER;

local function MakeAverage( t )
	local sum = 0;
	for i=1,#t do
		sum = sum + t[i];
	end
	return sum / #t
end
local muan = false;
local tTotalJudgments = {};
local guaek = 1;
local JudgeCmdsYes = {
	TapNoteScore_W1 = cmd(finishtweening;rotationz,0;shadowlength,0;y,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.2;addy,-10;decelerate,0.05*2.5;addy,10;zoomy,1;zoom,1;sleep,0.8;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_W2 = cmd(finishtweening;rotationz,0;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.15;addy,-7;decelerate,0.05*2.5;addy,7;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_W3 = cmd(finishtweening;rotationz,5;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.1;addy,-6;decelerate,0.05*2.5;addy,6;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0),
	TapNoteScore_W4 = cmd(finishtweening;rotationz,7;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_W5 = cmd(finishtweening;rotationz,15;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_Miss = cmd(finishtweening;rotationz,25;y,0;shadowlength,0;diffusealpha,1;zoom,1;y,-20;linear,0.8;y,20;sleep,0.5;linear,0.1;diffusealpha,0)
};
local JudgeCmdsNo = {
	TapNoteScore_W1 = cmd(finishtweening;rotationz,0;shadowlength,0;y,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.2;addy,-10;decelerate,0.05*2.5;addy,10;zoomy,1;zoom,1;sleep,0.8;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_W2 = cmd(finishtweening;rotationz,0;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.15;addy,-7;decelerate,0.05*2.5;addy,7;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_W3 = cmd(finishtweening;rotationz,-5;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.1;addy,-6;decelerate,0.05*2.5;addy,6;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0),
	TapNoteScore_W4 = cmd(finishtweening;rotationz,-7;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_W5 = cmd(finishtweening;rotationz,-15;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0;),
	TapNoteScore_Miss = cmd(finishtweening;rotationz,-25;y,0;shadowlength,0;diffusealpha,1;zoom,1;y,-20;linear,0.8;y,20;sleep,0.5;linear,0.1;diffusealpha,0;)
};
local OutfoxJudge = {--Ofcourse that is from outfox
	TapNoteScore_W1 = cmd(stoptweening;zoom,0.8*1.2;diffusealpha,0.75;decelerate,0.15;zoom,0.75*1.2;diffusealpha,1;sleep,0.35;decelerate,0.3;diffusealpha,0;zoom,0.6;glowblink;effectperiod,0.05;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.15")),
	TapNoteScore_W2 = cmd(stoptweening;zoom,0.8*1.2;diffusealpha,0.75;decelerate,0.15;zoom,0.75*1.2;diffusealpha,1;sleep,0.35;decelerate,0.3;diffusealpha,0;zoom,0.6*1.2),
	TapNoteScore_W3 = cmd(stoptweening;zoom,0.8*1.2;diffusealpha,0.75;decelerate,0.15;zoom,0.75*1.2;diffusealpha,1;sleep,0.35;decelerate,0.3;diffusealpha,0;zoom,0.6*1.2),
	TapNoteScore_W4 = cmd(stoptweening;zoom,0.8*1.2;diffusealpha,0.75;decelerate,0.15;zoom,0.75*1.2;diffusealpha,1;sleep,0.35;decelerate,0.3;diffusealpha,0;zoom,0.6*1.2),
	TapNoteScore_W5 = cmd(stoptweening;zoom,0.8*1.2;diffusealpha,0.75;decelerate,0.15;zoom,0.75*1.2;diffusealpha,1;sleep,0.35;decelerate,0.3;diffusealpha,0;zoom,0.6*1.2),
	TapNoteScore_Miss = cmd(stoptweening;zoom,0.8*1.2;diffusealpha,0.75;decelerate,0.15;zoom,0.75*1.2;diffusealpha,1;sleep,0.35;decelerate,0.3;diffusealpha,0)
};

local Sm5Judge = {--Much default
	TapNoteScore_W1 = cmd(finishtweening;shadowlength,0;y,0;diffusealpha,1;zoom,0.9*1.2;smooth,0.05;zoom,0.75*1.2;sleep,0.8;smooth,0.1;zoomy,0.5*1.2;zoomx,1.3*1.2;diffusealpha,0;glowblink;effectperiod,0.05;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.25")),
	TapNoteScore_W2 = cmd(finishtweening;y,0;shadowlength,0;diffusealpha,1;zoom,0.9*1.2;smooth,0.05;zoom,0.75*1.2;sleep,0.5;smooth,0.1;zoomy,0.5*1.2;zoomx,2*1.2;diffusealpha,0),
	TapNoteScore_W3 = cmd(finishtweening;y,0;shadowlength,0;diffusealpha,1;zoom,0.9*1.2;smooth,0.05;zoom,0.75*1.2;sleep,0.5;smooth,0.1;zoomy,0.5*1.2;zoomx,2*1.2;diffusealpha,0;),
	TapNoteScore_W4 = cmd(finishtweening;y,0;shadowlength,0;diffusealpha,1;zoom,0.9*1.2;smooth,0.05;zoom,0.75*1.2;sleep,0.5;smooth,0.1;zoomy,0.5*1.2;zoomx,2*1.2;diffusealpha,0;),
	TapNoteScore_W5 = cmd(finishtweening;y,0;shadowlength,0;diffusealpha,1;zoom,0.75*1.2;vibrate;effectmagnitude,1,2,2;sleep,0.5;smooth,0.1;zoomy,0.5*1.2;zoomx,2*1.2;diffusealpha,0),
	TapNoteScore_Miss = cmd(finishtweening;y,0;shadowlength,0;diffusealpha,1;zoom,0.75*1.2;y,-20;smooth,0.8;y,20;sleep,0.5;smooth,0.1;zoomy,0.5*1.2;zoomx,2*1.2;diffusealpha,0)
};

local DDRJudge = {--And it from DDR Starlight
	TapNoteScore_W1 = cmd(glowblink;effectperiod,0.025;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.2");diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0),
	TapNoteScore_W2 = cmd(stopeffect;diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0),
	TapNoteScore_W3 = cmd(stopeffect;diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0),
	TapNoteScore_W4 = cmd(stopeffect;zoom,0.6*1.5;diffusealpha,1;sleep,0.5;diffusealpha,0),
	TapNoteScore_W5 = cmd(stopeffect;zoom,0.6*1.5;diffusealpha,1;sleep,0.5;diffusealpha,0),
	TapNoteScore_Miss = cmd(stoptweening;stopeffect;zoom,0.6*1.5;linear,0.05;diffusealpha,1;linear,0.45;addy,26;linear,0;diffusealpha,0;addy,-26)
};

local ProtimingCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Protiming", "ProtimingW1Command" );
	TapNoteScore_W2 = THEME:GetMetric( "Protiming", "ProtimingW2Command" );
	TapNoteScore_W3 = THEME:GetMetric( "Protiming", "ProtimingW3Command" );
	TapNoteScore_W4 = THEME:GetMetric( "Protiming", "ProtimingW4Command" );
	TapNoteScore_W5 = THEME:GetMetric( "Protiming", "ProtimingW5Command" );
	TapNoteScore_Miss = THEME:GetMetric( "Protiming", "ProtimingMissCommand" );
};



local AverageCmds = {
	Pulse = THEME:GetMetric( "Protiming", "AveragePulseCommand" );
};
local TextCmds = {
	Pulse = THEME:GetMetric( "Protiming", "TextPulseCommand" );
};

local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};
local t = Def.ActorFrame {
	OnCommand=cmd(draworder,5000);
};
t[#t+1] = Def.ActorFrame {
	Def.Sprite{                    
		Name="Judgment";
		OnCommand=function(self)
		self:pause();
		self:visible(false);
			if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
				self:Load(GetPicJudPath("Edit 2x6.png"));
			else
				self:Load(judType);
			end
		end;
		InitCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	Def.Sprite{                    
		Name="LE";
		OnCommand=function(self)
		self:pause();
		self:visible(false);

		local JudF = Op:gsub(" %dx%d", ""):gsub(" %(doubleres%)", ""):gsub(".png", ""):gsub(" %[double%]",""):gsub(" %(res %d+x%d+%)","")

		local path = "/"..THEMEDIR().."Resource/JudF/EL/";
		
		local files = FILEMAN:GetDirListing(path)
		local RealFile = THEME:GetPathG("Def","EL");
		
		for k,filename in ipairs(files) do
			if string.match(filename, " 1x2.png") and string.match(filename,JudF) then
				RealFile = path..filename;
				break
			end
		end
		

			--Op
		self:Load(RealFile);
		end;
		InitCommand=cmd(x,40;y,40);
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};

	LoadActor(Woosh,true)..{
		Name="FAIL";
		OnCommand=cmd();
	};


	LoadFont("_roboto Bold 54px") .. {
		Name="ProtimingDisplay";
		Text="";
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","ProtimingOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	LoadFont("_open sans semibold 24px") .. {
		Name="ProtimingAverage";
		Text="";
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","AverageOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	LoadFont("_open sans semibold 24px") .. {
		Name="TextDisplay";
		Text=THEME:GetString("Protiming","MS");
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","TextOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	Def.Quad {
		Name="ProtimingGraphBG";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth,16);
		ResetCommand=cmd(finishtweening;diffusealpha,0.8;visible,false);
		OnCommand=cmd(diffuse,Color("Black");diffusetopedge,color("0.1,0.1,0.1,1");diffusealpha,0.8;shadowlength,2;);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW3";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth-4,16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W3"];);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW2";
		InitCommand=cmd(visible,false;y,32;zoomto,scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W2"];);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW1";
		InitCommand=cmd(visible,false;y,32;zoomto,scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W1"];);
	};
	Def.Quad {
		Name="ProtimingGraphUnderlay";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth-4,16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,0.25;visible,false);
		OnCommand=cmd(diffuse,Color("Black");diffusealpha,0.25);
	};
	Def.Quad {
		Name="ProtimingGraphFill";
		InitCommand=cmd(visible,false;y,32;zoomto,0,16-4;horizalign,left;);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,Color("Red"););
	};
	Def.Quad {
		Name="ProtimingGraphAverage";
		InitCommand=cmd(visible,false;y,32;zoomto,2,7;);
		ResetCommand=cmd(finishtweening;diffusealpha,0.85;visible,false);
		OnCommand=cmd(diffuse,Color("Orange");diffusealpha,0.85);
	};
	Def.Quad {
		Name="ProtimingGraphCenter";
		InitCommand=cmd(visible,false;y,32;zoomto,2,16-4;);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,Color("White");diffusealpha,1);
	};

	InitCommand = function(self)
		c = self:GetChildren();
		SS = 0 ;
	end;

	JudgmentMessageCommand=function(self, param)
        -- Fix Player Combo animating when player successfully avoids a mine.
        
		if param.TapNoteScore== "TapNoteScore_CheckpointHit" then
			if GAMESTATE:ShowW1() then
				param.TapNoteScore = "TapNoteScore_W1";
			else
				param.TapNoteScore = "TapNoteScore_W2";
			end
		elseif param.TapNoteScore== "TapNoteScore_CheckpointMiss" then
			param.TapNoteScore = "TapNoteScore_Miss";
		end
		
		if EASTER()=="FOOL" then
        --if false then
        	if param.TapNoteScore=="TapNoteScore_Miss" then
        		param.TapNoteScore="TapNoteScore_W1";
        	elseif param.TapNoteScore=="TapNoteScore_W5" then
        		param.TapNoteScore="TapNoteScore_W2";
        	elseif param.TapNoteScore=="TapNoteScore_W4" then
        		param.TapNoteScore="TapNoteScore_W3";
        	elseif param.TapNoteScore=="TapNoteScore_W3" then
        		param.TapNoteScore="TapNoteScore_W4";
        	elseif param.TapNoteScore=="TapNoteScore_W2" then
        		param.TapNoteScore="TapNoteScore_W5";
        	elseif param.TapNoteScore=="TapNoteScore_W1" then
        		param.TapNoteScore="TapNoteScore_Miss";
        	end

        	if param.Early then
        		param.Early=false
        	else
        		param.Early=true
        	end
        end

        local msgParam = param;
        MESSAGEMAN:Broadcast("TestJudgment",msgParam);
        --
		if param.Player ~= player then return end;
		if param.HoldNoteScore then return end;

		if param.Cor ~= nil then
			c.Judgment:Load(THEMEDIR().."/BGAnimations/ScreenGameplay overlay/IQ/IQJud 1x7.png");
			PTAM=true;
		elseif PTAM then
			PTAM=false;
			if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
				c.Judgment:Load(GetPicJudPath("Edit 2x6.png"));
			else
				c.Judgment:Load(judType);
			end

		end


		local iNumStates = c.Judgment:GetNumStates();
		local iFrame = TNSFrames[param.TapNoteScore];

		if not iFrame then return end
		if iNumStates == 12 then
			iFrame = iFrame * 2;
			if not param.Early then
				iFrame = iFrame + 1;
			end
		end


		local fTapNoteOffset = param.TapNoteOffset;
		if param.HoldNoteScore then
			fTapNoteOffset = 1;
		else
			fTapNoteOffset = param.TapNoteOffset;
		end

		if param.TapNoteScore == 'TapNoteScore_Miss' then
			fTapNoteOffset = 1;
			bUseNegative = true;
		else
-- 			fTapNoteOffset = fTapNoteOffset;
			bUseNegative = false;
		end;



		if fTapNoteOffset ~= 1 then
			-- we're safe, you can push the values
			tTotalJudgments[#tTotalJudgments+1] = math.abs(fTapNoteOffset);
--~ 			tTotalJudgments[#tTotalJudgments+1] = bUseNegative and fTapNoteOffset or math.abs( fTapNoteOffset );
		end

		self:playcommand("Reset");

		if Op ~= "None" or Op ~= "SM5ProTiming" then c.Judgment:setstate( iFrame ); end

		if param.Cor ~= nil then
			if not param.Cor then
				c.Judgment:setstate( 7-1 );
			end
		end

		if ((param.TapNoteScore == 'TapNoteScore_Miss'  or param.TapNoteScore == 'TapNoteScore_W5' or param.TapNoteScore == 'TapNoteScore_W4')
		or param.HoldNoteScore == "HoldNoteScore_LetGo")
		and SS == 0 then
		SS = 9999;
		c.FAIL:play()
		MESSAGEMAN:Broadcast("SOFAIL", {pn=param.Player,fr=iFrame,cor=param.Cor})
		c.Judgment:visible(false);
		else
		c.Judgment:visible(true);
		end
		
		if Op ~= "SM5ProTiming" then
			if ThemePrefs.Get("JudgeStyle") == 0 or ThemePrefs.Get("JudgeStyle") == 4 then
				if param.TapNoteScore ~= 'TapNoteScore_Miss' then
					if param.Early then
						JudgeCmdsYes[param.TapNoteScore](c.Judgment);
					else
						JudgeCmdsNo[param.TapNoteScore](c.Judgment);
					end
					muan = false;
				else
					if muan then
						JudgeCmdsYes[param.TapNoteScore](c.Judgment);
						muan = false
					else
						JudgeCmdsNo[param.TapNoteScore](c.Judgment);
						muan = true
					end
				end
			elseif ThemePrefs.Get("JudgeStyle") == 1 then
				OutfoxJudge[param.TapNoteScore](c.Judgment);
			elseif ThemePrefs.Get("JudgeStyle") == 2 then
				Sm5Judge[param.TapNoteScore](c.Judgment);
			elseif ThemePrefs.Get("JudgeStyle") == 3 then
				DDRJudge[param.TapNoteScore](c.Judgment);
			end

			c.Judgment:visible( true );
			c.ProtimingDisplay:visible( false );
			c.ProtimingAverage:visible( false );
			c.TextDisplay:visible( false );
			c.ProtimingGraphBG:visible( false );
			c.ProtimingGraphUnderlay:visible( false );
			c.ProtimingGraphWindowW3:visible( false );
			c.ProtimingGraphWindowW2:visible( false );
			c.ProtimingGraphWindowW1:visible( false );
			c.ProtimingGraphFill:visible( false );
			c.ProtimingGraphAverage:visible( false );
			c.ProtimingGraphCenter:visible( false );
		else
			c.Judgment:visible( false );
			c.ProtimingDisplay:visible( true );
			c.ProtimingDisplay:settextf("%i",fTapNoteOffset * 1000);
			ProtimingCmds[param.TapNoteScore](c.ProtimingDisplay);
			
			c.ProtimingAverage:visible( true );
			c.ProtimingAverage:settextf("%.2f%%",clamp(100 - MakeAverage( tTotalJudgments ) * 1000 ,0,100));
			AverageCmds['Pulse'](c.ProtimingAverage);
			
			c.TextDisplay:visible( true );
			TextCmds['Pulse'](c.TextDisplay);
			
			c.ProtimingGraphBG:visible( true );
			c.ProtimingGraphUnderlay:visible( true );
			c.ProtimingGraphWindowW3:visible( true );
			c.ProtimingGraphWindowW2:visible( true );
			c.ProtimingGraphWindowW1:visible( true );
			c.ProtimingGraphFill:visible( true );
			c.ProtimingGraphFill:finishtweening();
			c.ProtimingGraphFill:decelerate(1/60);
	-- 		c.ProtimingGraphFill:zoomtowidth( clamp(fTapNoteOffset * 188,-188/2,188/2) );
			c.ProtimingGraphFill:zoomtowidth( clamp(
					scale(
					fTapNoteOffset,
					0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),
					0,(ProtimingWidth-4)/2),
				-(ProtimingWidth-4)/2,(ProtimingWidth-4)/2)
			);
			c.ProtimingGraphAverage:visible( true );
			c.ProtimingGraphAverage:zoomtowidth( clamp(
					scale(
					MakeAverage( tTotalJudgments ),
					0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),
					0,ProtimingWidth-4),
				0,ProtimingWidth-4)
			);
	-- 		c.ProtimingGraphAverage:zoomtowidth( clamp(MakeAverage( tTotalJudgments ) * 1880,0,188) );
			c.ProtimingGraphCenter:visible( true );
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphBG);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphUnderlay);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW3);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW2);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW1);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphFill);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphAverage);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphCenter);
		end
		
	end;

};
t[#t+1]=Def.ActorFrame {
		Name="PORSOSAD";
		SOFAILMessageCommand=function(self,param)
			if param.pn ~= player then return end;
			self:decelerate(0.125):addy(-100):accelerate(0.5-0.125):addy(300)
		end;
	Def.Sprite{                    
		Name="SOSAD";
		InitCommand=function(self)
		self:pause();
		self:visible(false);
			if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
				self:Load(GetPicJudPath("Edit 2x6.png"));
			else
				self:Load(judType);
			end
		end;
		OnCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
		SOFAILMessageCommand=function(self,param)
			if param.pn ~= player then return end;
			if param.cor ~= nil then
				self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay overlay/IQ/IQJud 1x7.png");
			else
				self:Load(judType);
			end
			if Op ~= "None" then self:setstate( param.fr ) end
			self:visible(true):linear(0.5):addx(math.random(-150,150)):diffusealpha(0):rotationz(math.random( -15, 15 )):zoom(2)
		end;
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	};

t[#t+1] = LoadActor( THEME:GetPathS("LifeMeterBattery","gain") ,true)..{
	Name = "WTF";
	JudgmentMessageCommand=function(self, param)
		if param.Cor ~= nil and param.Cor == true then
			self:playforplayer(player)
		end
	end;
};
t[#t+1] = LoadActor( THEME:GetPathS("LifeMeterBattery","lose") ,true)..{
	Name = "WTF2";
	JudgmentMessageCommand=function(self, param)
		if param.Cor ~= nil and param.Cor == false then
			self:playforplayer(player)
		end
	end;
};


return t;