local BaseLayer = 1500
local BorderColor = Color(0.5, 0, 1)
local HighlightColor = Color(0.35, 0.25, 0.19, 0.32)
local Font = "fonts/font_eurostile_ext"

local function make_fine_text( text )
	local x,y,w,h = text:text_rect()
	text:set_size( w, h )
	text:set_position( math.round( text:x() ), math.round( text:y() ) )
end

NepHudMenu = NepHudMenu or class()

-- Based on BeardLib Editor & HoloUI's menu.
function NepHudMenu:init()
    self._menu = MenuUI:new({
        name = "NepgearsyHUDMenu",
        layer = BaseLayer,
        background_color = Color.transparent,
        animate_toggle = true
    })
    self._menu_panel = self._menu._panel
    self.BackgroundStatus = true

    self:InitTopBar()
    self:InitBackground()
    self:InitMenu()
    self:InitCollab()
    self:InitChangelog()

    MenuCallbackHandler.NepgearsyHUDRebornMenu = callback(self, self, "set_enabled", true)
    MenuHelperPlus:AddButton({
        id = "NepgearsyHUDRebornMenu",
        title = "NepgearsyHUDRebornMenu",
        node_name = "options",
        position = 1,
        callback = "NepgearsyHUDRebornMenu"
    })
end

function NepHudMenu:InitTopBar()
    self.TopBar = self._menu:Menu({
        name = "TopBar",
        background_color = Color(0.05, 0.05, 0.05),
        h = 30,
        w = self._menu_panel:w(),
        scrollbar = false,
        position = function(item)
            item:SetPositionByString("Top")
        end
    })

    local HUDName = self.TopBar:Panel():text({
        text = managers.localization:to_upper_text("NepgearsyHUDReborn"),
        font = Font,
        font_size = 25,
        x = 5,
        color = Color(0.8, 0.8, 0.8),
        vertical = "center",
        layer = BaseLayer,
    })
    make_fine_text(HUDName)
    self.HUDName = HUDName

    local BackgroundEnabler = self.TopBar:ImageButton({
        name = "BackgroundEnabler",
        texture = "NepgearsyHUDReborn/Menu/DisableBackground",
        w = 28,
        h = 28,
        position = function(item) 
            item:Panel():set_left(self.HUDName:right() + 20)
        end,
        callback = callback(self, self, "background_enable_switch")
    })
    BackgroundEnabler:Panel():set_world_center_y(self.TopBar:Panel():world_center_y())
    HUDName:set_world_center_y(self.TopBar:Panel():world_center_y())
    self.BackgroundEnabler = BackgroundEnabler

    local MWSProfile = self.TopBar:ImageButton({
        name = "MWSProfile",
        texture = "NepgearsyHUDReborn/Menu/MWSProfile",
        w = 28,
        h = 28,
        position = function(item) 
            item:Panel():set_left(self.BackgroundEnabler:Panel():right() + 10)
        end,
        callback = callback(self, self, "open_url", "https://modworkshop.net/member.php?action=profile&uid=1923")
    })
    MWSProfile:Panel():set_world_center_y(self.TopBar:Panel():world_center_y())

    local HUDVersion = self.TopBar:Button({
        name = "HUDVersion",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/Version", { version = NepgearsyHUDReborn.Version }),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(0.4, 0.4, 0.4),
        foreground_highlight = BorderColor,
        position = function(item) 
            item:Panel():set_right(self.TopBar:Panel():right() - 5)
        end,
        localized = false,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 25,
        font = Font,
        callback = callback(self, self, "open_url", "https://github.com/Nepgearsy/Nepgearsy-HUD-Reborn/commits/master")
    })
end


function NepHudMenu:InitBackground()
    local Background = self._menu_panel:bitmap({
        name = "Background",
        w = self._menu_panel:w(),
        h = self._menu_panel:h() - self.TopBar:Panel():h(),
        texture = "NepgearsyHUDReborn/Menu/NepHudMenu"
    })
    Background:set_top(self.TopBar:Panel():bottom())
end

function NepHudMenu:SetBackgroundVis(vis)
    local Background = self._menu_panel:child("Background")
    Background:set_visible(vis)
end

function NepHudMenu:InitMenu()
    self.MainMenu = self._menu:Menu({
        name = "MainMenu",
        background_color = Color(0.3, 0, 0, 0),
        h = self._menu_panel:h() - self.TopBar:Panel():h(),
        w = self._menu_panel:w() / 4, 
        align_method = "normal",
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom())
            item:Panel():set_right(self._menu_panel:right())
        end
    })

    self.HUDOptionsCat = self.MainMenu:Button({
        name = "HUDOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/HUDOptionsCat",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        position = function(item) 
            item:Panel():set_top(item:Panel():parent():top() + 10) 
            item:Panel():set_right(item:Panel():parent():right())
        end,
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        font = Font
    })

    self.HUDOptions = {}
    self.HUDOptions.AssaultBar = self.MainMenu:Button({
        name = "HUDOptionsAssaultBarButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultBar",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptionsCat:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.HUDOptions.Minimap = self.MainMenu:Button({
        name = "HUDOptionsMinimapButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Minimap",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.AssaultBar:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.HUDOptions.Trackers = self.MainMenu:Button({
        name = "HUDOptionsTrackersButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Trackers",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Minimap:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.HUDOptions.Objectives = self.MainMenu:Button({
        name = "HUDOptionsObjectivesButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Objectives",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Trackers:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.HUDOptions.Teammate = self.MainMenu:Button({
        name = "HUDOptionsTeammateButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Teammate",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Objectives:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.HUDOptions.CleanFont = self.MainMenu:Toggle({
        name = "HUDOptionsCleanFontButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/CleanFont",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Teammate:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.MenuLobbyOptionsCat = self.MainMenu:Button({
        name = "MenuLobbyOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/MenuLobbyOptionsCat",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.CleanFont:Panel():bottom() + 15) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        font = Font
    })

    self.MenuLobbyOptions = {}
    self.MenuLobbyOptions.StarringScreen = self.MainMenu:Toggle({
        name = "MenuLobbyOptionsStarringScreenButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringScreen",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.MenuLobbyOptionsCat:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.MenuLobbyOptions.StarringText = self.MainMenu:TextBox({
        name = "MenuLobbyOptionsStarringText",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringText",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.MenuLobbyOptions.StarringScreen:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.MenuLobbyOptions.HorizontalLoadout = self.MainMenu:Toggle({
        name = "MenuLobbyOptionsHorizontalLoadoutButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/HorizontalLoadout",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.MenuLobbyOptions.StarringText:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15
    })

    self.BackButton = self.MainMenu:Button({
        name = "BackButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/Close",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_bottom(item:Panel():parent():bottom() - 10) 
            item:Panel():set_right(item:Panel():parent():right())
        end,
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        callback = callback(self, self, "set_enabled", false)
    })
end

function NepHudMenu:InitCollab()
    self.CollabMenu = self._menu:Menu({
        name = "CollabMenu",
        background_color = Color(0.3, 0, 0, 0),
        h = 350,
        w = self._menu_panel:w() / 2.1, 
        align_method = "normal",
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom() + 15)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    self.CollabMenuHeader = self.CollabMenu:Button({
        name = "CollabMenuHeader",
        text = "NepgearsyHUDRebornMenu/Collaborators/Header",
        localized = true,
        font = Font,
        font_size = 20,
        background_color = Color(0.75, 0, 0, 0),
        highlight_color = Color(0.75, 0, 0, 0),
        position = function(item) 
            item:Panel():set_top(item:Panel():parent():top() + 10) 
            item:Panel():set_right(item:Panel():parent():right())
        end,
        text_vertical = "center",
        text_align = "center"
    })

    self.Collaborator = {}
    self.CollabPanel = {}
    self.CollabAvatar = {}
    self.CollabName = {}
    self.CollabAction = {}

    for i, collab_data in ipairs(NepgearsyHUDReborn.Creators) do
        local built_steam_url = "http://steamcommunity.com/profiles/" .. collab_data.steam_id

        self.Collaborator[i] = self.CollabMenu:Button({
            name = "Collaborator_" .. i,
            h = 32,
            text = "",
            border_color = BorderColor,
            border_left = true,
            background_color = Color(0.3, 0, 0, 0),
            highlight_color = HighlightColor,
            position = function(item)
                if i == 1 then
                    item:Panel():set_top(self.CollabMenuHeader:Panel():bottom() + 5)
                    item:Panel():set_left(self.CollabMenuHeader:Panel():left())
                else
                    local prev_i = i - 1
                    item:Panel():set_top(self.Collaborator[prev_i]:Panel():bottom() + 5)
                    item:Panel():set_left(self.CollabMenuHeader:Panel():left())
                end
            end,
            callback = callback(self, self, "open_url", built_steam_url)
        })

        self.CollabPanel[i] = self.Collaborator[i]:Panel()
        self.CollabAvatar[i] = self.CollabPanel[i]:bitmap({
            texture = "guis/textures/pd2/none_icon",
            h = self.Collaborator[i]:Panel():h(),
            w = self.Collaborator[i]:Panel():h(),
            x = 5,
            layer = BaseLayer
        })

        Steam:friend_avatar(1, collab_data.steam_id, function (texture)
            local avatar = texture or "guis/textures/pd2/none_icon"
            self.CollabAvatar[i]:set_image(avatar)
        end)

        self.CollabName[i] = self.CollabPanel[i]:text({
            text = collab_data.name,
            font = Font,
            font_size = 18,
            color = i == 1 and Color(0.63, 0.58, 0.95) or Color.white,
            layer = BaseLayer,
            vertical = "center"
        })
        self.CollabName[i]:set_left(self.CollabAvatar[i]:right() + 5)

        self.CollabAction[i] = self.CollabPanel[i]:text({
            text = collab_data.action,
            font = "fonts/font_large_mf",
            font_size = 18,
            color = Color(0.5, 0.5, 0.5),
            layer = BaseLayer,
            vertical = "center",
            align = "right"
        })
    end
end

function NepHudMenu:InitChangelog()
    self.ChangelogMenu = self._menu:Menu({
        name = "ChangelogMenu",
        background_color = Color(0.3, 0, 0, 0),
        h = 300,
        w = self._menu_panel:w() / 2.1, 
        align_method = "normal",
        position = function(item)
            item:Panel():set_top(self.CollabMenu:Panel():bottom() + 10)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    self.ChangelogMenuHeader = self.ChangelogMenu:Button({
        name = "ChangelogMenuHeader",
        text = managers.localization:text("NepgearsyHUDRebornMenu/Changelog/Header", { version = NepgearsyHUDReborn.Version }),
        localized = false,
        font = Font,
        font_size = 20,
        background_color = Color(0.75, 0, 0, 0),
        highlight_color = Color(0.75, 0, 0, 0),
        position = function(item) 
            item:Panel():set_top(item:Panel():parent():top() + 10) 
            item:Panel():set_right(item:Panel():parent():right())
        end,
        text_vertical = "center",
        text_align = "center"
    })

    self.ChangelogTextMenu = self._menu:Menu({
        name = "ChangelogTextMenu",
        background_color = Color(0.3, 0, 0, 0),
        h = 250,
        w = self.ChangelogMenuHeader:Panel():w(), 
        align_method = "normal",
        position = function(item)
            item:Panel():set_top(self.ChangelogMenu:Panel():top() + 40)
            item:Panel():set_left(self.ChangelogMenu:Panel():left() + 12)
        end
    })

    self.Changelog = self.ChangelogTextMenu:Panel():text({
        text = NepgearsyHUDReborn.Changelog,
        font = "fonts/font_large_mf",
        font_size = 16,
        layer = BaseLayer,
        x = 10,
        y = 10,
        wrap = true,
        word_wrap = true
    })
end

function NepHudMenu:set_enabled(enabled)
    local opened = BeardLib.managers.dialog:DialogOpened(self)
    if enabled then
        if not opened then
            BeardLib.managers.dialog:ShowDialog(self)
            self._menu:Enable()
        end
    elseif opened then
        BeardLib.managers.dialog:CloseDialog(self)
        self._menu:Disable()
    end
end

function NepHudMenu:open_url(url)
    Steam:overlay_activate("url", url)
end

function NepHudMenu:background_enable_switch()
    if self.BackgroundStatus == true then
        self:SetBackgroundVis(false)
        self.CollabMenu:SetVisible(false)
        self.ChangelogMenu:SetVisible(false)
        self.ChangelogTextMenu:SetVisible(false)
        self.BackgroundEnabler:SetImage("NepgearsyHUDReborn/Menu/EnableBackground")
        self.BackgroundStatus = false
    else
        self:SetBackgroundVis(true)
        self.CollabMenu:SetVisible(true)
        self.ChangelogMenu:SetVisible(true)
        self.ChangelogTextMenu:SetVisible(true)
        self.BackgroundEnabler:SetImage("NepgearsyHUDReborn/Menu/DisableBackground")         
        self.BackgroundStatus = true
    end
end

function NepHudMenu:should_close()
    return self._menu:ShouldClose()
end

function NepHudMenu:hide()
    self:set_enabled(false)
    return true
end