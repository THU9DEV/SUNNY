local httpService = game:GetService("HttpService");
local ThemeManager = {};
do
	local FlatIdent_53387 = 0;
	while true do
		if (4 == FlatIdent_53387) then
			ThemeManager.ApplyToGroupbox = function(self, groupbox)
				local FlatIdent_254D4 = 0;
				while true do
					if (FlatIdent_254D4 == 0) then
						assert(self.Library, "Must set ThemeManager.Library first!");
						self:CreateThemeManager(groupbox);
						break;
					end
				end
			end;
			ThemeManager:BuildFolderTree();
			break;
		end
		if (FlatIdent_53387 == 0) then
			ThemeManager.Folder = "LinoriaLibSettings";
			ThemeManager.Library = nil;
			ThemeManager.BuiltInThemes = {Default={1,httpService:JSONDecode('{"MainColor":"000000","AccentColor":"0055ff","OutlineColor":"2a2a2a","BackgroundColor":"000000","FontColor":"ffffff"}')},Dracula={2,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"232533","AccentColor":"6271a5","BackgroundColor":"1b1c27","OutlineColor":"7c82a7"}')},["Bitch Bot"]={3,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}')},["Kiriot Hub"]={4,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"30333b","AccentColor":"ffaa00","BackgroundColor":"1a1c20","OutlineColor":"141414"}')},Fatality={5,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}')},Green={6,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"141414","AccentColor":"00ff8b","BackgroundColor":"1c1c1c","OutlineColor":"3c3c3c"}')},Jester={7,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},Mint={8,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},["Tokyo Night"]={9,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}')},Ubuntu={10,httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}')}};
			ThemeManager.ApplyTheme = function(self, theme)
				local customThemeData = self:GetCustomTheme(theme);
				local data = customThemeData or self.BuiltInThemes[theme];
				if not data then
					return;
				end
				local scheme = data[2];
				for idx, col in next, customThemeData or scheme do
					self.Library[idx] = Color3.fromHex(col);
					if Options[idx] then
						Options[idx]:SetValueRGB(Color3.fromHex(col));
					end
				end
				self:ThemeUpdate();
			end;
			FlatIdent_53387 = 1;
		end
		if (FlatIdent_53387 == 2) then
			ThemeManager.GetCustomTheme = function(self, file)
				local FlatIdent_37E34 = 0;
				local path;
				local data;
				local success;
				local decoded;
				while true do
					if (FlatIdent_37E34 == 0) then
						path = self.Folder .. "/themes/" .. file;
						if not isfile(path) then
							return nil;
						end
						FlatIdent_37E34 = 1;
					end
					if (FlatIdent_37E34 == 1) then
						data = readfile(path);
						success, decoded = pcall(httpService.JSONDecode, httpService, data);
						FlatIdent_37E34 = 2;
					end
					if (2 == FlatIdent_37E34) then
						if not success then
							return nil;
						end
						return decoded;
					end
				end
			end;
			ThemeManager.SaveCustomTheme = function(self, file)
				local FlatIdent_8EF0D = 0;
				local theme;
				local fields;
				while true do
					if (FlatIdent_8EF0D == 2) then
						writefile(self.Folder .. "/themes/" .. file .. ".json", httpService:JSONEncode(theme));
						break;
					end
					if (FlatIdent_8EF0D == 0) then
						if (file:gsub(" ", "") == "") then
							return self.Library:Notify("Invalid file name for theme (empty)", 3);
						end
						theme = {};
						FlatIdent_8EF0D = 1;
					end
					if (FlatIdent_8EF0D == 1) then
						fields = {"FontColor","MainColor","AccentColor","BackgroundColor","OutlineColor"};
						for _, field in next, fields do
							theme[field] = Options[field].Value:ToHex();
						end
						FlatIdent_8EF0D = 2;
					end
				end
			end;
			ThemeManager.ReloadCustomThemes = function(self)
				local FlatIdent_625A1 = 0;
				local list;
				local out;
				while true do
					if (FlatIdent_625A1 == 1) then
						for i = 1, #list do
							local FlatIdent_5FF4A = 0;
							local file;
							while true do
								if (FlatIdent_5FF4A == 0) then
									file = list[i];
									if (file:sub(-5) == ".json") then
										local FlatIdent_426D9 = 0;
										local pos;
										local char;
										while true do
											if (FlatIdent_426D9 == 0) then
												pos = file:find(".json", 1, true);
												char = file:sub(pos, pos);
												FlatIdent_426D9 = 1;
											end
											if (1 == FlatIdent_426D9) then
												while (char ~= "/") and (char ~= "\\") and (char ~= "") do
													pos = pos - 1;
													char = file:sub(pos, pos);
												end
												if ((char == "/") or (char == "\\")) then
													table.insert(out, file:sub(pos + 1));
												end
												break;
											end
										end
									end
									break;
								end
							end
						end
						return out;
					end
					if (FlatIdent_625A1 == 0) then
						list = listfiles(self.Folder .. "/themes");
						out = {};
						FlatIdent_625A1 = 1;
					end
				end
			end;
			ThemeManager.SetLibrary = function(self, lib)
				self.Library = lib;
			end;
			FlatIdent_53387 = 3;
		end
		if (FlatIdent_53387 == 3) then
			ThemeManager.BuildFolderTree = function(self)
				local FlatIdent_6F40D = 0;
				local paths;
				local parts;
				while true do
					if (FlatIdent_6F40D == 2) then
						table.insert(paths, self.Folder .. "/settings");
						for i = 1, #paths do
							local str = paths[i];
							if not isfolder(str) then
								makefolder(str);
							end
						end
						break;
					end
					if (1 == FlatIdent_6F40D) then
						for idx = 1, #parts do
							paths[#paths + 1] = table.concat(parts, "/", 1, idx);
						end
						table.insert(paths, self.Folder .. "/themes");
						FlatIdent_6F40D = 2;
					end
					if (FlatIdent_6F40D == 0) then
						paths = {};
						parts = self.Folder:split("/");
						FlatIdent_6F40D = 1;
					end
				end
			end;
			ThemeManager.SetFolder = function(self, folder)
				local FlatIdent_88398 = 0;
				while true do
					if (FlatIdent_88398 == 0) then
						self.Folder = folder;
						self:BuildFolderTree();
						break;
					end
				end
			end;
			ThemeManager.CreateGroupBox = function(self, tab)
				local FlatIdent_95492 = 0;
				while true do
					if (FlatIdent_95492 == 0) then
						assert(self.Library, "Must set ThemeManager.Library first!");
						return tab:AddLeftGroupbox("Themes");
					end
				end
			end;
			ThemeManager.ApplyToTab = function(self, tab)
				local FlatIdent_80FE7 = 0;
				local groupbox;
				while true do
					if (FlatIdent_80FE7 == 1) then
						self:CreateThemeManager(groupbox);
						break;
					end
					if (FlatIdent_80FE7 == 0) then
						assert(self.Library, "Must set ThemeManager.Library first!");
						groupbox = self:CreateGroupBox(tab);
						FlatIdent_80FE7 = 1;
					end
				end
			end;
			FlatIdent_53387 = 4;
		end
		if (FlatIdent_53387 == 1) then
			ThemeManager.ThemeUpdate = function(self)
				local FlatIdent_2567A = 0;
				while true do
					if (FlatIdent_2567A == 3) then
						self.Library:UpdateColorsUsingRegistry();
						break;
					end
					if (FlatIdent_2567A == 1) then
						self.Library.AccentColor = Options.AccentColor.Value;
						self.Library.BackgroundColor = Options.BackgroundColor.Value;
						FlatIdent_2567A = 2;
					end
					if (FlatIdent_2567A == 0) then
						self.Library.FontColor = Options.FontColor.Value;
						self.Library.MainColor = Options.MainColor.Value;
						FlatIdent_2567A = 1;
					end
					if (FlatIdent_2567A == 2) then
						self.Library.OutlineColor = Options.OutlineColor.Value;
						self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
						FlatIdent_2567A = 3;
					end
				end
			end;
			ThemeManager.LoadDefault = function(self)
				local FlatIdent_80A66 = 0;
				local theme;
				local content;
				local isDefault;
				while true do
					if (FlatIdent_80A66 == 1) then
						isDefault = true;
						if content then
							if self.BuiltInThemes[content] then
								theme = content;
							elseif self:GetCustomTheme(content) then
								theme = content;
								isDefault = false;
							end
						elseif self.BuiltInThemes[self.DefaultTheme] then
							theme = self.DefaultTheme;
						end
						FlatIdent_80A66 = 2;
					end
					if (FlatIdent_80A66 == 2) then
						if isDefault then
							Options.ThemeManager_ThemeList:SetValue(theme);
						else
							self:ApplyTheme(theme);
						end
						break;
					end
					if (0 == FlatIdent_80A66) then
						theme = "Default";
						content = isfile(self.Folder .. "/themes/default.txt") and readfile(self.Folder .. "/themes/default.txt");
						FlatIdent_80A66 = 1;
					end
				end
			end;
			ThemeManager.SaveDefault = function(self, theme)
				writefile(self.Folder .. "/themes/default.txt", theme);
			end;
			ThemeManager.CreateThemeManager = function(self, groupbox)
				groupbox:AddLabel("Background color"):AddColorPicker("BackgroundColor", {Default=self.Library.BackgroundColor});
				groupbox:AddLabel("Main color"):AddColorPicker("MainColor", {Default=self.Library.MainColor});
				groupbox:AddLabel("Accent color"):AddColorPicker("AccentColor", {Default=self.Library.AccentColor});
				groupbox:AddLabel("Outline color"):AddColorPicker("OutlineColor", {Default=self.Library.OutlineColor});
				groupbox:AddLabel("Font color"):AddColorPicker("FontColor", {Default=self.Library.FontColor});
				local ThemesArray = {};
				for Name, Theme in next, self.BuiltInThemes do
					table.insert(ThemesArray, Name);
				end
				table.sort(ThemesArray, function(a, b)
					return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1];
				end);
				groupbox:AddDivider();
				groupbox:AddDropdown("ThemeManager_ThemeList", {Text="Theme list",Values=ThemesArray,Default=1});
				groupbox:AddButton("Set as default", function()
					local FlatIdent_28718 = 0;
					while true do
						if (0 == FlatIdent_28718) then
							self:SaveDefault(Options.ThemeManager_ThemeList.Value);
							self.Library:Notify(string.format("Set default theme to %q", Options.ThemeManager_ThemeList.Value));
							break;
						end
					end
				end);
				Options.ThemeManager_ThemeList:OnChanged(function()
					self:ApplyTheme(Options.ThemeManager_ThemeList.Value);
				end);
				groupbox:AddDivider();
				groupbox:AddDropdown("ThemeManager_CustomThemeList", {Text="Custom themes",Values=self:ReloadCustomThemes(),AllowNull=true,Default=1});
				groupbox:AddInput("ThemeManager_CustomThemeName", {Text="Custom theme name"});
				groupbox:AddButton("Load custom theme", function()
					self:ApplyTheme(Options.ThemeManager_CustomThemeList.Value);
				end);
				groupbox:AddButton("Save custom theme", function()
					self:SaveCustomTheme(Options.ThemeManager_CustomThemeName.Value);
					Options.ThemeManager_CustomThemeList.Values = self:ReloadCustomThemes();
					Options.ThemeManager_CustomThemeList:SetValues();
					Options.ThemeManager_CustomThemeList:SetValue(nil);
				end);
				groupbox:AddButton("Refresh list", function()
					local FlatIdent_CA20 = 0;
					while true do
						if (FlatIdent_CA20 == 0) then
							Options.ThemeManager_CustomThemeList.Values = self:ReloadCustomThemes();
							Options.ThemeManager_CustomThemeList:SetValues();
							FlatIdent_CA20 = 1;
						end
						if (FlatIdent_CA20 == 1) then
							Options.ThemeManager_CustomThemeList:SetValue(nil);
							break;
						end
					end
				end);
				groupbox:AddButton("Set as default", function()
					if ((Options.ThemeManager_CustomThemeList.Value ~= nil) and (Options.ThemeManager_CustomThemeList.Value ~= "")) then
						local FlatIdent_38BAE = 0;
						while true do
							if (FlatIdent_38BAE == 0) then
								self:SaveDefault(Options.ThemeManager_CustomThemeList.Value);
								self.Library:Notify(string.format("Set default theme to %q", Options.ThemeManager_CustomThemeList.Value));
								break;
							end
						end
					end
				end);
				ThemeManager:LoadDefault();
				local function UpdateTheme()
					self:ThemeUpdate();
				end
				Options.BackgroundColor:OnChanged(UpdateTheme);
				Options.MainColor:OnChanged(UpdateTheme);
				Options.AccentColor:OnChanged(UpdateTheme);
				Options.OutlineColor:OnChanged(UpdateTheme);
				Options.FontColor:OnChanged(UpdateTheme);
			end;
			FlatIdent_53387 = 2;
		end
	end
end
return ThemeManager;
