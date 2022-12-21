core:module("PlatformManager")

if not _G.NepgearsyHUDReborn:GetOption("UseDiscordRichPresence") then
    return
end

function WinPlatformManager:set_rich_presence_discord(name, ...)
    local player_level = managers.experience:current_level()
    local player_rank = managers.experience:current_rank()
    local is_infamous = player_rank > 0
    local level_string = player_level > 0 and ", " .. (is_infamous and managers.experience:rank_string(player_rank) .. "-" or "") .. tostring(player_level) or ""
    local job_data = managers.job:current_job_data()
    local job_name = job_data and managers.localization:text(job_data.name_id) or "No Heist selected"
    local playing = self._current_presence == "Playing" or false
    local job_supported = {
        "jewelry_store",
        "broken_arrow2",
        "gallery",
        "branchbank_prof",
        "branchbank_cash",
        "branchbank_gold",
        "branchbank_deposit",
        "arena",
        "cage",
        "rat",
        "family",
        "rvd",
        "roberts",
        "kosugi",
        "finsternis"
    }

    local supported_character_ids = {
        "russian",
        "german",
        "american",
        "spanish",
        "old_hoxton",
        "dragan",
        "jowi",
        "bodhi",
        "bonnie",
        "chico",
        "dragon",
        "ecp_female",
        "ecp_male",
        "female_1",
        "jacket",
        "jimmy",
        "joy",
        "myh",
        "sangres",
        "sokol",
        "sydney",
        "wild"
    }

    local character = managers.blackmarket:get_preferred_character()
    local character_name = "Heisting as " .. managers.localization:text("menu_" .. managers.blackmarket:get_preferred_character())
    self._rich_presence_char_supported = false

    for _, char in pairs(supported_character_ids) do
        if character == char then
            Discord:set_large_image(tostring(char), tostring(character_name))
            self._rich_presence_char_supported = true
            break
        end
    end

    if not self._rich_presence_char_supported then
        Discord:set_large_image("payday2_icon", "PAYDAY 2")
    end

    if Steam:userid() == "76561198045788203" then -- :^)
        Discord:set_large_image("sora", "Heisting with Sora")
    end

    if name == "MPPlaying" then

        local job_difficulty = _G.tweak_data.difficulties[managers.job:current_difficulty_stars() + 2] or 1
        local job_difficulty_text = ", " .. managers.localization:to_upper_text(_G.tweak_data.difficulty_name_ids[job_difficulty])

        if job_name == "No Heist selected" then
            job_difficulty_text = ""
        end

        _G.NepgearsyHUDReborn:SetDiscordPresence(Steam:username() .. level_string, "Online: " .. job_name .. job_difficulty_text, true, true, false)
        
        --[[for _, level in pairs(job_supported) do
            if managers.job:current_job_id() == level then
                Discord:set_large_image(managers.job:current_job_id(), job_name)
                self._rich_presence_level_supported = true
            end
        end--]]

        if playing and _G.NepgearsyHUDReborn:GetOption("DRPAllowTimeElapsed") then
            Discord:set_start_time_relative(0)
        end

        Discord:set_party_size(managers.network:session():amount_of_players(), _G.tweak_data.max_players)

    elseif name == "SPPlaying" then

        local job_difficulty = _G.tweak_data.difficulties[managers.job:current_difficulty_stars() + 2] or 1
        local job_difficulty_text = ", " .. managers.localization:to_upper_text(_G.tweak_data.difficulty_name_ids[job_difficulty])

        if job_name == "No Heist selected" then
            job_difficulty_text = ""
        end

        _G.NepgearsyHUDReborn:SetDiscordPresence(Steam:username() .. level_string, "Offline: " .. job_name .. job_difficulty_text, true, true, true)

        --[[for _, level in pairs(job_supported) do
            if managers.job:current_job_id() == level then
                Discord:set_large_image(managers.job:current_job_id(), job_name)
                self._rich_presence_level_supported = true
            end
        end--]]

        if playing and _G.NepgearsyHUDReborn:GetOption("DRPAllowTimeElapsed") then
            Discord:set_start_time_relative(0)
        end
    
    elseif name == "MPLobby" then
        local job_difficulty = _G.tweak_data.difficulties[managers.job:current_difficulty_stars() + 2] or 1
        local job_difficulty_text = ", " .. managers.localization:to_upper_text(_G.tweak_data.difficulty_name_ids[job_difficulty])

        if job_name == "No Heist selected" then
            job_difficulty_text = ""
        end

        _G.NepgearsyHUDReborn:SetDiscordPresence(Steam:username() .. level_string, "Lobby: " .. job_name .. job_difficulty_text, true, true, true)
        Discord:set_party_size(managers.network:session():amount_of_players(), _G.tweak_data.max_players)

        --[[for _, level in pairs(job_supported) do
            if managers.job:current_job_id() == level then
                Discord:set_large_image(managers.job:current_job_id(), job_name)
                self._rich_presence_level_supported = true
            end
        end--]]

        if _G.NepgearsyHUDReborn:GetOption("DRPAllowTimeElapsed") then
            Discord:set_start_time_relative(0)
        end
    elseif name == "SPEnd" or name == "MPEnd" then
		_G.NepgearsyHUDReborn:SetDiscordPresence(Steam:username() .. level_string, "Summary of " .. job_name, true, true, true)
        Discord:set_start_time(0)
    else
        Discord:set_party_size(0, 0)
        _G.NepgearsyHUDReborn:SetDiscordPresence(Steam:username() .. level_string, "Main Menu", true, true, true)

        if _G.NepgearsyHUDReborn:GetOption("DRPAllowTimeElapsed") then
            Discord:set_start_time_relative(0)
        end
    end
end

function WinPlatformManager:update_discord_character(...)
end

function WinPlatformManager:update_discord_heist(...)
end

