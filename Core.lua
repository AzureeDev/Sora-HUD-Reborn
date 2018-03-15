if not ModCore then
	log("[NepgearsyHUDReborn] ERROR : ModCore from BeardLib is not present! Is BeardLib installed?")
	return
end

NepgearsyHUDReborn = NepgearsyHUDReborn or ModCore:new(ModPath .. "config.xml", true, true)

function NepgearsyHUDReborn:Init()
	self.Version = "1.0.0"
	self.Initialized = true;
	self:Log("Initialized.")
end

function NepgearsyHUDReborn:Log(text, ...)
	log("[NepgearsyHUDReborn] LOG : " .. text, ...)
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