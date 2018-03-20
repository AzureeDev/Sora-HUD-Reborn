if RequiredScript == "lib/managers/hudmanagerpd2" then

    HUDMiniMap = HUDMiniMap or class()
    HUDMiniMap.DEFAULT_RADIUS = 2500    --Map unit "radius" from player
    HUDMiniMap.SHOW_BLANK_MAP = false
    
    HUDMiniMap.DEBUG = false    --Debug/map-making stuff
    
    HUDMiniMap._INDEX = {
        framing_frame_1 = { --Framing Frame day 1 / Art Gallery
            {
                x = { -2700, 6300 },
                y = { -5300, 3700 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*3, 1024*2, 1024, 1024 },
            },
            bounding_boxes = {
                {   --Interior lobby
                    y = { min = -785, max = 795 },
                    x = { min = 1150, max = 2395 },
                    z = { max = 450 },
                    map_index = 1,
                    local_scale = 1.5,
                },
                {   --Interior
                    y = { min = -2460, max = 2435 },
                    x = { max = 1580 },
                    z = { max = 450 },
                    map_index = 1,
                    local_scale = 1.5,
                },
                {   --Exterior/Roof
                    map_index = 1,
                }
            },
            elevations = {
                [1] = { max = 450 },
                [2] = { min = 450 },
            },
        },
        framing_frame_3 = { --Framing Frame day 3
            global_scale = 1.5,
            {   --Lower floor
                x = { -6600, -1400 },
                y = { 600, 5800 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/framing_frame_3_1",
            },
            {   --Upper floor
                x = { -6600, -1400 },
                y = { 700, 5900 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/framing_frame_3_2",
            },
            {   --Roof
                x = { -7325, -1325 },
                y = { 625, 6625 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/framing_frame_3_3",
            },
            bounding_boxes = {
                {   --Lower floor
                    z = { max = 3200 },
                    map_index = 1,
                },
                {   --Upper floor
                    z = { min = 3200, max = 3650 },
                    map_index = 2,
                },
                {   --Roof
                    z = { min = 3650 },
                    map_index = 3,
                },
            },
            elevations = {
                [1] = { max = 3362 },
                [2] = { min = 3362, max = 3750 },
                [3] = { min = 3750, max = 4100 },
                [4] = { min = 4100 },
            },
        },
        mia_1 = {   --Hotline Miami day 1
            {   --Basement
                x = { -5524, 7476 },
                y = { -5358, 1142 },
                size = { 2048, 1024 },
                --texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                --texture_rect = { 1024*0, 1024*3, 2048, 1024 },
                
                composite = true,
                relevant_units = { 100944, 100942, 100943, 100288, 102846, 102843, 102842, 100418, 102847, 100417 },
                {   --Main basement area
                    size = { 2048, 1024 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 1024*0, 1024*3, 2048, 1024 },
                    is_visible = true,
                },
                {   --West wall
                    size = { 40, 68 },
                    position = { 1252, 607 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2129, 2196, 40, 68 },
                    required_units = { 100944 },
                },
                {   --South wall
                    size = { 69, 40 },
                    position = { 1419, 741 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2235, 2251, 69, 40 },
                    required_units = { 100942 },
                },
                {   --South east wall
                    size = { 51, 66 },
                    position = { 1547, 671 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2285, 2130, 51, 66 },
                    required_units = { 100943 },
                },
                {   --North east wall
                    size = { 40, 71 },
                    position = { 1552, 544 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2200, 2137, 40, 71 },
                    required_units = { 100288 },
                },
                {   --Path #1 (106 -> west wall)
                    size = { 276, 400 },
                    position = { 1040, 570 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2049, 2671, 276, 400 },
                    required_units = { 100942, 100943, 100288, 102846 },
                },
                {   --Path #2 (105 -> west wall)
                    size = { 276, 400 },
                    position = { 1094, 570 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2308, 2671, 276, 400 },
                    required_units = { 100942, 100943, 100288, 102847 },
                },
                {   --Path #3 (105 -> south wall)
                    size = { 326, 282 },
                    position = { 1205, 711 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2593, 2788, 326, 282 },
                    required_units = { 100944, 100943, 100288, 102842 },
                },
                {   --Path #4 (104 -> south wall)
                    size = { 326, 282 },
                    position = { 1274, 707 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2049, 2385, 326, 282 },
                    required_units = { 100944, 100943, 100288, 102843 },
                },
                {   --Path #5 (103 -> south east wall)
                    size = { 358, 368 },
                    position = { 1506, 624 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2392, 2294, 358, 368 },
                    required_units = { 100944, 100942, 100288, 100418 },
                },
                {   --Path #6 (102 -> north east wall)
                    size = { 320, 298 },
                    position = { 1541, 405 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2747, 2509, 320, 298 },
                    required_units = { 100944, 100942, 100943, 100418 },
                },
                {   --Path #7 (102 -> south east wall)
                    size = { 302, 256 },
                    position = { 1544, 548 },
                    texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                    texture_rect = { 2753, 2065, 302, 256 },
                    required_units = { 100288, 100942, 100944, 100417 },
                },
            },
            {   --Ground floor
                x = { -5524, 7476 },
                y = { -5358, 1142 },
                size = { 2048, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*2, 1024*3, 2048, 1024 },
            },
            {   --Upper floor
                x = { -5524, 7476 },
                y = { -5358, 1142 },
                size = { 2048, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*0, 1024*2, 2048, 1024 },
            },
            bounding_boxes = {
                {   --Basement
                    z = { max = -200 },
                    map_index = 1,
                    local_scale = 1.35,
                },
                {   --Ground floor
                    z = { min = -200, max = 350 },
                    map_index = 2,
                },
                {   --Upper floor
                    z = { min = 350 },
                    map_index = 3,
                },
            },
            elevations = {
                [1] = { max = -100 },
                [2] = { min = -100, max = 415 },
                [3] = { min = 415 },
            },
        },
        mia_2 = {   --Hotline Miami day 2
            global_scale = 1.4,
            {   --Ground floor
                x = { -3050, 3850 },
                y = { -3275, 3625 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/hlm2_01",
            },
            {   --1st floor
                x = { -3050, 3850 },
                y = { -3275, 3625 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/hlm2_02",
            },
            {   --2nd floor
                x = { -3050, 3850 },
                y = { -3275, 3625 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/hlm2_03",
            },
            {   --3rd floor
                x = { -3050, 3850 },
                y = { -3275, 3625 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/hlm2_04",
            },
            {   --4th floor (penthouse)
                x = { -3050, 3850 },
                y = { -3275, 3625 },
                size = { 1024, 1024 },
                texture = "guis/textures/pd2/pre_planning/hlm2_05",
            },
            bounding_boxes = {
                {   --Ground floor
                    z = { max = 200 },
                    map_index = 1,
                },
                {   --1st floor
                    z = { min = 200, max = 600 },
                    map_index = 2,
                },
                {   --2nd floor
                    z = { min = 600, max = 1000 },
                    map_index = 3,
                },
                {   --3nd floor
                    z = { min = 1000, max = 1400 },
                    map_index = 4,
                },
                {   --4th floor (penthouse)
                    z = { min = 1400 },
                    map_index = 5,
                },
            },
            elevations = {
                [1] = { max = 350 },
                [2] = { min = 350, max = 750 },
                [3] = { min = 750, max = 1150 },
                [4] = { min = 1150, max = 1550 },
                [5] = { min = 1500, max = 1950 },
                [6] = { min = 1950 },
            },
        },
        branchbank = {  --Branch Bank / Firestarter day 3
            {
                x = { -5500, 2500 },
                y = { -3200, 4800 },
                size = { 1024, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*3, 1024*1, 1024, 1024 },
            },
            bounding_boxes = {
                {   --Office area
                    x = { min = -2780, max = -10 },
                    y = { min = 810, max = 2700 },
                    z = { max = 185 },
                    map_index = 1,
                    local_scale = 2,
                },
                {   --Vault area
                    x = { min = -3150, max = -10 },
                    y = { min = 1200, max = 2800 },
                    z = { max = 185 },
                    map_index = 1,
                    local_scale = 2,
                },
                {   --Lobby area
                    x = { min = -2780, max = -1210 },
                    y = { min = 30, max = 810 },
                    z = { max = 185 },
                    map_index = 1,
                    local_scale = 2,
                },
                {   --Manager office
                    x = { min = -600, max = -10 },
                    y = { min = 2400, max = 3000 },
                    z = { max = 185 },
                    map_index = 1,
                    local_scale = 2,
                },
                {   --North staircase area
                    x = { min = -1500, max = -800 },
                    y = { min = 2600, max = 3400 },
                    map_index = 1,
                    local_scale = 2,
                },
                {   --Exterior/roof
                    map_index = 1,
                },
            },
            elevations = {
                [1] = { max = 350 },
                [2] = { min = 350 },
            },

        },
        kosugi = {  --Shadow Raid
            {   --Sewers
                x = { -5650, 6850 },
                y = { -7850, 4650 },
                size = { 1024, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*1, 1024*0, 1024, 1024 },
            },
            {   --Docks/Basement
                x = { -5650, 6850 },
                y = { -7850, 4650 },
                size = { 1024, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*2, 1024*0, 1024, 1024 },
            },
            {   --Ground floor
                x = { -5650, 6850 },
                y = { -7850, 4650 },
                size = { 1024, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*3, 1024*0, 1024, 1024 },
            },
            {   --Second floor
                x = { -5650, 6850 },
                y = { -7850, 4650 },
                size = { 1024, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*1, 1024*1, 1024, 1024 },
            },
            {   --Roof
                x = { -5650, 6850 },
                y = { -7850, 4650 },
                size = { 1024, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*2, 1024*1, 1024, 1024 },
            },
            bounding_boxes = {
                {   --Sewers
                    z = { max = 500 },
                    map_index = 1,
                    local_scale = 1.5,
                },
                {   --Basement
                    x = { min = -3300, max = 600 },
                    y = { min = -6040, max = -4600 },
                    z = { min = 500, max = 770 },
                    map_index = 2,
                    local_scale = 1.5,
                },
                {   --Docks
                    z = { min = 500, max = 770 },
                    map_index = 2,
                    local_scale = 1,
                },
                {   --Ground floor east maintenance
                    x = { min = 630, max = 1450 },
                    y = { min = -5120, max = -3630 },
                    z = { max = 1300 },
                    map_index = 3,
                    local_scale = 1.5,
                },
                {   --Ground floor warehouse
                    x = { min = -3780, max = 630 },
                    y = { min = -5610, max = -1250 },
                    z = { max = 1300 },
                    map_index = 3,
                    local_scale = 1.5,
                },
                {   --2nd floor warehouse
                    x = { min = -3780, max = 630 },
                    y = { min = -5610, max = -1250 },
                    z = { max = 1750, min = 1300 },
                    map_index = 4,
                    local_scale = 1.5,
                },
                {   --Roof warehouse
                    x = { min = -3780, max = -940 },
                    y = { min = -4860, max = -1990 },
                    z = { min = 1750 },
                    map_index = 5,
                    local_scale = 1.5,
                },
                {   --Ground floor
                    z = { max = 1300 },
                    map_index = 3,
                },
                {   --Second floor
                    z = { max = 1750, min = 1300 },
                    map_index = 4,
                },
                {   --Roof
                    z = { min = 1750 },
                    map_index = 5,
                },
            },
            elevations = {
                [1] = { max = 925 },
                [2] = { min = 925, max = 1324 },
                [3] = { min = 1324, max = 1762 },
                [4] = { min = 1762 },
            },
        },
        mus = { --The Diamond
            {   --Upper floor
                x = { -10000, 10000 },
                y = { -5000, 5000 },
                size = { 2048, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/mus_1",
            },
            {   --Lower floor
                x = { -10000, 10000 },
                y = { -5000, 5000 },
                size = { 2048, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/mus_2",
            },
            {   --Basement
                x = { -10000, 10000 },
                y = { -5000, 5000 },
                size = { 2048, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/mus_3",
            },
            bounding_boxes = {
                {   --Exterior
                    x = { max = -4200 },
                    z = { max = -830 },
                    map_index = 1,
                },
                {   --Lower floor
                    z = { min = -900, max = -500 },
                    x = { max = 1500 },
                    map_index = 2,
                    local_scale = 1.5,
                },
                {   --Basement
                    z = { max = -900 },
                    map_index = 3,
                    local_scale = 1.5,
                },
                {   --Exterior (basement view)
                    x = { min = -4200, max = -1850 },
                    z = { max = -830 },
                    map_index = 3,
                    local_scale = 1.25,
                },
                {   --Upper floor
                    --z = { min = -500 },
                    map_index = 1,
                    local_scale = 1.5,
                },
            },
            elevations = {
                [1] = { max = -850 },
                [2] = { min = -850, max = -400 },
                [3] = { min = -400 },
            },
        },
        big = { --Big Bank
            {   --Lower level
                x = { -5750, 5750 },
                y = { -2875, 2875 },
                size = { 2048, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*0, 1024*4, 2048, 1024 },
            },
            {   --Upper level
                x = { -5750, 5750 },
                y = { -2875, 2875 },
                size = { 2048, 1024 },
                debug_rescale_factor = 2,
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*2, 1024*4, 2048, 1024 },
            },
            {   --Roof
                x = { -250, 5750 },
                y = { -3000, 3000 },
                size = { 2048, 2048 },
                texture = "guis/dlcs/big_bank/textures/pd2/pre_planning/big_roof",
            },
            bounding_boxes = {
                {   --Lower level
                    z = { max = -700 },
                    map_index = 1,
                    local_scale = 1.8,
                },
                {   --Upper level
                    z = { min = -700, max = -300 },
                    map_index = 2,
                    local_scale = 1.8,
                },
                {   --Roof
                    z = { min = -300 },
                    map_index = 3,
                },
            },
            elevations = {
                [1] = { max = -550 },
                [2] = { min = -550, max = -150 },
                [3] = { min = -150, max = 900 },
                [4] = { min = 900 },
            },
        },
        pbr = { --Beneath the Mountain
            {   --Lower level
                x = { -15000, -5000 },
                y = { -7600, 2400 },
                size = { 2048, 2048 },
                texture = "guis/dlcs/berry/textures/pd2/pre_planning/base_01",
            },
            {   --Topside
                x = { -15100, -5100 },
                y = { -8000, 2000 },
                size = { 2048, 2048 },
                texture = "guis/dlcs/berry/textures/pd2/pre_planning/base_02",
            },
            bounding_boxes = {
                {   --Lower level
                    z = { max = 3000 },
                    map_index = 1,
                    local_scale = 0.8,
                },
                {   --Upper level
                    z = { min = 3000 },
                    map_index = 2,
                },
            },
            elevations = {
                [1] = { max = 3000 },
                [2] = { min = 3000 },
            },
        },
        crojob2 = { --The Bomb: Dockyard
            {   --Docks
                x = { -9500, 10500 },
                y = { -8500, 11500 },
                size = { 2048, 2048 },
                texture = "guis/dlcs/the_bomb/textures/pd2/pre_planning/crojob_stage_2_a",
            },
            bounding_boxes = {
                {   --Docks
                    map_index = 1,
                },
            },
            elevations = {
                [1] = { max = 400 },
                [2] = { min = 400, max = 800 },
                [3] = { min = 800 },
            },
        },
        crojob3 = { --The Bomb: Forest
            global_scale = 0.5,
            {   --Area
                x = { -50, 14950 },
                y = { -19225, 10775 },
                size = { 1024, 2048 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 1024*0, 1024*0, 1024, 2048 },
            },
            bounding_boxes = {
                {   --Area
                    map_index = 1,
                },
            },
            elevations = {
                [1] = { },
            },
        },
        kenaz = {   --Golden Grin Casino
            {
                x = { -6175, 5475 },
                y = { -14450, 8350 },
                size = { 1024, 2048 },
                texture = "NepgearsyHUDReborn/Minimap/kenaz_loc_b_df",
            },
            bounding_boxes = {
                {   
                    map_index = 1,
                },
            },
            elevations = {
                [1] = { max = -200 },
                [2] = { min = -200, max = 400 },
                [3] = { min = 400 },
            },

        },
        jewelry_store = {
            global_scale = 1.5,
            {
                x = { -5500, 5500 },
                y = { -4000, 7000 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 4096, 0, 1024, 1024 },
            },
            bounding_boxes = {
                {   
                    map_index = 1,
                },
            },
        },
        firestarter_1 = {   --Firestarter day 1
            {
                global_scale = 0.8,
                x = { -6750, 5250 },
                y = { -3000, 9000 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 4096, 1024, 1024, 1024 },
            },
            bounding_boxes = {
                {   
                    map_index = 1,
                },
            },
        },
        firestarter_2 = {   --Firestarter day 1
            {
                x = { -6000, 6000 },
                y = { -5000, 7000 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 4096, 2048, 1024, 1024 },
            },
            {
                x = { -6000, 6000 },
                y = { -5000, 7000 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 4096, 3072, 1024, 1024 },
            },
            bounding_boxes = {
                {   --Ground floor
                    z = { max = 200 },
                    map_index = 1,
                },
                {   --Upper floor
                    z = { min = 200 },
                    map_index = 2,
                },
            },
        },
        family = {
            global_scale = 1.5,
            {
                x = { -5500, 7500 },
                y = { -6500, 6500 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 4096, 4096, 1024, 1024 },
            },
            bounding_boxes = {
                {   
                    map_index = 1,
                },
            },
        },
        roberts = {
            {
                x = { -5000, 6000 },
                y = { -7000, 4000 },
                size = { 1024, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 5120, 0, 1024, 1024 },
            },
            bounding_boxes = {
                {   
                    map_index = 1,
                },
            },
        }
        --[[
        red2 = {        --First World Bank
            {
                x = { -9000, 11000 },
                y = { -5500, 4500 },
                size = { 2048, 1024 },
                texture = "NepgearsyHUDReborn/Minimap/shadow_raid_5",
                texture_rect = { 0, 0, 0, 0 },
            },
            bounding_boxes = {
                {   
                    map_index = 1,
                },
            },
        },]]
    }
    HUDMiniMap._INDEX.firestarter_3 = deep_clone(HUDMiniMap._INDEX.branchbank)  --Firestarter day 3
    HUDMiniMap._INDEX.gallery = deep_clone(HUDMiniMap._INDEX.framing_frame_1)   --Art Gallery
    HUDMiniMap._INDEX.shoutout_raid = deep_clone(HUDMiniMap._INDEX.kosugi)      --Meltdown
    HUDMiniMap._INDEX.crojob3_night = deep_clone(HUDMiniMap._INDEX.crojob3)     --Bomb: Forest (night variation)
    HUDMiniMap._INDEX.ukrainian_job = deep_clone(HUDMiniMap._INDEX.jewelry_store)   --Ukrainian Job

    HUDMiniMap._MINIMAP_MARKINGS = {
        mark_enemy = { 
            class = "HUDMiniMapEnemyEntity",
        },
        mark_enemy_damage_bonus = { 
            class = "HUDMiniMapEnemyEntity",
        },
        mark_unit = {
            class = "HUDMiniMapCameraEntity",
            ignore_duration = true,
        },
        mark_unit_dangerous = {
            class = "HUDMiniMapSWATTurretEntity",
            duration = 60,
        },
        friendly = {
            class = "HUDMiniMapJokerEntity",
            ignore_duration = true,
            delete_prior = true,
        },
        civies = {
            class = "HUDMiniMapCiviesEntity",
            ignore_duration = true,
        },
        teammate = {
			class = "HUDMiniMapVIPEntity",
			ignore_duration = true,
		},	
        taxman = {
			class = "HUDMiniMapInterestEntity",
			ignore_duration = true,
		},	
		drunk_pilot = {
			class = "HUDMiniMapInterestEntity",
			ignore_duration = true,
		},		
		highlight_character = {
			class = "HUDMiniMapInterestEntity",
			ignore_duration = true,
        }    
    }
    
    function HUDMiniMap:init(parent)
        self._parent = parent
        self._level_data = managers.job:current_level_id() and self._INDEX[managers.job:current_level_id()]
        self._entities = {}
        self._scheduled_delete_entity = {}
        self._maps = {}
        self._current_index = nil
        self._global_scale = self._level_data and self._level_data.global_scale or 1
        self._local_scale = 1
        self._zoom_scale = NepgearsyHUDReborn:GetOption("MinimapZoom")
        self._minimap_enabled = NepgearsyHUDReborn:GetOption("EnableMinimap")

        local hud_assault_corner = managers.hud._hud_assault_corner

        if not self._level_data then
            self._minimap_enabled = HUDMiniMap.SHOW_BLANK_MAP and true or false
            --printf("No level data for level %s\n", tostring(managers.job:current_level_id()))

            if NepgearsyHUDReborn:GetOption("MinimapForce") then
                self._minimap_enabled = true
            end
        end

        local sizes = { NepgearsyHUDReborn:GetOption("MinimapSize"), NepgearsyHUDReborn:GetOption("MinimapSize") }
        
        if not self._minimap_enabled then
            sizes = { 0, 0 }
        end

        if HUDMiniMap.DEBUG then
            self._debug_log_access = false
            self._debug_access_map = {}
        end
        
        self._panel = self._parent:panel({
            name = "map_panel",
            w = sizes[1],
            h = sizes[2],
            visible = self._minimap_enabled and true or false,
            x = 0,
            y = 0
        })

        self:ReplaceHUDElements()

        self._map_bg = self._panel:rect({
            blend_mode = "normal",
            color = Color.black,
            alpha = 0.5,
            h = self._panel:h(),
            w = self._panel:w(),
        })
        
        self._debug_text = self._panel:text({
            name = "debug",
            align = "right",
            vertical = "bottom",
            h = 45,
            w = self._panel:w(),
            font_size = 15,
            font = tweak_data.menu.pd2_small_font,
            text = "",
            color = Color.red,
            blend_mode = "normal",
            layer = 1,
            visible = HUDMiniMap.DEBUG,
        })
        self._debug_text:set_bottom(self._panel:h())
        self._debug_text:set_right(self._panel:w())
        
        for i, data in ipairs(self._level_data or {}) do
            local submap = nil
            
            data.range = {
                data.x[2] - data.x[1],
                data.y[2] - data.y[1]
            }
            data.center = {
                (data.x[1] + data.x[2]) / 2,
                (data.y[1] + data.y[2]) / 2
            }
            local min_window_size = math.min(self._panel:w(), self._panel:h())
            data.inherent_scale = math.min(
                (min_window_size * data.range[1]) / (data.size[1] * HUDMiniMap.DEFAULT_RADIUS * 2),
                (min_window_size * data.range[2]) / (data.size[2] * HUDMiniMap.DEFAULT_RADIUS * 2)
            )
            
            data.debug_units_per_pixel = {
                data.range[1] / data.size[1] * (data.debug_rescale_factor or 1),
                data.range[2] / data.size[2] * (data.debug_rescale_factor or 1)
            }
            
            if data.composite then
                submap = HUDMiniMapCompositeMap:new(self._panel, data)
            else
                submap = self._panel:bitmap({
                    blend_mode = "add",
                    texture = data.texture,
                    texture_rect = data.texture_rect,
                    alpha = 0.5,
                    layer = 1,
                    visible = false,
                })
                
            end
            
            table.insert(self._maps, submap)
            
            if HUDMiniMap.DEBUG then
                table.insert(self._debug_access_map, {})
            end
        end
        self:_rescale_maps()

        self:add_entity(HUDMiniMapPlayerEntity, "player")
    end
    
    function HUDMiniMap:set_enabled(status)
        self._minimap_enabled = status and true or false
        self._panel:set_visible(self._minimap_enabled)
    end
    
    function HUDMiniMap:enabled()
        return self._minimap_enabled
    end
    
    function HUDMiniMap:panel()
        return self._panel
    end
    
    function HUDMiniMap:add_entity(class, key, ...)
        local key = tostring(key)
        if not self._entities[key] then
            if type(class) == "string" then
                class = _G[class]
            end
            
            self._entities[key] = class:new(self, key, ...)
        end
        
        return self._entities[key]
    end
    
    function HUDMiniMap:get_entity(key)
        return self._entities[tostring(key)]
    end
    
    function HUDMiniMap:schedule_delete_entity(key)
        table.insert(self._scheduled_delete_entity, key)
    end
    
    function HUDMiniMap:delete_entity(key)
        local key = tostring(key)
        if self._entities[key] then
            self._entities[key]:destroy()
            self._entities[key] = nil
        end
    end

    function HUDMiniMap:entity_event(key, ...)
        if self._entities[key] then
            self._entities[key]:event(...)
        end
    end
    
    function HUDMiniMap:set_entity_enabled(key, status)
        if self._entities[key] then
            self._entities[key]:set_enabled(status)
        end
    end
    
    function HUDMiniMap:update(t, dt)
        if not self._minimap_enabled then return end
    
        if not managers.viewport:get_current_camera() or not alive(self._panel) then return end
        
        self._vp_pos = managers.viewport:get_current_camera_position()
        
        if HUDMiniMap.DEBUG then
            self._debug_text:set_text(string.format("World: X %6.0f Y %6.0f Z %5.0f", 
                self._vp_pos[1], 
                self._vp_pos[2], 
                self._vp_pos[3])
            )
        end
        
        if self._level_data then
            local new_local_scale
            local last_index = self._current_index
            self._current_index = nil
            
            for i, box in ipairs(self._level_data.bounding_boxes) do
                local max_x = box.x and box.x.max
                local min_x = box.x and box.x.min
                local max_y = box.y and box.y.max
                local min_y = box.y and box.y.min
                local max_z = box.z and box.z.max
                local min_z = box.z and box.z.min
                local x_ok = (not min_x or (self._vp_pos[1] > min_x)) and (not max_x or (self._vp_pos[1] <= max_x))
                local y_ok = (not min_y or (self._vp_pos[2] > min_y)) and (not max_y or (self._vp_pos[2] <= max_y))
                local z_ok = (not min_z or (self._vp_pos[3] > min_z)) and (not max_z or (self._vp_pos[3] <= max_z))
                
                if x_ok and y_ok and z_ok then
                    if self._last_box ~= i then
                        --printf("Switching bounding box %s -> %s\n", tostring(self._last_box), tostring(i))
                        new_local_scale = box.local_scale or 1
                        self._last_box = i
                    end
                    self._current_index = box.map_index
                    break
                end
            end
            
            if self._current_index ~= last_index then
                --printf("Switching map %s -> %s\n", tostring(last_index), tostring(self._current_index))
                if last_index then
                    self._maps[last_index]:hide()
                end
                if self._current_index then
                    self._maps[self._current_index]:show()
                end
            end
            
            if new_local_scale then
                self:_change_scale(new_local_scale)
            end
        
            if self._current_index then
                if HUDMiniMap.DEBUG then
                    local data = self._level_data[self._current_index]
                    local x_ratio = (self._vp_pos[1] - data.x[1]) / data.range[1]
                    local y_ratio = 1 - (self._vp_pos[2] - data.y[1]) / data.range[2]
                    local px = math.round(x_ratio * data.size[1] * (data.debug_rescale_factor or 1))
                    local py = math.round(y_ratio * data.size[2] * (data.debug_rescale_factor or 1))

                    self._debug_text:set_text(string.format("%s\nTexture: X %6.0f Y %6.0f", self._debug_text:text(), px, py))
                    if self._debug_log_access then
                        local X_PIXEL_RANGE = math.max(math.round(31/data.debug_units_per_pixel[1]), 1)
                        local Y_PIXEL_RANGE = math.max(math.round(31/data.debug_units_per_pixel[2]), 1)
                        self._debug_access_map[self._current_index] = self._debug_access_map[self._current_index] or {}
                        
                        --for i = -X_PIXEL_RANGE, X_PIXEL_RANGE, 1 do
                        for i = -1, 1, 1 do
                            self._debug_access_map[self._current_index][px+i] = self._debug_access_map[self._current_index][px+i] or {}
                            
                            --for j = -Y_PIXEL_RANGE, Y_PIXEL_RANGE, 1 do
                            for j = -1, 1, 1 do
                                self._debug_access_map[self._current_index][px+i][py+j] = true
                            end
                        end
                        
                        self._debug_text:set_text(string.format("%s\nLogging positions", self._debug_text:text()))
                    end
                end
            
                self:_center_map()
            end
            
            for i, elevation in ipairs(self._level_data.elevations or {}) do
                local max_z = elevation.max
                local min_z = elevation.min
                
                if (not min_z or (self._vp_pos[3] > min_z)) and (not max_z or (self._vp_pos[3] <= max_z)) then
                    self._current_elevation_index = i
                    break
                end
            end
        else
            self:_calculate_map_bounds(self._vp_pos)
        end
        
        self:_update_entities(t, dt)
    end
    
    function HUDMiniMap:_calculate_map_bounds()
        local aspect_ratio = self._panel:w() / self._panel:h()
        local range_x = self._current_range * ((aspect_ratio > 1) and (aspect_ratio) or 1)
        local range_y = self._current_range * ((aspect_ratio < 1) and (1/aspect_ratio) or 1)
        
        self._current_map_bounds = {
            self._vp_pos[1] - range_x,
            self._vp_pos[1] + range_x,
            self._vp_pos[2] - range_y,
            self._vp_pos[2] + range_y
        }
    end
    
    function HUDMiniMap:_update_entities(t, dt)
        for key, entity in pairs(self._entities) do
            entity:update(t, dt, self._current_map_bounds, self._current_elevation_index, self._level_data and self._level_data.elevations)
        end
        
        for _, key in ipairs(self._scheduled_delete_entity) do
            self:delete_entity(key)
        end
        self._scheduled_delete_entity = {}
    end
    
    function HUDMiniMap:_change_scale(new_scale, instant)
        local old_scale = self._local_scale
        self._panel:stop()
        
        if new_scale ~= old_scale then
            if instant then
                self._local_scale = new_scale
                self:_rescale_maps()
            else
                self._panel:animate(callback(self, self, "_animate_rescale"), old_scale, new_scale)
            end
        end
    end

    function HUDMiniMap:_animate_rescale(o, old_scale, new_scale)
        local T = 0.5
        local t = T
        local diff = new_scale - old_scale
        
        repeat
            t = math.max(0, t - coroutine.yield())
            self._local_scale = old_scale + (1-t/T) * diff
            self:_rescale_maps()
        until t <= 0
    end
    
    function HUDMiniMap:_center_map()
        local map = self._maps[self._current_index]
        local data = self._level_data[self._current_index]

        local distance_x = (data.center[1] - self._vp_pos[1]) / data.range[1]
        local distance_y = (data.center[2] - self._vp_pos[2]) / data.range[2]
        local x = self._panel:w() / 2 + distance_x * map:w()
        local y = self._panel:h() / 2 - distance_y * map:h()
        
        self:_calculate_map_bounds()
        
        map:set_center(x, y)
    end
    
    function HUDMiniMap:_rescale_maps()
        for i, map in ipairs(self._maps) do
            local data = self._level_data[i]
            local scale = data.inherent_scale * self._global_scale * self._local_scale * self._zoom_scale
    
            if map.is_composite then
                map:set_scale(scale)
            else
                map:set_size(data.size[1] * scale, data.size[2] * scale)
            end
        end
        
        self._current_range = HUDMiniMap.DEFAULT_RADIUS / (self._global_scale * self._local_scale * self._zoom_scale)
        
        if self._current_index then
            self:_center_map()
        end
    end
    
    function HUDMiniMap:debug_print_access_maps()
        for i, _ in ipairs(self._maps) do
            local file = io.open("map_" .. tostring(i) .. ".txt", "w")
            local data = self._level_data[i]
            local map = self._debug_access_map[i]
            
            if file and map then
                for y = 0, data.size[2] * (data.debug_rescale_factor or 1) - 1, 1 do
                    for x = 0, data.size[1] * (data.debug_rescale_factor or 1) - 1, 1 do
                        file:write(map[x] and map[x][y] and "1" or "0")
                    end
                    file:write("\n")
                end
                
                file:close()
            end
        end
    end
    
    function HUDMiniMap:debug_log_access(status)
        self._debug_log_access = status
    end

    function HUDMiniMap:ReplaceHUDElements()
        --local hudobjectives = managers.hud._hud_objectives
        --local hudheisttimer = managers.hud._hud_heist_timer

       -- hudobjectives._hud_panel:child("objectives_panel"):set_left(self._panel:right() + 10)
        --hudheisttimer._heist_timer_panel:set_top(self._panel:bottom() + 5)
    end
    
    
    HUDMiniMapCompositeMap = HUDMiniMapCompositeMap or class()
    
    function HUDMiniMapCompositeMap:init(parent_map, map_data)
        self.is_composite = true
        self._parent = parent_map
        self._map_data = map_data
        self._size = { map_data.size[1], map_data.size[2] }
        
        self._panel = self._parent:panel({
            alpha = 0.5,
            layer = 1,
            visible = false,
        })
        
        for i, component_data in ipairs(map_data) do
            local submap = self._panel:bitmap({
                name = "submap_" .. i,
                blend_mode = "add",
                texture = component_data.texture,
                texture_rect = component_data.texture_rect,
                layer = 1,
                visible = false,
            })
        end
    end
    
    function HUDMiniMapCompositeMap:w()
        return self._panel:w()
    end
    
    function HUDMiniMapCompositeMap:h()
        return self._panel:h()
    end
    
    function HUDMiniMapCompositeMap:hide()
        self._panel:hide()
    end
    
    function HUDMiniMapCompositeMap:show()
        self._panel:show()
        
        if not self._map_data.unit_lookup then
            self._map_data.unit_lookup = {}
            
            for _, unit in pairs(World:find_units_quick("all", 1, 11)) do
                local id = unit:editor_id()
                if table.contains(self._map_data.relevant_units, id) then
                    self._map_data.unit_lookup[id] = true
                end
            end
        end
        
        for i, component_data in ipairs(self._map_data) do
            if component_data.is_visible == nil then
                local required_units_ok = true
            
                if component_data.required_units then
                    for _, id in ipairs(component_data.required_units) do
                        if not self._map_data.unit_lookup[id] then
                            required_units_ok = false
                            break
                        end
                    end
                end
                
                component_data.is_visible = required_units_ok
            end
            
            if component_data.is_visible then
                self._panel:child("submap_" .. i):show()
            end
        end
    end
    
    function HUDMiniMapCompositeMap:set_scale(scale)
        self._panel:set_size(self._size[1] * scale, self._size[2] * scale)
    
        for i, component_data in ipairs(self._map_data) do
            self._panel:child("submap_" .. i):set_size(component_data.size[1] * scale, component_data.size[2] * scale)
        end
        
        for i, component_data in ipairs(self._map_data) do
            self._panel:child("submap_" .. i):set_position(
                self._panel:w() * (component_data.position and component_data.position[1] or 0) / self._size[1], 
                self._panel:h() * (component_data.position and component_data.position[2] or 0) / self._size[2]
            )
        end
    end
    
    function HUDMiniMapCompositeMap:set_center(x, y)
        self._panel:set_center(x, y)
    end
    
    
    
    
    
    
    
    HUDMiniMapEntity = HUDMiniMapEntity or class()
    
    function HUDMiniMapEntity:init(parent, key, params)
        params = params or {}
        self._parent = parent
        self._key = key
        self._world_position = params.position
        
        self._panel = self._parent:panel():panel({
            visible = params.visible or true,
            alpha = params.alpha or 1,
            w = params.w or 10,
            h = params.h or 10,
        })
        
        self._elevation_indicator = self._panel:text({
            name = "elevation_indicator",
            align = "right",
            vertical = "top",
            h = self._panel:h() * 0.75,
            w = self._panel:w(),
            font_size = self._panel:h() * 0.75,
            font = tweak_data.menu.pd2_small_font,
            color = Color.white,
            blend_mode = "normal",
            layer = 1,
        })
        
        self._show_elevation_difference = true
        self._same_elevation_only = params.same_elevation_only
        self._visible = self._panel:visible()
        self._enabled = true
    end
    
    function HUDMiniMapEntity:destroy()
        if alive(self._parent:panel()) then
            self._parent:panel():remove(self._panel)
        end
    end

    function HUDMiniMapEntity:update(t, dt, map_bounds, player_elevation_index, elevation_data)
        if self._duration then
            self._duration = self._duration - dt
            
            if self._duration <= 0 then
                self:_delete()
                return
            end
        end
        
        if not self._world_position then return end
    
        local is_visible = true
        local in_range = true
        
        if self._world_position[1] < map_bounds[1] or 
            self._world_position[1] > map_bounds[2] or 
            self._world_position[2] < map_bounds[3] or 
            self._world_position[2] > map_bounds[4] then
            
            is_visible = self._show_offscreen or false
            in_range = false
        end
        
        if player_elevation_index and is_visible and (self._show_elevation_difference or self._same_elevation_only) then
            local elevation_index = nil
            
            for i, elevation in ipairs(elevation_data or {}) do
                local max_z = elevation.max
                local min_z = elevation.min
                
                if (not min_z or (self._world_position[3] > min_z)) and (not max_z or (self._world_position[3] <= max_z)) then
                    elevation_index = i
                    break
                end
            end
            
            if elevation_index ~= player_elevation_index then
                if self._same_elevation_only then
                    is_visible = false
                end
            end
            
            if self._show_elevation_difference then
                local diff = player_elevation_index - elevation_index
                
                if self._current_elevation_difference ~= diff then
                    self._current_elevation_difference = diff
                    is_visible = is_visible and self:_set_elevation_difference(diff)
                end
            end
        end
        
        if is_visible then
            self._panel:set_alpha((in_range and 1 or 0.85) * (self._reduced_elevation_alpha and 0.85 or 1))
            
            local xr = (self._world_position[1] - map_bounds[1]) / (map_bounds[2] - map_bounds[1])
            local yr = 1 - (self._world_position[2] - map_bounds[3]) / (map_bounds[4] - map_bounds[3])
            xr = math.clamp(xr, 0.01, 0.99)
            yr = math.clamp(yr, 0.01, 0.99)
            self._panel:set_center(xr * self._parent:panel():w(), yr * self._parent:panel():h())
        end
        
        self._visible = is_visible
        self._panel:set_visible(self._visible and self._enabled)
    end
    
    function HUDMiniMapEntity:event(...)
        printf("ERROR: Base class event call (forgot to implement one for the subclass?)\n")
    end
    
    function HUDMiniMapEntity:set_duration(duration)
        self._duration = duration
    end
    
    function HUDMiniMapEntity:_delete()
        if not self._deleted then
            self._parent:schedule_delete_entity(self._key)
            if alive(self._panel) then
                self._panel:hide()
            end
            
            self._deleted = true
        end
    end
    
    function HUDMiniMapEntity:set_enabled(status)
        self._enabled = status
        self._panel:set_visible(self._visible and self._enabled)
    end
    
    function HUDMiniMapEntity:_set_elevation_difference(diff)
        if not self._max_elevation_difference or (math.abs(diff) > self._max_elevation_difference) then
            self._reduced_elevation_alpha = diff ~= 0
            self._elevation_indicator:set_text((diff < 0) and "+" or (diff > 0) and "-" or "")
            return true
        end
        
        return false
    end
    
    
    HUDMiniMapPlayerEntity = HUDMiniMapPlayerEntity or class(HUDMiniMapEntity)
    
    function HUDMiniMapPlayerEntity:init(parent, key)
        HUDMiniMapUnitEntity.super.init(self, parent, key, { w = 12, h = 12 })
        
        self._avatar = self._panel:text({
            name = "avatar",
            align = "center",
            vertical = "center",
            h = self._panel:h(),
            w = self._panel:w(),
            font_size = self._panel:h(),
            font = tweak_data.menu.pd2_small_font,
            text = "V",
            color = Color.green,
            blend_mode = "normal",
            layer = 1,
        })
        --[[
        HUDMiniMapUnitEntity.super.init(self, parent, key, { w = 3, h = 3 })
        
        self._avatar = self._panel:rect({
            name = "avatar",
            blend_mode = "normal",
            color = Color.green,
            h = self._panel:h(),
            w = self._panel:w(),
        })
        ]]
        
        self._panel:set_center(self._parent:panel():w() / 2, self._parent:panel():h() / 2)
    end
    
    function HUDMiniMapPlayerEntity:update(...)
        if managers.viewport:get_current_camera() then
            self._avatar:set_rotation(-managers.viewport:get_current_camera_rotation():yaw() + 180)
        end
    end
    
    
    
    HUDMiniMapWaypointEntity = HUDMiniMapWaypointEntity or class(HUDMiniMapEntity)
    
    function HUDMiniMapWaypointEntity:init(parent, key, data)
        HUDMiniMapWaypointEntity.super.init(self, parent, key, { w = 10, h = 10, same_elevation_only = data.same_elevation_only })
        
        local texture, texture_rect
        if data.icon then
            texture, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
        else
            texture = data.texture
            texture_rect = data.texture_rect
        end
        
        self._icon = self._panel:bitmap({
            name = "icon",
            blend_mode = "add",
            texture = texture,
            texture_rect = texture_rect,
            layer = 1,
            w = self._panel:w(),
            h = self._panel:h(),
            color = data.color or Color.white,
        })
        self._elevation_indicator:set_color(data.color or Color.white)
        
        self._show_offscreen = data.show_offscreen
        self._world_position = data.position
        self._unit = data.unit
    end
    
    function HUDMiniMapWaypointEntity:update(...)
        if alive(self._unit) then
            self._world_position = self._unit:position()
        end
        
        HUDMiniMapWaypointEntity.super.update(self, ...)
    end
    
    
    HUDMiniMapUnitEntity = HUDMiniMapUnitEntity or class(HUDMiniMapEntity)
    
    function HUDMiniMapUnitEntity:init(parent, key, unit, size)
        HUDMiniMapUnitEntity.super.init(self, parent, key, { w = size or 10, h = size or 10 })
        
        self._avatar = self._panel:text({
            name = "avatar",
            align = "center",
            vertical = "center",
            text = "X",
            font = tweak_data.menu.pd2_small_font,
            w = self._panel:w(),
            h = self._panel:h(),
            font_size = self._panel:h(),
            color = Color.red,
            blend_mode = "normal",
            layer = 1,
        })
        
        self._unit = unit
    end
    
    function HUDMiniMapUnitEntity:update(...)
        if not alive(self._unit) then
            self:_delete()
            return
        end
        
        self._world_position = self._unit:position()
        
        HUDMiniMapUnitEntity.super.update(self, ...)
    end
    
    
    
    HUDMiniMapTeamEntity = HUDMiniMapTeamEntity or class(HUDMiniMapUnitEntity)
    
    HUDMiniMapTeamEntity.STATE_ICONS = {
        tased = { texture = "guis/textures/pd2/pd2_waypoints", texture_rect = { 0, 32, 32, 32 } },
    }
    for i, state in ipairs({ "fatal", "bleed_out", "incapacitated", "arrested"}) do
        HUDMiniMapTeamEntity.STATE_ICONS[state] = { texture = "guis/textures/hud_icons", texture_rect = { 464, 64, 32, 32 } }
    end
    
    function HUDMiniMapTeamEntity:init(parent, key, unit, peer_id)
        HUDMiniMapTeamEntity.super.init(self, parent, key, unit, 12)
        
        local color = tweak_data.chat_colors[peer_id or 5]
        
        self._state_icon = self._panel:bitmap({
            blend_mode = "normal",
            w = self._panel:w(),
            h = self._panel:h(),
            layer = 1,
            visible = false,
            color = color,
        })
        
        self._avatar:set_color(color)
        self._elevation_indicator:set_color(color)
        self._avatar:set_text("v")
        self._show_offscreen = true
    end
    
    function HUDMiniMapTeamEntity:update(...)
        HUDMiniMapTeamEntity.super.update(self, ...)
    
        if not self._deleted then
            self._state_icon:set_center(self._avatar:center())
            self._avatar:set_rotation(-self._unit:rotation():yaw() + 180)
        end
    end
    
    function HUDMiniMapTeamEntity:event(new_state)
        local state_icon = HUDMiniMapTeamEntity.STATE_ICONS[new_state]
        
        if state_icon then
            self._state_icon:set_image(state_icon.texture, unpack(state_icon.texture_rect))
        end
        
        self._state_icon:set_visible(state_icon)
        self._avatar:set_visible(not state_icon)
    end

    HUDMiniMapCiviesEntity = HUDMiniMapCiviesEntity or class(HUDMiniMapUnitEntity)
    
    function HUDMiniMapCiviesEntity:init(parent, key, unit)
        HUDMiniMapCiviesEntity.super.init(self, parent, key, unit, 10)
        
        self._avatar:set_text("v")
        self._avatar:set_color(Color(0.5, 0.5, 0.5))
        self._elevation_indicator:set_color(Color(0.5, 0.5, 0.5))
    end
    
    function HUDMiniMapCiviesEntity:update(...)
        HUDMiniMapCiviesEntity.super.update(self, ...)
    
        if not self._deleted then
            if self._unit:character_damage():dead() then
                self:_delete()
                return
            end
            
            self._avatar:set_rotation(-self._unit:rotation():yaw() + 180)
        end
    end

    HUDMiniMapEnemyEntity = HUDMiniMapEnemyEntity or class(HUDMiniMapUnitEntity)
    
    function HUDMiniMapEnemyEntity:init(parent, key, unit)
        HUDMiniMapEnemyEntity.super.init(self, parent, key, unit, 10)
        
        self._avatar:set_text("V")
        self._avatar:set_color(Color(1, 0, 0))
        self._elevation_indicator:set_color(Color(1, 0, 0))
    end
    
    function HUDMiniMapEnemyEntity:update(...)
        HUDMiniMapEnemyEntity.super.update(self, ...)
    
        if not self._deleted then
            if self._unit:character_damage():dead() then
                self:_delete()
                return
            end
            
            self._avatar:set_rotation(-self._unit:rotation():yaw() + 180)
        end
    end
    
    HUDMiniMapCameraEntity = HUDMiniMapCameraEntity or class(HUDMiniMapUnitEntity)
    
    function HUDMiniMapCameraEntity:init(parent, key, unit)
        HUDMiniMapCameraEntity.super.init(self, parent, key, unit, 10)
        
        self._avatar:set_text("C")
        self._avatar:set_color(Color(1, 0.5, 0))
        self._elevation_indicator:set_color(Color(1, 0.5, 0))
    end
    
    function HUDMiniMapCameraEntity:update(...)
        HUDMiniMapCameraEntity.super.update(self, ...)
    
        if not self._deleted and self._unit:base():destroyed() or not managers.groupai:state():whisper_mode() then
            self:_delete()
        end
    end
    
    HUDMiniMapSWATTurretEntity = HUDMiniMapSWATTurretEntity or class(HUDMiniMapUnitEntity)
    
    function HUDMiniMapSWATTurretEntity:init(parent, key, unit)
        HUDMiniMapSWATTurretEntity.super.init(self, parent, key, unit, 10)
        
        self._avatar:set_text("T")
        self._avatar:set_color(Color(1, 0, 0))
        self._elevation_indicator:set_color(Color(1, 0, 0))
    end
    
    function HUDMiniMapSWATTurretEntity:update(...)
        HUDMiniMapSWATTurretEntity.super.update(self, ...)
    
        if not self._deleted then
            if self._unit:character_damage():dead() then
                self:_delete()
            end
        end
    end
    
    HUDMiniMapJokerEntity = HUDMiniMapJokerEntity or class(HUDMiniMapEnemyEntity)
    
    function HUDMiniMapJokerEntity:init(parent, key, unit)
        HUDMiniMapJokerEntity.super.init(self, parent, key, unit)
        
        self._avatar:set_color(Color(0.2, 0.8, 1))  --tweak_data.contour.character.friendly_color
        self._elevation_indicator:set_color(Color(0.2, 0.8, 1))
        
        self._is_escort = managers.enemy:is_civilian(self._unit)
    end
    
    function HUDMiniMapJokerEntity:update(...)
        HUDMiniMapJokerEntity.super.update(self, ...)
        
        if not self._deleted and self._is_escort and self._unit:anim_data().drop then
            self:_delete()
        end
    end
    
    	HUDMiniMapVIPEntity = HUDMiniMapVIPEntity or class(HUDMiniMapJokerEntity)

	function HUDMiniMapVIPEntity:init(parent, key, unit)
		HUDMiniMapVIPEntity.super.init(self, parent, key, unit)
		
		self._avatar:set_color(Color(1, 1, 0))	--tweak_data.contour.character.friendly_color
		self._elevation_indicator:set_color(Color(1, 1, 0))
		self._show_offscreen = true
	end
	
	function HUDMiniMapVIPEntity:update(...)
		HUDMiniMapVIPEntity.super.update(self, ...)
		
		if not self._deleted then
			if self._unit:character_damage() and self._unit:character_damage():dead() then
				self:_delete()
			end
		end
	end
	
	HUDMiniMapInterestEntity = HUDMiniMapInterestEntity or class(HUDMiniMapJokerEntity)

	function HUDMiniMapInterestEntity:init(parent, key, unit)
		HUDMiniMapInterestEntity.super.init(self, parent, key, unit)
		
		self._avatar:set_color(Color(1, 0, 1))	--tweak_data.contour.character.friendly_color
		self._elevation_indicator:set_color(Color(1, 0, 1))
		self._show_offscreen = true
	end
	
	function HUDMiniMapInterestEntity:update(...)
		HUDMiniMapInterestEntity.super.update(self, ...)
		
		if not self._deleted then
			if self._unit:character_damage() and self._unit:character_damage():dead() then
				self:_delete()
			end
		end
	end
    
    
    
    
    local HUDManager_setup_player_info_hud_pd2_original = HUDManager._setup_player_info_hud_pd2
    local HUDManager_update_original = HUDManager.update

    HUDManager.HAS_MINIMAP = true
    
    function HUDManager:_setup_player_info_hud_pd2(...)
        self:_setup_minimap()
        HUDManager_setup_player_info_hud_pd2_original(self, ...)
    end

    function HUDManager:update(t, dt, ...)
        if self._hud_minimap then
            self._hud_minimap:update(t, dt)
        end
        
        return HUDManager_update_original(self, t, dt, ...)
    end

    function HUDManager:_setup_minimap()
        local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
        self._hud_minimap = HUDMiniMap:new(hud.panel)
    end

    function HUDManager:set_minimap_enabled(status)
        self._hud_minimap:set_enabled(status and true or false)
    end

    function HUDManager:minimap_enabled()
        return self._hud_minimap:enabled()
    end
    
    
end


if RequiredScript == "lib/managers/criminalsmanager" then

    local add_character = CriminalsManager.add_character
    
    function CriminalsManager:add_character(name, unit, peer_id, ai, ...)
        if unit and alive(unit) and not unit:base().is_local_player then
            managers.hud._hud_minimap:add_entity(HUDMiniMapTeamEntity, unit:key(), unit, ai and 5 or peer_id)
        end
        
        return add_character(self, name, unit, peer_id, ai, ...)
    end
    
end

--    if RequiredScript == "lib/units/civilians/civilianbase" then
 --       local post_init = CivilianBase.post_init
 --       function CivilianBase:post_init()
  --          post_init(self)
--
  --          managers.hud._hud_minimap:add_entity(HUDMiniMapCiviesEntity, self._unit:key(), self._unit)
  --      end
  --  end

if RequiredScript == "lib/units/beings/player/huskplayermovement" then

    local sync_movement_state = HuskPlayerMovement.sync_movement_state
    
    function HuskPlayerMovement:sync_movement_state(state, ...)
        sync_movement_state(self, state, ...)
        managers.hud._hud_minimap:entity_event(tostring(self._unit:key()), state)
    end
    
end

if RequiredScript == "lib/units/contourext" then

    local add = ContourExt.add

    function ContourExt:add(...)
        local setup = add(self, ...)
        
        local entity_data = setup and HUDMiniMap._MINIMAP_MARKINGS[setup.type]
        
        if entity_data then
            local key = tostring(self._unit:key())
            
            if entity_data.delete_prior then 
                managers.hud._hud_minimap:delete_entity(key)
            end
            
            local entity = managers.hud._hud_minimap:add_entity(entity_data.class, key, self._unit)
            local duration = entity_data.duration or 
                (not entity_data.ignore_duration and setup.fadeout_t and (setup.fadeout_t - TimerManager:game():time()))
            
            if duration then
                entity:set_duration(duration)
            end
            
        end
        
        return setup
    end
    
end

if RequiredScript == "lib/managers/hudmanager" then

   --[[ local add_waypoint = HUDManager.add_waypoint
    local remove_waypoint = HUDManager.remove_waypoint

    function HUDManager:add_waypoint(id, data, ...)
        add_waypoint(self, id, data, ...)
        if string.sub(tostring(id), 1, 5) ~= "susp1" then
            managers.hud._hud_minimap:add_entity(HUDMiniMapWaypointEntity, tostring(id), { unit = data.unit, position = data.position, icon = data.icon or "wp_standard", show_offscreen = true })
        end
    end
    
    function HUDManager:remove_waypoint(id, ...)
        remove_waypoint(self, id, ...)
        managers.hud._hud_minimap:delete_entity(tostring(id))
    end--]]

end
