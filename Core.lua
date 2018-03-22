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
		}
	}
end

function NepgearsyHUDReborn:InitTweakData()
	self.StarringColors = {
		"White",
		"Red",
		"Green",
		"Blue",
		"Purple",
		"Yellow",
		"Orange",
		"Pink",
		"Fushia",
		"Cyan",
		"Blue Ocean",
		"Red Fushia"
	}
	if self.Dev then table.insert(self.StarringColors, "DEV") end -- hi :3

	self.CPColors = deep_clone(self.StarringColors)
	
	self.Waifus = {
		"None (Steam Avatar used)",
		"Neptune",
		"Noire",
		"Blanc",
		"Vert",
		"Nepgear",
		"Uni",
		"Rom",
		"Ram",
		"Compa",
		"IF",
		"5pb"
	}

	self.AssaultBarFonts = {
		"Normal",
		"Eurostile"
	}

	self.HealthColor = {
		"White",
		"Green",
		"Red",
		"Orange",
		"Yellow",
		"Cyan",
		"Blue Ocean",
		"Blue",
		"Purple",
		"Pink",
		"Fushia",
		"Red Fushia"
	}

	self.ArmorColor = deep_clone(self.HealthColor)
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

	return stc[module][id]
end

function NepgearsyHUDReborn:GetWaifuPathById(id)
	if id == 1 then
		return
	end

	local waifu_path = {}
	waifu_path[2] = "NepgearsyHUDReborn/HUD/Waifu/Neptune"
	waifu_path[3] = "NepgearsyHUDReborn/HUD/Waifu/Noire"
	waifu_path[4] = "NepgearsyHUDReborn/HUD/Waifu/Blanc"
	waifu_path[5] = "NepgearsyHUDReborn/HUD/Waifu/Vert"
	waifu_path[6] = "NepgearsyHUDReborn/HUD/Waifu/Nepgear"
	waifu_path[7] = "NepgearsyHUDReborn/HUD/Waifu/Uni"
	waifu_path[8] = "NepgearsyHUDReborn/HUD/Waifu/Rom"
	waifu_path[9] = "NepgearsyHUDReborn/HUD/Waifu/Ram"
	waifu_path[10] = "NepgearsyHUDReborn/HUD/Waifu/Compa"
	waifu_path[11] = "NepgearsyHUDReborn/HUD/Waifu/IF"
	waifu_path[12] = "NepgearsyHUDReborn/HUD/Waifu/5pb"

	return waifu_path[id]
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
	self.Localization = {}
	self.Localization[1] = "english.txt"
	self.Localization[2] = "turkish.txt"
	self.Localization[3] = "portuguese.txt"
end

function NepgearsyHUDReborn:GetForcedLocalization()
	local Chosen = self:GetOption("ForcedLocalization")
	local Folder = self.ModPath .. "Localization/"

	if not self.Localization[Chosen] then
		self:Error("Can't load a localization file if there's no ID for it! Returning english.")
		return Folder .. self.Localization[1]
	end
	
	return Folder .. self.Localization[Chosen]
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