if not ModCore then
	log("[NepgearsyHUDReborn] ERROR : ModCore from BeardLib is not present! Is BeardLib installed?")
	return
end

NepgearsyHUDReborn = NepgearsyHUDReborn or ModCore:new(ModPath .. "config.xml", true, true)

function NepgearsyHUDReborn:Init()
	self.Dev = false
	self.Version = NepgearsyHUDReborn.update_module_data.module.version
	self.ModPath = ModPath
	self.WaifuSend = false

	self:InitCollabs()
	self:InitTweakData()
	self:InitChangelog()
	self:InitLocalization()

	self.Initialized = true;
	self:Log("Initialized.")
end

function NepgearsyHUDReborn:InitCollabs()
	self.Creators = {
		[1] = {
			name = "Nepgearsy",
			steam_id = "76561198045788203",
			action = "Made the code. If you have issues, contact me."
		},
		[2] = {
			name = "Matthelzor",
			steam_id = "76561198084015153",
			action = "Made the awesome background of the Control Panel."
		},
		[3] = {
			name = "Luffy",
			steam_id = "76561198075720845",
			action = "Helped with LUA stuff when I needed. He also made the HUD scaling options."
		},
		[4] = {
			name = "=PDTC= Splat",
			steam_id = "76561198085683005",
			action = "Helped with testing stuff."
		},
		[5] = {
			name = "Babyforce",
			steam_id = "76561198053887800",
			action = "Giving me his thoughts and helping."
		},
		[6] = {
			name = "sydch pasha",
			steam_id = "76561198063913184",
			action = "Made the Turkish localization"
		},
		[7] = {
			name = "AldoRaine",
			steam_id = "76561198079386949",
			action = "Made the Portuguese localization"
		},
		[8] = {
			name = "ElReyZero",
			steam_id = "76561198143859174",
			action = "Made the Spanish localization"
		},
		[9] = {
			name = "Blake Langermann",
			steam_id = "76561198015483064",
			action = "Made the Russian localization"
		},
		[10] = {
			name = "=PDTC= Dobby Senpai",
			steam_id = "76561198040053543",
			action = "Helped with finding a sock."
		},
		[11] = {
			name = "Anthony",
			steam_id = "76561198164452807",
			action = "Made the French localization"
		},
		[12] = {
			name = "freaky",
			steam_id = "76561198376903915",
			action = "Made the Romanian localization"
		},
		[13] = {
			name = "Commander Neru",
			steam_id = "76561198090284682",
			action = "Helped with testing."
		},
		[14] = {
			name = "DreiPixel",
			steam_id = "76561197998773513",
			action = "Made the German localization"
		},
		[15] = {
			name = "Hinaomi",
			steam_id = "76561198027102120",
			action = "Made the Thai localization"
		}		
	}
end

function NepgearsyHUDReborn:InitTweakData()
	self.StarringColors = {
		"NepgearsyHUDReborn/Color/White",
		"NepgearsyHUDReborn/Color/Red",
		"NepgearsyHUDReborn/Color/Green",
		"NepgearsyHUDReborn/Color/Blue",
		"NepgearsyHUDReborn/Color/Purple",
		"NepgearsyHUDReborn/Color/Yellow",
		"NepgearsyHUDReborn/Color/Orange",
		"NepgearsyHUDReborn/Color/Pink",
		"NepgearsyHUDReborn/Color/Fushia",
		"NepgearsyHUDReborn/Color/Cyan",
		"NepgearsyHUDReborn/Color/Blue_Ocean",
		"NepgearsyHUDReborn/Color/Red_Fushia"
	}
	if self.Dev then table.insert(self.StarringColors, "DEV") end -- hi :3

	self.CPColors = deep_clone(self.StarringColors)
	self.CPBorderColors = deep_clone(self.StarringColors)

	self.AssaultBarFonts = {
		"NepgearsyHUDReborn/Fonts/Normal",
		"NepgearsyHUDReborn/Fonts/Eurostile"
	}

	self.HealthColor = {
		"NepgearsyHUDReborn/Color/White",
		"NepgearsyHUDReborn/Color/Green",
		"NepgearsyHUDReborn/Color/Red",
		"NepgearsyHUDReborn/Color/Orange",
		"NepgearsyHUDReborn/Color/Yellow",
		"NepgearsyHUDReborn/Color/Cyan",
		"NepgearsyHUDReborn/Color/Blue_Ocean",
		"NepgearsyHUDReborn/Color/Blue",
		"NepgearsyHUDReborn/Color/Purple",
		"NepgearsyHUDReborn/Color/Pink",
		"NepgearsyHUDReborn/Color/Fushia",
		"NepgearsyHUDReborn/Color/Red_Fushia"
	}

	self.ArmorColor = deep_clone(self.HealthColor)
	self.ObjectiveColor = deep_clone(self.StarringColors)

	self.HealthStyle = {
		"NepgearsyHUDReborn/HealthStyle/Thin",
		"NepgearsyHUDReborn/HealthStyle/Vanilla"
	}

	self.StatusNumberType = {
		"NepgearsyHUDReborn/StatusNumberType/Health_Counter",
		"NepgearsyHUDReborn/StatusNumberType/Shield_Counter"
	}
end

function NepgearsyHUDReborn:TeammateRadialIDToPath(id, type)
	local tritp = {}

	for i = 1, 12 do
		tritp[i] = {}
	end

	tritp[1]["Health"] = "NepgearsyHUDReborn/HUD/Health"
	tritp[2]["Health"] = "NepgearsyHUDReborn/HUD/HealthGreen"
	tritp[3]["Health"] = "NepgearsyHUDReborn/HUD/HealthRed"
	tritp[4]["Health"] = "NepgearsyHUDReborn/HUD/HealthOrange"
	tritp[5]["Health"] = "NepgearsyHUDReborn/HUD/HealthYellow"
	tritp[6]["Health"] = "NepgearsyHUDReborn/HUD/HealthCyan"
	tritp[7]["Health"] = "NepgearsyHUDReborn/HUD/HealthBlueOcean"
	tritp[8]["Health"] = "NepgearsyHUDReborn/HUD/HealthBlue"
	tritp[9]["Health"] = "NepgearsyHUDReborn/HUD/HealthPurple"
	tritp[10]["Health"] = "NepgearsyHUDReborn/HUD/HealthPink"
	tritp[11]["Health"] = "NepgearsyHUDReborn/HUD/HealthFushia"
	tritp[12]["Health"] = "NepgearsyHUDReborn/HUD/HealthRedFushia"

	tritp[1]["Armor"] = "NepgearsyHUDReborn/HUD/Shield"
	tritp[2]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldGreen"
	tritp[3]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldRed"
	tritp[4]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldOrange"
	tritp[5]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldYellow"
	tritp[6]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldCyan"
	tritp[7]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldBlueOcean"
	tritp[8]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldBlue"
	tritp[9]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldPurple"
	tritp[10]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldPink"
	tritp[11]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldFushia"
	tritp[12]["Armor"] = "NepgearsyHUDReborn/HUD/ShieldRedFushia"

	return tritp[id][type]
end

function NepgearsyHUDReborn:StringToColor(module, id)
	local stc = {}
	stc["starring"] = {}
	stc["starring"][1] = Color.white
	stc["starring"][2] = Color.red
	stc["starring"][3] = Color.green
	stc["starring"][4] = Color.blue
	stc["starring"][5] = Color("9800ff")
	stc["starring"][6] = Color.yellow
	stc["starring"][7] = Color("ff6e00")
	stc["starring"][8] = Color("ffa3f5")
	stc["starring"][9] = Color("ff00e3")
	stc["starring"][10] = Color("00ffff")
	stc["starring"][11] = Color("2f5ab7")
	stc["starring"][12] = Color("ff006e")
	stc["starring"][13] = Color(1, 0.63, 0.58, 0.95)

	stc["cpcolor"] = deep_clone(stc["starring"])
	stc["cpbordercolor"] = deep_clone(stc["starring"])
	stc["objective_color"] = deep_clone(stc["starring"])

	return stc[module][id]
end

function NepgearsyHUDReborn:InitChangelog()
	if SystemFS:exists(self.ModPath .. "Changelog.txt") then
		local file = io.open( self.ModPath .. "Changelog.txt", "r")
		self.Changelog = file:read("*all")
		return
	end

	self.Changelog = ""
	return
end

function NepgearsyHUDReborn:InitLocalization()
	self.LocalizationTable = {}
	self.Localization = {
		[1] = {
			localized_name = "NepgearsyHUDReborn/Localization/English",
			path = "english.txt"
		},
		[2] = {
			localized_name = "NepgearsyHUDReborn/Localization/Turkish",
			path = "turkish.txt"
		},
		[3] = {
			localized_name = "NepgearsyHUDReborn/Localization/Portuguese",
			path = "portuguese.txt"
		},
		[4] = {
			localized_name = "NepgearsyHUDReborn/Localization/Spanish",
			path = "spanish.txt"
		},
		[5] = {
			localized_name = "NepgearsyHUDReborn/Localization/Russian",
			path = "russian.txt"
		},
		[6] = {
			localized_name = "NepgearsyHUDReborn/Localization/French",
			path = "french.txt"
		},
		[7] = {
			localized_name = "NepgearsyHUDReborn/Localization/Romanian",
			path = "romanian.txt"
		},
		[8] = {
			localized_name = "NepgearsyHUDReborn/Localization/German",
			path = "german.txt"
		},
		[9] = {
			localized_name = "NepgearsyHUDReborn/Localization/Thai",
			path = "thai.txt"
		}
	}

	for i, localization in ipairs(self.Localization) do 
		table.insert(self.LocalizationTable, localization.localized_name)
	end
end

function NepgearsyHUDReborn:GetForcedLocalization()
	local Chosen = self:GetOption("ForcedLocalization")
	local Folder = self.ModPath .. "Localization/"

	if not self.Localization[Chosen] then
		self:Error("Can't load a localization file if there's no ID for it! Returning english.")
		return Folder .. self.Localization[1].path
	end
	
	for i, localization in ipairs(self.Localization) do
		if i == Chosen then
			return Folder .. localization.path
		end
	end
end

function NepgearsyHUDReborn:InitMenu()
	self.Menu = NepHudMenu:new()
end

function NepgearsyHUDReborn:Log(text, ...)
	log("[NepgearsyHUDReborn] LOG : " .. text, ...)
end

function NepgearsyHUDReborn:DebugLog(text, ...)
	if not self.Dev then
		return
	end

	log("[NepgearsyHUDReborn] DEVLOG : " .. text, ...)
end

function NepgearsyHUDReborn:Error(text, ...)
	log("[NepgearsyHUDReborn] ERROR : " .. text, ...)
end

function NepgearsyHUDReborn:GetOption(option_name)
	return NepgearsyHUDReborn.Options:GetValue(option_name)
end

function NepgearsyHUDReborn:SetOption(option_name, value)
	return NepgearsyHUDReborn.Options:SetValue(option_name, value)
end

-- Init NepHook functions based on Luffy's one. Hug to you if you read this :satanialove:
NepHook = NepHook or {}

function NepHook:Post(based_class, based_func, content)
	local concat_id = tostring(based_func) .. "_PostHook"
	Hooks:PostHook(based_class, based_func, concat_id, content)
end

function NepHook:Pre(based_class, based_func, content)
	local concat_id = tostring(based_func) .. "_PreHook"
	Hooks:PreHook(based_class, based_func, concat_id, content)
end

-- Init NepgearsyHUDReborn coreclass if not initialized yet.
if not NepgearsyHUDReborn.Initialized then
	NepgearsyHUDReborn:Init()
end

if Hooks then
	Hooks:Add("MenuManagerPopulateCustomMenus", "InitNepHudMenu", callback(NepgearsyHUDReborn, NepgearsyHUDReborn, "InitMenu"))
	Hooks:Add("LocalizationManagerPostInit", "PostInitLocalizationNepHud", function(loc)
		loc:load_localization_file( NepgearsyHUDReborn:GetForcedLocalization() )
	end)
end
