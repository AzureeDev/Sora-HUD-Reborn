NepHook:Post(HUDMissionBriefing, "init", function(self)
    self._player = {}                       -- Steam ID for avatars
    self._player[1] = "0"
    self._player[2] = "0"
    self._player[3] = "0"
    self._player[4] = "0"

    self._player_connected = {}             -- Boolean to check if the player got Networked data already
    self._player_connected[1] = false
    self._player_connected[2] = false
    self._player_connected[3] = false
    self._player_connected[4] = false

    self._custom_starring = {}              -- Stock the starring in a string then modify the panel if it's not empty
    self._custom_starring[1] = ""
    self._custom_starring[2] = ""
    self._custom_starring[3] = ""
    self._custom_starring[4] = ""

    -- FUCK YOU OVERKILL
    -- Especially about the part of calling set_player_slot up to 6 times for the same player
end)

NepHook:Post(HUDMissionBriefing, "set_player_slot", function(self, nr, params)
    LuaNetworking:SendToPeers("nephud_teammate_bg", tostring(NepgearsyHUDReborn:GetTeammateSkinID()))
    
    if not NepgearsyHUDReborn.Options:GetValue("EnableStarring") then
        return
    end

    local current_name = params.name
    local peer_id = params.peer_id
    local has_starring_text = NepgearsyHUDReborn.Options:GetValue("StarringText") ~= "" and true or false

    local blackscreen = managers.hud._hud_blackscreen
    local blackscreen_panel = blackscreen._blackscreen_panel
    local starring_panel = blackscreen_panel:child("starring_panel")
    local player_slot = starring_panel:child("player_" .. nr)

    if not player_slot then return end

    self:_update_avatar_slot(peer_id)
	self:_update_name(current_name, peer_id)

    LuaNetworking:SendToPeers("StarringColor", tostring(NepgearsyHUDReborn.Options:GetValue("StarringColor")))

    if has_starring_text then
        LuaNetworking:SendToPeers("StarringText", tostring(NepgearsyHUDReborn.Options:GetValue("StarringText")))
    end

    if current_name == managers.network.account:username_id() then
        player_slot:set_color(NepgearsyHUDReborn:StringToColor("starring", NepgearsyHUDReborn.Options:GetValue("StarringColor")))
        
        if tostring(NepgearsyHUDReborn.Options:GetValue("StarringText")) ~= "" then
            player_slot:set_text(player_slot:text() .. ", " .. tostring(NepgearsyHUDReborn.Options:GetValue("StarringText")))
        end
    end
end)

function HUDMissionBriefing:_update_avatar_slot(peer_id)
	local peer_data = managers.network and managers.network:session() and managers.network:session():peer(peer_id)
	local steam_id = peer_data:user_id()

	self._player[peer_id] = tostring(steam_id)

	Steam:friend_avatar(1, self._player[peer_id], function (texture)
		local avatar = texture or "guis/textures/pd2/none_icon"
		local blackscreen = managers.hud._hud_blackscreen
		local blackscreen_panel = blackscreen._blackscreen_panel
		local starring_panel = blackscreen_panel:child("starring_panel")
		local player_slot = starring_panel:child("avatar_player_" .. peer_id)

        if player_slot then
            player_slot:set_image(avatar)
            player_slot:set_visible(true)
        end
	end)
end


function HUDMissionBriefing:_update_name(name, peer_id)
	local blackscreen = managers.hud._hud_blackscreen
	local blackscreen_panel = blackscreen._blackscreen_panel
	local starring_panel = blackscreen_panel:child("starring_panel")
	local player_slot = starring_panel:child("player_" .. peer_id)

    if player_slot then
        player_slot:set_text(name)
    
        if self._custom_starring[peer_id] ~= "" then
            player_slot:set_text(name .. self._custom_starring[peer_id])
        end

        player_slot:set_visible(true)
    end
end

Hooks:Add("NetworkReceivedData", "NepgearsyHUDReborn_StarringSync", function(sender, id, data)
    if id == "nephud_teammate_bg" then
        managers.player._player_teammate_bgs[sender] = data
    end
    
    local StarringColorSyncID = "StarringColor"
    local StarringTextSyncID = "StarringText"
    local blackscreen = managers.hud._hud_blackscreen
    
    if blackscreen then
        local blackscreen_panel = blackscreen._blackscreen_panel
        if blackscreen_panel then
            local starring_panel = blackscreen_panel:child("starring_panel")
            if starring_panel then
                local player_slot = starring_panel:child("player_" .. sender)

                if id == StarringColorSyncID then
                    local data_to_number = tonumber(data)
                    player_slot:set_color(NepgearsyHUDReborn:StringToColor("starring", data_to_number))
                end

                if id == StarringTextSyncID then
                    local data_to_string = tostring(data)
                    
                    if not managers.hud._hud_mission_briefing._player_connected[sender] then
                        managers.hud._hud_mission_briefing._custom_starring[sender] = ", " .. data_to_string
                        managers.hud._hud_mission_briefing._player_connected[sender] = true
                    end
                end
            end
        end
    end
end)