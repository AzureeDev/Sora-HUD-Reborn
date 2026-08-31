local NepgearsyHUDReborn = _G.NepgearsyHUDReborn
if NepgearsyHUDReborn:GetOption("UseDiscordRichPresence") then
    local character_supported = {
        russian = true,
        german = true,
        american = true,
        spanish = true,
        old_hoxton = true,
        dragan = true,
        jowi = true,
        bodhi = true,
        bonnie = true,
        chico = true,
        dragon = true,
        ecp_female = true,
        ecp_male = true,
        female_1 = true,
        jacket = true,
        jimmy = true,
        joy = true,
        myh = true,
        sangres = true,
        sokol = true,
        sydney = true,
        wild = true
    }

    local job_supported = {
        jewelry_store = true,
        gallery = true,
        branchbank_prof = true,
        branchbank_cash = true,
        branchbank_gold = true,
        branchbank_deposit = true,
        arena = true,
        cage = true,
        rat = true,
        family = true,
        rvd = true,
        roberts = true,
        kosugi = true,

        broken_arrow2 = true,
        finsternis = true
    }

    local rpc_image = function(self, heist)
        if Steam:userid() == "76561198045788203" then -- :^)
            if not self._set_sora then
                Discord:set_large_image("sora", "Heisting with Sora")
                self._set_sora = true
            end
        else
            if heist and NepgearsyHUDReborn:GetOption("DiscordRichPresenceLargeImageType") == 2 then
                local job_id = managers.job:current_job_id()
                local job_data = managers.job:current_job_data()
                if job_supported[job_id] then
                    local job_name = job_data and managers.localization:text(job_data.name_id)
                    Discord:set_large_image(job_id, job_name)
                else
                    if job_data then
                        NepgearsyHUDReborn:DebugLog("rpc_image - unsupported job_id: " .. tostring(job_id))
                    end
                end
            else
                local character = managers.blackmarket:get_preferred_character()
                if character_supported[character] then
                    local character_name = "Heisting as " .. managers.localization:text("menu_" .. character)
                    Discord:set_large_image(character, character_name)
                else
                    NepgearsyHUDReborn:DebugLog("rpc_image - unsupported character: " .. tostring(character))
                    Discord:set_large_image("payday2_icon", "PAYDAY 2")
                end
            end
        end
    end

    local username = function()
        if NepgearsyHUDReborn:GetOption("DiscordUsername") then
            local custom = NepgearsyHUDReborn:GetOption("DiscordUsernameCustom")
            if custom ~= "" then
                return custom .. ", "
            else
                return Steam:username() .. ", "
            end
        else
            return ""
        end
    end

    core:module("PlatformManager")
    function WinPlatformManager:set_rich_presence_discord(name)
        --local playing = self._current_presence == "Playing" or false

        rpc_image(self, true)

        if not self._small_image then
            Discord:set_small_image("sora_hud", "Sora's HUD Reborn " .. NepgearsyHUDReborn.Version)
            self._small_image = true
        end

        local job_data = managers.job:current_job_data()
        local job_name = job_data and managers.localization:text(job_data.name_id) or "No Heist selected"
        local job_difficulty = _G.tweak_data.difficulties[managers.job:current_difficulty_stars() + 2] or 1
        local job_difficulty_text = ", " .. managers.localization:to_upper_text(_G.tweak_data.difficulty_name_ids[job_difficulty])

        if job_name == "No Heist selected" then
            job_difficulty_text = ""
        end

        if managers.crime_spree and managers.crime_spree:is_active() then
            local level_id = Global.game_settings.level_id
            local name_id = level_id and _G.tweak_data.levels[level_id] and _G.tweak_data.levels[level_id].name_id
            if name_id then
                job_name = managers.localization:text(name_id) or job_name
            end

            job_difficulty_text = ", " .. managers.localization:to_upper_text("cn_crime_spree") .. ": " .. managers.crime_spree:server_spree_level()
        end

        if name == "MPLobby" or name == "MPPlaying" then
            Discord:set_party_size(managers.network:session():amount_of_players(), _G.tweak_data.max_players or 4)
        end

        local player_level = managers.experience:current_level()
        local player_rank = managers.experience:current_rank()
        local is_infamous = player_rank > 0
        local level_string = player_level > 0 and (is_infamous and managers.experience:rank_string(player_rank) .. "-" or "") .. tostring(player_level) or ""

        local state = {
            SPPlaying = "Offline: " .. job_name .. job_difficulty_text,
            MPPlaying = "Online: " .. job_name .. job_difficulty_text,
            MPLobby = "Lobby: " .. job_name .. job_difficulty_text,
            SPEnd = "Summary of " .. job_name
        }
        state.MPEnd = state.SPEnd
        
        if state[name] then
            NepgearsyHUDReborn:SetDiscordPresence(username() .. level_string, state[name])
        else
            NepgearsyHUDReborn:SetDiscordPresence(username() .. level_string, "Main Menu")
            Discord:set_party_size(nil)
            rpc_image(self) -- cus current_job_id doesn't get cleared
        end
    end

    function WinPlatformManager:update_discord_character()
        self:set_rich_presence_discord(self._current_rich_presence)
    end

    function WinPlatformManager:update_discord_heist()
        self:set_rich_presence_discord(self._current_rich_presence)
    end
end
