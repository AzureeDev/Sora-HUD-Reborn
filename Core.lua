_G.NepgearsyHUDReborn = _G.NepgearsyHUDReborn or {}

function NepgearsyHUDReborn:Init()
	self.Dev = false
	self.Version = "2.7.0 - Epic Update"
	self.ModVersion = self.update_module_data.module.version or self.Version
	--self.WaifuSend = false

	self:Log("Initialized.")
end

NepgearsyHUDReborn.localization = {
    { text = "NepgearsyHUDReborn/Localization/English", path = "english.json" },
    { text = "NepgearsyHUDReborn/Localization/Turkish", path = "turkish.json", requires_default_font = true },
    { text = "NepgearsyHUDReborn/Localization/Portuguese", path = "portuguese.json" },
    { text = "NepgearsyHUDReborn/Localization/Spanish", path = "spanish.json" },
    { text = "NepgearsyHUDReborn/Localization/Russian", path = "russian.json", requires_default_font = true },
    { text = "NepgearsyHUDReborn/Localization/French", path = "french.json" },
    { text = "NepgearsyHUDReborn/Localization/Romanian", path = "romanian.json" },
    { text = "NepgearsyHUDReborn/Localization/German", path = "german.json" },
    { text = "NepgearsyHUDReborn/Localization/Thai", path = "thai.json", requires_default_font = true },
    { text = "NepgearsyHUDReborn/Localization/SimplifiedChinese", path = "chinese.json", requires_default_font = true },
	--{ text = "NepgearsyHUDReborn/Localization/Italian", path = "italian.json", },
    { text = "NepgearsyHUDReborn/Localization/Polish", path = "polish.json" },
    { text = "NepgearsyHUDReborn/Localization/Korean", path = "korean.json", requires_default_font = true }
}

NepgearsyHUDReborn.creators = {
	{ name = "Sora", steam_id = "76561198111947132", desc = "Made the code." },
	{ name = "Matthelzor", steam_id = "76561198084015153", desc = "Made the awesome background of the Control Panel." },
	{ name = "Luffy", steam_id = "76561198075720845", desc = "Helped with LUA, and made the HUD scaling options." },
	{ name = "=PDTC= Splat", steam_id = "76561198085683005", desc = "Helped with testing stuff." },
	{ name = "Babyforce", steam_id = "76561198053887800", desc = "Giving me his thoughts and helping." },
	{ name = "sydch pasha", steam_id = "76561198063913184", desc = "Made the Turkish localization" },
	{ name = "AldoRaine, gabsF", steam_id = nil, desc = "Made the Portuguese localization" },
	{ name = "ElReyZero", steam_id = "76561198143859174", desc = "Made the Spanish localization" },
	{ name = "Blake Langermann", steam_id = "76561198015483064", desc = "Made the Russian localization" },
	{ name = "=PDTC= Dobby Senpai", steam_id = "76561198040053543", desc = "Helped with finding a sock." },
	{ name = "Anthony", steam_id = "76561198164452807", desc = "Made the French localization" },
	{ name = "freaky", steam_id = "76561198376903915", desc = "Made the Romanian localization" },
	{ name = "Commander Neru", steam_id = "76561198090284682", desc = "Helped with testing." },
	{ name = "DreiPixel", steam_id = "76561197998773513", desc = "Made the German localization" },
	{ name = "Hinaomi", steam_id = "76561198027102120", desc = "Made the Thai localization" },
	{ name = "FR0Z3", steam_id = "76561198058215284", desc = "Made the Simplified Chinese localization" },
	{ name = "VladTheH", steam_id = "76561198149442981", desc = "Made the Polish localization" },
	{ name = "Gullwing Door", steam_id = "76561198062944994", desc = "Made the Korean localization" }
}

NepgearsyHUDReborn.colors = {
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

if NepgearsyHUDReborn.Dev then table.insert(NepgearsyHUDReborn.Colors, "DEV") end -- hi :3

NepgearsyHUDReborn.fonts = {
	"NepgearsyHUDReborn/Fonts/Normal",
	"NepgearsyHUDReborn/Fonts/Eurostile",
	"NepgearsyHUDReborn/Fonts/PDTH"
}

NepgearsyHUDReborn.HealthStyle = {
	"NepgearsyHUDReborn/HealthStyle/Thin",
	"NepgearsyHUDReborn/HealthStyle/Vanilla"
}

NepgearsyHUDReborn.StatusNumberType = {
	"NepgearsyHUDReborn/StatusNumberType/Health_Counter",
	"NepgearsyHUDReborn/StatusNumberType/Shield_Counter",
	"NepgearsyHUDReborn/StatusNumberType/HealthShieldCombined",
	"NepgearsyHUDReborn/StatusNumberType/None"
}

NepgearsyHUDReborn.TeammatePanelStyles = {
	"nepgearsy_hud_reborn_default",
	"nepgearsy_hud_reborn_sora_wide",
	"nepgearsy_hud_reborn_none"
}

NepgearsyHUDReborn.DiscordRichPresenceTypes = {
	"NepgearsyHUDReborn/Discord/DefaultType",
	"NepgearsyHUDReborn/Discord/KillTracker"
}

NepgearsyHUDReborn.DiscordRichPresenceLargeImageTypes = {
	"NepgearsyHUDReborn/Discord/LargeImageCharacter",
	"NepgearsyHUDReborn/Discord/LargeImageHeist"
}

NepgearsyHUDReborn.TeammateSkinsCollectionLegacy = {
	"default",
	"community",
	"pd2",
	"suguri",
	"hdn",
	"plush",
	"persona",
	"kiniro",
	"genshin",
	"starrail",
	"other"
}

NepgearsyHUDReborn.TeammateSkinsCollection = {
	default = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/DefaultHeader",
	pd2 = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PD2Header",
	community = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/CommunityHeader",
	hdn = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/HDNHeader",
	suguri = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/SuguriHeader",
	plush = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PlushHeader",
	persona = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PersonaHeader",
	kiniro = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/KiniroHeader",
	genshin = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/GenshinHeader",
	starrail = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/StarrailHeader",
	other = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/OtherHeader"
}

NepgearsyHUDReborn.TeammateSkins = {
	{ author = "Sora", collection = "default", name = "Default", texture = "NepgearsyHUDReborn/HUD/Teammate", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/default" },
	{ author = "Sora", collection = "default", name = "Default Thin", texture = "NepgearsyHUDReborn/HUD/TeammateThin" },
	{ author = "you", collection = "default", name = "Custom", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/custom/your_texture" },
	{ author = "Sora", collection = "hdn", name = "Neptune", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/neptune_1" },
	{ author = "Sora", collection = "hdn", name = "Nepgear", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/nepgear_1" },
	{ author = "Sora", collection = "hdn", name = "Nepgear & Uni", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/nepgear_uni_1" },
	{ author = "Sora", collection = "hdn", name = "The Maid Team", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/maid_1" },
	{ author = "Sora", collection = "hdn", name = "Rom & Ram", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/rom_ram_1" },
	{ author = "Sora", collection = "hdn", name = "Histoire", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/histoire_1" },
	{ author = "Sora", collection = "suguri", name = "Suguri & Others", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/suguri_1" },
	{ author = "Sora (xd)", collection = "suguri", name = "Sora", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sora_1", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/suguri/sora" },
	{ author = "Sora", collection = "other", name = "Eclipse", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/eclipse_1" },
	{ author = "Sora", collection = "other", name = "OwO", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/owo_1" },
	{ author = "Sora", collection = "hdn", name = "Orange Heart", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/orange_heart_1", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/hdn/orange_heart" },
	{ author = "Sora", collection = "hdn", name = "5pb", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/5pb_1" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_1" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_2" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_3", wide_counterpart = "NepgearsyHUDReborn/HUD/WideTeammateSkins/plush/plush_3" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_4" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_5" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_6" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_7" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_8" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_9" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_10" },
	{ author = "Sora", collection = "plush", name = "Plushie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_11" },
	{ author = "Sora", collection = "hdn", name = "Nepgear & Neptune", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/nepgear_neptune_1" },
	{ author = "Sora", collection = "hdn", name = "Blanc", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/blanc_1" },
	{ author = "Sora", collection = "other", name = "Hatsune Miku", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/miku_1" },
	{ author = "Sora", collection = "other", name = "Kurumi (School Live)", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/shovi_1" },
	{ author = "t0rkoal_", collection = "community", name = "Tamamo", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/tamamo" },
	{ author = "Sora", collection = "hdn", name = "Orange Heart", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/hdn/orange_heart_2" },
	{ author = "t0rkoal_", collection = "community", name = "Astolfo", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/astolfo" },
	{ author = "t0rkoal_", collection = "community", name = "Chibi Sydney", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/chibi_sydney" },
	{ author = "t0rkoal_", collection = "community", name = "Breaking News", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/breaking_news" },
	{ author = "Commander Neru", collection = "persona", name = "Aigis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Aigis" },
	{ author = "Commander Neru", collection = "persona", name = "Akihiko Sanada", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Akihiko_Sanada" },
	{ author = "Commander Neru", collection = "persona", name = "Chidori Yoshino", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Chidori_Yoshino" },
	{ author = "Commander Neru", collection = "persona", name = "Elizabeth", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Elizabeth" },
	{ author = "Commander Neru", collection = "persona", name = "Fuuka Yamagishi", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Fuuka_Yamagishi" },
	{ author = "Commander Neru", collection = "persona", name = "Jin Shirato", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Jin_Shirato" },
	{ author = "Commander Neru", collection = "persona", name = "Junpei Iori", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Junpei_Iori" },
	{ author = "Commander Neru", collection = "persona", name = "Ken Amada", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Ken_Amada" },
	{ author = "Commander Neru", collection = "persona", name = "Koromaru", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Koromaru" },
	{ author = "Commander Neru", collection = "persona", name = "Minato Arisato", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Minato_Arisato" },
	{ author = "Commander Neru", collection = "persona", name = "Mitsuru Kirijo", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Mitsuru_Kirijo" },
	{ author = "Commander Neru", collection = "persona", name = "Shinjiro Aragaki", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Shinjiro_Aragaki" },
	{ author = "Commander Neru", collection = "persona", name = "Takaya Sakagi", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Takaya_Sakagi" },
	{ author = "Commander Neru", collection = "persona", name = "Yukari Takeba", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Yukari_Takeba" },
	{ author = "Commander Neru", collection = "persona", name = "Minako Arisato", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Minako_Arisato" },
	{ author = "Commander Neru", collection = "persona", name = "Minato Shadow", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/clair/Minato_Shadow" },
	{ author = "Sora", collection = "suguri", name = "Sora (2)", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sora_2" },
	{ author = "Sora", collection = "pd2", name = "Dallas", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/dallas" },
	{ author = "Sora", collection = "pd2", name = "Wolf", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/wolf" },
	{ author = "Sora", collection = "pd2", name = "Chains", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/chains" },
	{ author = "Sora", collection = "pd2", name = "Hoxton", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/hoxton" },
	{ author = "Sora", collection = "pd2", name = "Houston", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/houston" },
	{ author = "Sora", collection = "pd2", name = "John Wick", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jw" },
	{ author = "Sora", collection = "pd2", name = "Clover", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/clover" },
	{ author = "Sora", collection = "pd2", name = "Dragan", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/dragan" },
	{ author = "Sora", collection = "pd2", name = "Jacket", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jacket" },
	{ author = "Sora", collection = "pd2", name = "Bonnie", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/bonnie" },
	{ author = "Sora", collection = "pd2", name = "Sokol", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/sokol" },
	{ author = "Sora", collection = "pd2", name = "Jiro", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jiro" },
	{ author = "Sora", collection = "pd2", name = "Bodhi", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/bodhi" },
	{ author = "Sora", collection = "pd2", name = "Jimmy", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/jimmy" },
	{ author = "Sora", collection = "pd2", name = "Sydney", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/sydney" },
	{ author = "Sora", collection = "pd2", name = "Rust", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/rust" },
	{ author = "Sora", collection = "pd2", name = "Scarface", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/scarface" },
	{ author = "Sora", collection = "pd2", name = "Sangres", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/sangres" },
	{ author = "Sora", collection = "pd2", name = "Duke", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/duke" },
	{ author = "Sora", collection = "pd2", name = "Joy", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/pd2/joy" },
	{ author = "t0rkoal_", collection = "community", name = "Aniday 2", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/aniheat" },
	{ author = "t0rkoal_", collection = "community", name = "cs_office", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/cs_office" },
	{ author = "t0rkoal_", collection = "community", name = ":csd2smile:", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/csd2smile" },
	{ author = "t0rkoal_", collection = "community", name = "Nightingale", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/florence" },
	{ author = "t0rkoal_", collection = "community", name = "Gudako", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/gacha" },
	{ author = "t0rkoal_", collection = "community", name = "Solo Jazz", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/jazz" },
	{ author = "t0rkoal_", collection = "community", name = "Super Shorty", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/madshorty" },
	{ author = "t0rkoal_", collection = "community", name = "Goro's Jacket", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/majimasnakeskin" },
	{ author = "t0rkoal_", collection = "community", name = "Shots Fired", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/neondeath" },
	{ author = "t0rkoal_", collection = "community", name = "Signal Lost", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/outage" },
	{ author = "t0rkoal_", collection = "community", name = "Astolfo Wink", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/tagwink" },
	{ author = "t0rkoal_", collection = "community", name = "Miko", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/tamamo_redux" },
	{ author = "t0rkoal_", collection = "community", name = "Armed Youmu", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/youmu_gun" },
	{ author = "t0rkoal_", collection = "community", name = "All You Need", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/416" },
	{ author = "t0rkoal_", collection = "community", name = "Minimal Saber", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/artoria" },
	{ author = "t0rkoal_", collection = "community", name = "Wow", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/doge" },
	{ author = "t0rkoal_", collection = "community", name = "Long IDW", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/idw" },
	{ author = "t0rkoal_", collection = "community", name = "Jeanne", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/jeanne" },
	{ author = "t0rkoal_", collection = "community", name = "Feeder", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/mp7" },
	{ author = "t0rkoal_", collection = "community", name = "Nero", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/nero" },
	{ author = "t0rkoal_", collection = "community", name = "Vector", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/vector" },
	{ author = "t0rkoal_", collection = "community", name = "Vector (2)", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/torkoal/vector_ii" },
	{ author = "Sora", collection = "other", name = "NZ75", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/nz75" },
	{ author = "Sora", collection = "plush", name = "Sora's Plush", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/plush/plush_sora" },
	{ author = "RJC9000", collection = "other", name = "Magician", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/magician" },
	{ author = "RJC9000", collection = "other", name = "Miko", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/other/miko" },
	{ author = "Sora", collection = "default", name = "PAYDAY Borders", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/TeammateBorder" },
	{ author = "kruiserdb", collection = "community", name = "Philia Salis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Phillia_Salis_1" },
	{ author = "kruiserdb", collection = "community", name = "Philia Salis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Phillia_Salis_2" },
	{ author = "kruiserdb", collection = "community", name = "Philia Salis", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Phillia_Salis_3" },
	{ author = "kruiserdb", collection = "community", name = "Yume & Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Yume__Laura" },
	{ author = "kruiserdb", collection = "community", name = "Cheetahmen", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Cheetahman" },
	{ author = "kruiserdb", collection = "community", name = "Signalize!", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Signalize" },
	{ author = "kruiserdb", collection = "community", name = "Behemoth", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Behemoth" },
	{ author = "kruiserdb", collection = "community", name = "Sakuraba Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Sakuraba_Laura_1" },
	{ author = "kruiserdb", collection = "community", name = "Sakuraba Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Sakuraba_Laura_2" },
	{ author = "kruiserdb", collection = "community", name = "Sakuraba Laura", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/kruiser/Sakuraba_Laura_3" },
	{ author = "Joltin135", collection = "community", name = "'The Forgotten Skin'", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/joltin" },
	{ author = "Kinrade", collection = "community", name = "Corey", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/corey" },
	{ author = "gabsF", collection = "community", name = "Twinkle", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/twinkle" },
	{ author = "Syphist", collection = "community", name = "Earth Chan", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/earth_chan" },
	{ author = "Syphist", collection = "kiniro", name = "Alice", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_alice" },
	{ author = "Syphist", collection = "kiniro", name = "Aya", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_aya" },
	{ author = "Syphist", collection = "kiniro", name = "Karen", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_karen" },
	{ author = "Syphist", collection = "kiniro", name = "Shinobu", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_shinobu" },
	{ author = "Syphist", collection = "kiniro", name = "Yoko", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/kinmoza_yoko" },
	{ author = "Syphist", collection = "community", name = "Minecraft Dirt", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/mc_dirt" },
	{ author = "Syphist", collection = "community", name = "Sans", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/sans" },
	{ author = "Syphist", collection = "community", name = "Windows XP Bliss", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/earthchan/winxp_bliss" },
	{ author = "_Direkt", collection = "community", name = "Hannibal Buress", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/community/whyyoubooingme" },
	{ author = "Sora", collection = "suguri", name = "Suguri", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sugu_2" },
	{ author = "Sora", collection = "suguri", name = "Suguri & Hime", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sugu_hime" },
	{ author = "Sora", collection = "suguri", name = "Sora (Military)", dev = true, texture = "NepgearsyHUDReborn/HUD/TeammateSkins/suguri/sora_m_1" },
	{ author = "Sora", collection = "default", name = "Rounded", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/rounded_default" },
	{ author = "Sora", collection = "default", name = "No Frame", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/no_frame" },
	{ author = "Sora", collection = "default", name = "Golden Frame", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/golden_frame" },
	{ author = "Sora", collection = "default", name = "Rainbow", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/defaults/rainbow" },
	{ author = "Sora", collection = "genshin", name = "Paimon", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/paimon" },
	{ author = "Sora", collection = "genshin", name = "Lumine & Aether", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/lumineaether" },
	{ author = "Sora", collection = "genshin", name = "Venti", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/venti" },
	{ author = "Sora", collection = "genshin", name = "Zhongli", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/zhongli" },
	{ author = "Sora", collection = "genshin", name = "Raiden Shogun", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/ei" },
	{ author = "Sora", collection = "genshin", name = "Nahida", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/nahida" },
	{ author = "Sora", collection = "genshin", name = "Furina", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/furina" },
	{ author = "Sora", collection = "genshin", name = "Diona", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/diona" },
	{ author = "Sora", collection = "genshin", name = "Razor", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/razor" },
	{ author = "Sora", collection = "genshin", name = "Klee", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/klee" },
	{ author = "Sora", collection = "genshin", name = "Eula", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/eula" },
	{ author = "Sora", collection = "genshin", name = "Hu Tao", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/hutao" },
	{ author = "Sora", collection = "genshin", name = "Itto", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/itto" },
	{ author = "Sora", collection = "genshin", name = "Kazuha", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/kazuha" },
	{ author = "Sora", collection = "genshin", name = "Nilou", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/nilou" },
	{ author = "Sora", collection = "genshin", name = "Xiao", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/genshin/xiao" },
	{ author = "Sora", collection = "starrail", name = "Pom-Pom", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/starrail/pom" },
	{ author = "Sora", collection = "starrail", name = "March 7th", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/starrail/march" },
	{ author = "Sora", collection = "starrail", name = "Asta", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/starrail/asta" },
	{ author = "Sora", collection = "starrail", name = "Bronya", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/starrail/bronya" },
	{ author = "Sora", collection = "starrail", name = "Clara", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/starrail/clara" },
	{ author = "Sora", collection = "starrail", name = "Kafka", texture = "NepgearsyHUDReborn/HUD/TeammateSkins/starrail/kafka" }
}

--[[
function NepgearsyHUDReborn:GetInteractionColorBySave()
	local saved_id = self:GetOption("InteractionColor")

	return self:StringToColor(saved_id)
end
]]

function NepgearsyHUDReborn:GetTeammateSkinBySave()
	local is_wide = self:IsTeammatePanelWide()
	local skin_id = self:GetOption("TeammateSkin")

	local skin = self.TeammateSkins[skin_id] or self.TeammateSkins[1]

	if is_wide and skin.wide_counterpart then
		return skin.wide_counterpart
	end

	return skin.texture
end

function NepgearsyHUDReborn:GetTeammateSkinById(id)
	local is_wide = self:IsTeammatePanelWide()
	local skin = self.TeammateSkins[tonumber(id)] or self.TeammateSkins[1]

	if is_wide and skin.wide_counterpart then
		return skin.wide_counterpart
	end

	return skin.texture
end

function NepgearsyHUDReborn:IsTeammatePanelWide()
	if self:GetOption("TeammatePanelStyle") == "nepgearsy_hud_reborn_sora_wide" then
		return true
	end

	return false
end

function NepgearsyHUDReborn:TeammateRadialIDToPath(id, type)
	local radial_color = { "", "Green", "Red", "Orange", "Yellow", "Cyan", "BlueOcean", "Blue", "Purple", "Pink", "Fushia", "RedFushia" }
	if type == "Health" then
		return "NepgearsyHUDReborn/HUD/Health" .. radial_color[id]
	elseif type == "Armor" then
		return "NepgearsyHUDReborn/HUD/Shield" .. radial_color[id]
	end
end

function NepgearsyHUDReborn:StringToColor(id)
	local stc = {
		Color(1, 1, 1),
		Color(0, 1, 0),
		Color(1, 0, 0),
		Color(1, 0.5, 0),
		Color(1, 1, 0),
		Color(0, 1, 1),
		Color(0, 0.5, 1),
		Color(0, 0, 1),
		Color(0.8, 0, 1),
		Color(1, 0.5, 1),
		Color(1, 0, 1),
		Color(1, 0, 0.6)
	}

	return stc[id]
end

function NepgearsyHUDReborn:SteamAvatar(steam_id, set, params)
	params = params or {}
	local quality = params.quality or 1
	local refresh = params.refresh or false
	local retrieving_tries = params.retrieving_tries or 0
	local max_tries = 3
	if refresh then max_tries = 1 end

	Steam:friend_avatar(quality, steam_id, function(texture)
		if texture then
			set(texture)
		end

		if (refresh or not texture) and retrieving_tries < max_tries then
			DelayedCalls:Add("NepAvatar_" .. steam_id .. "_" .. retrieving_tries, 1.5, function()
				if refresh then
					self:DebugLog("SteamAvatar: fetching " .. steam_id)
				else
					self:DebugLog("SteamAvatar: refetching " .. retrieving_tries + 1 .. "/" .. max_tries .. " " .. steam_id)
				end

				self:SteamAvatar(steam_id, set, {
					retrieving_tries = retrieving_tries + 1,
					max_tries = max_tries,
					quality = quality,
					refresh = refresh
				})
			end)
		elseif not texture then
			self:Log("SteamAvatar: Max tries reached, pass: " .. steam_id)
		end
	end)
end

function NepgearsyHUDReborn:Log(text, ...)
	log("[NepgearsyHUDReborn] LOG: " .. text, ...)
end

function NepgearsyHUDReborn:DebugLog(text, ...)
	if not self.Dev then
		return
	end

	log("[NepgearsyHUDReborn] DEVLOG: " .. text, ...)
end

function NepgearsyHUDReborn:Error(text, ...)
	log("[NepgearsyHUDReborn] ERROR: " .. text, ...)
end

function NepgearsyHUDReborn:GetOption(option_name)
	return self.Options:GetValue(option_name)
end

function NepgearsyHUDReborn:SetOption(option_name, option_value)
	self:DebugLog("SetOption: " .. tostring(option_name) .. " == " .. tostring(option_value))
	self.Options:SetValue(option_name, option_value)
	self.Options:Save()
end

-- Init NepHook functions based on Luffy's one. Hug to you if you read this :satanialove:
_G.NepHook = _G.NepHook or {}
function NepHook:Add(based_hook, content)
	local concat_id = based_hook .. "_NepgearsyHUDReborn"
	Hooks:Add(based_hook, concat_id, content)
end

function NepHook:Post(based_class, based_func, content)
	local concat_id = "NepgearsyHUDReborn_" .. based_func .. "_PostHook"
	Hooks:PostHook(based_class, based_func, concat_id, content)
end

function NepHook:Pre(based_class, based_func, content)
	local concat_id = "NepgearsyHUDReborn_" .. based_func .. "_PreHook"
	Hooks:PreHook(based_class, based_func, concat_id, content)
end

NepHook:Add("MenuManagerBuildCustomMenus", function(menu_manager, nodes)
	MenuCallbackHandler.NepgearsyHUDRebornMenu = callback(NepHudMenu, NepHudMenu, "SetEnabled", true)
	local node = nodes["blt_options"]
	local item = node:create_item({ type = "CoreMenuItem.Item" }, {
		name = "NepgearsyHUDRebornMenu",
		text_id = "NepgearsyHUDRebornMenu",
		callback = "NepgearsyHUDRebornMenu",
		localize = true,
	})
	node:add_item(item)
end)

NepHook:Add("LocalizationManagerPostInit", function(loc_manager)
	local chosen = NepgearsyHUDReborn:GetOption("ForcedLocalization")
	local loc = NepgearsyHUDReborn.localization[chosen]
	local fallback = NepgearsyHUDReborn.localization[1]

	if not loc then
		NepgearsyHUDReborn:Error("Can't load a localization file if there's no ID for it! Returning english.")
		loc = fallback
	end

	local folder = NepgearsyHUDReborn.ModPath .. "Localization/"
	if SystemFS:exists(folder .. fallback.path) then
		loc_manager:load_localization_file(folder .. fallback.path)
	else
		NepgearsyHUDReborn:Error("No english loc found??")
		return
	end

	if loc ~= fallback then
		if SystemFS:exists(folder .. loc.path) then
			loc_manager:load_localization_file(folder .. loc.path)
		else
			NepgearsyHUDReborn:Error("ID available for chosen localization, but file is missing! Returning english.")
		end
	end
end)

NepHook:Add("NetworkReceivedData", function(sender, id, data)
    if id == "nephud_teammate_bg" then
        managers.player._player_teammate_bgs[sender] = data
    end

    if NepgearsyHUDReborn:GetOption("EnableStarring") then
        local briefing = managers.hud and managers.hud._hud_mission_briefing
        local starring_panel = briefing and briefing:_star()
        if starring_panel then
            local player_slot = starring_panel:child("player_" .. sender)
            if id == "StarringColor" then
                player_slot:set_color(NepgearsyHUDReborn:StringToColor(tonumber(data)))
            end

            if id == "StarringText" then
                if briefing then
                    briefing._custom_starring[sender] = ", " .. tostring(data)

                    local peer = managers.network and managers.network:session() and managers.network:session():peer(sender)
                    if peer then
                        briefing:_update_name(peer:name(), sender)
                    end
                end
            end
        end
    end
end)

function NepgearsyHUDReborn:IsLanguageFontLimited(lang)
    return self.localization[lang] and self.localization[lang].requires_default_font or false
end

function NepgearsyHUDReborn:SetFont(font)
	if self:IsLanguageFontLimited(self:GetOption("ForcedLocalization")) then
		return "fonts/font_large_mf"
	end

	return font
end

function NepgearsyHUDReborn:SetDiscordPresence(title, desc)
	local custom = self:GetOption("DiscordRichPresenceCustom")
	if custom ~= "" then
		Discord:set_status(custom, title)
	else
		Discord:set_status(desc, title)
	end

	if self:GetOption("DRPAllowTimeElapsed") then
		Discord:set_start_time_relative(0)
	else
		Discord:set_start_time(0)
	end
end
