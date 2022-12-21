function NepgearsyHUDReborn:Init()
	self.Dev = false
	self.Version = "2.6.0 - Resurrection"
	self.ModVersion = NepgearsyHUDReborn.update_module_data.module.version or self.Version
	self.WaifuSend = false

	self:InitCollabs()
	self:InitTweakData()
	self:InitLocalization()

	self.Initialized = true;
	self.DiscordInitialized = false;
	self.HasDiscordCustomStatus = self:GetOption("DiscordRichPresenceCustom") ~= ""
	self:Log("Initialized.")
end

function NepgearsyHUDReborn:InitCollabs()
	self.Creators = {
		[1] = {
			name = "Sora",
			steam_id = "76561198111947132",
			action = "Made the code."
		},
		[2] = {
			name = "Matthelzor",
			steam_id = "76561198084015153",
			action = "Made the awesome background of the Control Panel."
		},
		[3] = {
			name = "Luffy",
			steam_id = "76561198075720845",
			action = "Helped with LUA stuff when I needed.\nHe also made the HUD scaling options."
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
			name = "AldoRaine\ngabsF",
			steam_id = "76561198152040762",
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
		},
		[16] = {
			name = "FR0Z3",
			steam_id = "76561198058215284",
			action = "Made the Simplified Chinese localization"
		},
		[17] = {
			name = "VladTheH",
			steam_id = "76561198149442981",
			action = "Made the Polish localization"
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
		"NepgearsyHUDReborn/Fonts/Eurostile",
		"NepgearsyHUDReborn/Fonts/PDTH"
	}

	self.PlayerNameFonts = {
		"NepgearsyHUDReborn/Fonts/Eurostile",
		"NepgearsyHUDReborn/Fonts/Normal",
		"NepgearsyHUDReborn/Fonts/PDTH"
	}

	self.InteractionFonts = deep_clone(self.PlayerNameFonts)

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
	self.InteractionColor = deep_clone(self.StarringColors)

	self.HealthStyle = {
		"NepgearsyHUDReborn/HealthStyle/Thin",
		"NepgearsyHUDReborn/HealthStyle/Vanilla"
	}

	self.StatusNumberType = {
		"NepgearsyHUDReborn/StatusNumberType/Health_Counter",
		"NepgearsyHUDReborn/StatusNumberType/Shield_Counter",
		"NepgearsyHUDReborn/StatusNumberType/HealthShieldCombined",
		"NepgearsyHUDReborn/StatusNumberType/None"
	}

	self.TeammateSkinsCollectionLegacy = {
		"default",
		"community",
		"pd2",
		"suguri",
		"hdn",
		"plush",
		"persona",
		"kiniro",
		"other"
	}

	self.TeammateSkinsCollection = {
		default = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/DefaultHeader",
		pd2 = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/Pd2Header",
		community = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/CommunityHeader",
		hdn = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/HDNHeader",
		suguri = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/SuguriHeader",
		plush = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PlushHeader",
		persona = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PersonaHeader",
		kiniro = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/KiniroHeader",
		other = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/OtherHeader"
	}

	self.TeammateSkins = {
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
	}

	self.TeammatePanelStyles = {
		"nepgearsy_hud_reborn_default",
		"nepgearsy_hud_reborn_sora_wide",
		"nepgearsy_hud_reborn_none"
	}

	self.DiscordRichPresenceTypes = {
		"NepgearsyHUDReborn/Discord/DefaultType",
		"NepgearsyHUDReborn/Discord/KillTracker"
	}
end

function NepgearsyHUDReborn:GetTeammateSkinBySave()
	local skin_id = self:GetOption("TeammateSkin")
	local is_wide = self:IsTeammatePanelWide()
	
	if is_wide then
		if self.TeammateSkins[skin_id] then
			if self.TeammateSkins[skin_id].wide_counterpart then
				return self.TeammateSkins[skin_id].wide_counterpart
			else
				return self.TeammateSkins[1].wide_counterpart
			end
		end

		return self.TeammateSkins[1].wide_counterpart
	end

	if self.TeammateSkins[skin_id] then
		return self.TeammateSkins[skin_id].texture
	end

	return self.TeammateSkins[1].texture
end

function NepgearsyHUDReborn:GetTeammateSkinID()
	return self:GetOption("TeammateSkin")
end

function NepgearsyHUDReborn:GetTeammateSkinById(id)
	local is_wide = self:IsTeammatePanelWide()
	
	if is_wide then
		if self.TeammateSkins[tonumber(id)] then
			if self.TeammateSkins[tonumber(id)].wide_counterpart then
				return self.TeammateSkins[tonumber(id)].wide_counterpart
			else
				return self.TeammateSkins[1].wide_counterpart
			end
		end

		return self.TeammateSkins[1].wide_counterpart
	end

	if self.TeammateSkins[tonumber(id)] then
		return self.TeammateSkins[tonumber(id)].texture
	end

	return self.TeammateSkins[1].texture
end

function NepgearsyHUDReborn:HasSteamAvatarsEnabled()
	return self:GetOption("EnableSteamAvatars")
end

function NepgearsyHUDReborn:GetInteractionColorBySave()
	local saved_id = self:GetOption("InteractionColor")

	return self:StringToColor("interaction_color", saved_id)
end

function NepgearsyHUDReborn:GetTeammateStyleBySave()
	local saved_id = self:GetOption("TeammatePanelStyle")
	return self.TeammatePanelStyles[saved_id]
end

function NepgearsyHUDReborn:IsTeammatePanelWide()
	if self:GetTeammateStyleBySave() == "nepgearsy_hud_reborn_sora_wide" then
		return true
	end

	return false
end

function NepgearsyHUDReborn:HasInteractionEnabled()
	return self:GetOption("EnableInteraction")
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
	stc["cpcolor"][1] = Color.black

	stc["cpbordercolor"] = deep_clone(stc["starring"])
	stc["objective_color"] = deep_clone(stc["starring"])
	stc["interaction_color"] = deep_clone(stc["starring"])

	stc["numeral_status_color"] = {}
	stc["numeral_status_color"][1] = Color("ffffff")
	stc["numeral_status_color"][2] = Color("2dc43c")
	stc["numeral_status_color"][3] = Color("d8022d")
	stc["numeral_status_color"][4] = Color("ff6e00")
	stc["numeral_status_color"][5] = Color("ffe100")
	stc["numeral_status_color"][6] = Color("06ddda")
	stc["numeral_status_color"][7] = Color("068edd")
	stc["numeral_status_color"][8] = Color("2149ff")
	stc["numeral_status_color"][9] = Color("b014ff")
	stc["numeral_status_color"][10] = Color("fcc9ff")
	stc["numeral_status_color"][11] = Color("f000ff")
	stc["numeral_status_color"][12] = Color("ff0090")

	return stc[module][id]
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
		},
		[10] = {
			localized_name = "NepgearsyHUDReborn/Localization/SimplifiedChinese",
			path = "chinese.txt"
		},
		[11] = {
			localized_name = "NepgearsyHUDReborn/Localization/Polish",
			path = "polish.txt"
		}
	}

	for i, localization in ipairs(self.Localization) do
		table.insert(self.LocalizationTable, localization.localized_name)
	end
end

function NepgearsyHUDReborn:InitDiscord()
	if not self:GetOption("UseDiscordRichPresence") then
		self:Log("User disabled Custom Rich Presence, skip")
		return
	end

	if not self.DiscordInitialized then
		self:Log("Setting up Custom Discord Rich Presence")

		local player_level = managers.experience:current_level()
		local player_rank = managers.experience:current_rank()
		local is_infamous = player_rank > 0
		local level_string = player_level > 0 and ", " .. (is_infamous and managers.experience:rank_string(player_rank) .. "-" or "") .. tostring(player_level) or ""
		
		Discord:set_large_image("payday2_icon", "PAYDAY 2")
		Discord:set_small_image("sora_hud", "Sora's HUD Reborn " .. self.Version)
		
		if self:GetOption("DRPAllowTimeElapsed") then
			Discord:set_start_time_relative(0)
		else
			Discord:set_start_time(0)
		end

		self.DiscordInitialized = true
	end
end

function NepgearsyHUDReborn:SetDiscordPresence(title, desc, allow_time_relative, reset, reset_image)
	if not self:GetOption("UseDiscordRichPresence") then
		return
	end

	if not self.HasDiscordCustomStatus then
		Discord:set_status(tostring(desc), tostring(title))
	else
		Discord:set_status(tostring(self:GetOption("DiscordRichPresenceCustom")), "")
	end

	if reset and allow_time_relative and self:GetOption("DRPAllowTimeElapsed") then
		Discord:set_start_time_relative(0)
	else
		Discord:set_start_time(0)
	end

	if reset_image then
		--Discord:set_large_image("payday2_icon", "PAYDAY 2")
	end
end

function NepgearsyHUDReborn:SetLargeImage(key, text)
	Discord:set_large_image(key, text)
end

function NepgearsyHUDReborn:IsKillTrackerPresence()
	return self:GetOption("DiscordRichPresenceType") == 2
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
	MenuCallbackHandler.NepgearsyHUDRebornMenu = ClassClbk(NepHudMenu, "SetEnabled", true)
    MenuHelperPlus:AddButton({
        id = "NepgearsyHUDRebornMenu",
        title = "NepgearsyHUDRebornMenu",
        node_name = "blt_options",
        callback = "NepgearsyHUDRebornMenu"
    })
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

if Hooks then
	Hooks:Add("MenuManagerPopulateCustomMenus", "InitNepHudMenu", callback(NepgearsyHUDReborn, NepgearsyHUDReborn, "InitMenu"))

	Hooks:Add("LocalizationManagerPostInit", "PostInitLocalizationNepHud", function(loc)
		loc:load_localization_file( NepgearsyHUDReborn:GetForcedLocalization() )
	end)

	Hooks:Add("SetupInitManagers", "PostInitManager_ExecutionDiscord", function()
		NepgearsyHUDReborn:InitDiscord()
	end)
end
