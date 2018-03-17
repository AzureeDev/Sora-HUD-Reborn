if not ModCore then
	log("[NepgearsyHUDReborn] ERROR : ModCore from BeardLib is not present! Is BeardLib installed?")
	return
end

NepgearsyHUDReborn = NepgearsyHUDReborn or ModCore:new(ModPath .. "config.xml", true, true)

function NepgearsyHUDReborn:Init()
	self.Dev = true
	self.Version = "1.0.0"
	self.Changelog = "- Initial release"
	self.Initialized = true;
	self:InitCollabs()
	self:InitTweakData()
	--self:InitDefaultOptions()
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
			action = "Helped with LUA stuff when I needed."
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

	self.Waifus = {
		"None",
		"Yourself (Steam Avatar)",
		"Custom",
		"Neptune",
		"Nepgear"
	}
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

-- Init NepHook functions based on Luffy's one. Hug to you if you read this :satanialove:
NepHook = NepHook or {}

function NepHook:Post(based_class, based_func, content)
	local concat_id = based_class .. "_" .. based_func .. "_PostHook"
	Hooks:PostHook(based_class, based_func, concat_id, content)
end

function NepHook:Pre(based_class, based_func, content)
	local concat_id = based_class .. "_" .. based_func .. "_PreHook"
	Hooks:PreHook(based_class, based_func, concat_id, content)
end

-- Init NepgearsyHUDReborn coreclass if not initialized yet.
if not NepgearsyHUDReborn.Initialized then
	NepgearsyHUDReborn:Init()
end

if Hooks then
	Hooks:Add("MenuManagerPopulateCustomMenus", "InitNepHudMenu", callback(NepgearsyHUDReborn, NepgearsyHUDReborn, "InitMenu"))
end