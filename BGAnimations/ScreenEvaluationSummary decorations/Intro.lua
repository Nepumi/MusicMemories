local t = Def.ActorFrame{
	OnCommand=cmd(draworder,50020);
};
t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:FullScreen()
	self:diffuse({0,0,0,1}):linear(1):diffuse({1,1,1,0})
	end;
};




return t;