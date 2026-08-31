local BaseLayer = 1500
local HighlightColor = Color(0.5, 0.25, 0.25, 0.32)
local font = "fonts/font_eurostile_ext"
local MenuBgs = Color(0.75, 0, 0, 0)

--[[
local function make_fine_text(text)
    local x, y, w, h = text:text_rect()
    text:set_size(w, h)
    text:set_position(math.round(text:x()), math.round(text:y()))
end
]]

-- Based on BeardLib Editor & HoloUI's menu.
NepHudMenu = NepHudMenu or class()
function NepHudMenu:init()
    self._menu = MenuUI:new({
        name = "NepgearsyHUDMenu",
        layer = BaseLayer,
        use_default_close_key = true,
        background_color = Color.transparent,
        inherit_values = {
            background_color = MenuBgs,
            scroll_color = Color.white:with_alpha(0.1),
            highlight_color = HighlightColor
        },
        animate_toggle = true,
        animate_colors = true
    })
    self._background_enabled = true
    self.BorderColor = NepgearsyHUDReborn:GetOption("SoraCPBorderColor")
    self.CurrentTeammateSkinCategory = "default"

    self:InitTopBar()
    self:InitBackground()
    self:InitMenu()
    self:InitCollab()
    self:InitChangelog()
    self:InitBack()
end

function NepHudMenu:InitTopBar()
    self.TopBar = self._menu:Menu({
        name = "TopBar",
        background_color = Color(0.05, 0.05, 0.05),
        h = 30,
        text_offset = 0,
        align_method = "grid",
        w = self._menu._panel:w(),
        scrollbar = false,
        position = "Top"
    })

    self.HUDName = self.TopBar:Divider({
        text = "NepgearsyHUDReborn",
        font = NepgearsyHUDReborn:SetFont(font),
        size = 25,
        border_left = false,
        size_by_text = true,
        localized = true,
        color = Color(0.8, 0.8, 0.8),
        layer = BaseLayer,
    })

    self.BackgroundEnabler = self.TopBar:ImageButton({
        name = "BackgroundEnabler",
        texture = "NepgearsyHUDReborn/Menu/DisableBackground",
        w = 26,
        h = 26,
        offset_x = 20,
        help = "NepgearsyHUDRebornMenu/Help/DisableBackground",
        localized = true,
        on_callback = callback(self, self, "background_switch")
    })

    self.MWSProfile = self.TopBar:ImageButton({
        name = "MWSProfile",
        texture = "NepgearsyHUDReborn/Menu/MWSProfile",
        w = 26,
        h = 26,
        offset_x = 5,
        help = "NepgearsyHUDRebornMenu/Help/MWSProfile",
        localized = true,
        on_callback = callback(self, self, "open_url", "https://modworkshop.net/mod/22152")
    })

    self.HUDVersion = self.TopBar:Button({
        name = "HUDVersion",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/Version", { version = NepgearsyHUDReborn.Version }),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(0.4, 0.4, 0.4),
        foreground_highlight = self.BorderColor,
        position = "RightOffset-x",
        offset_x = 5,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 25,
        font = NepgearsyHUDReborn:SetFont(font),
        on_callback = callback(self, self, "open_url", "https://github.com/AzureeDev/Sora-HUD-Reborn/commits/master")
    })

    self.PostIssue = self.TopBar:Button({
        name = "PostIssue",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/PostIssue"),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(1, 1, 1),
        foreground_highlight = self.BorderColor,
        position = function(item)
            item:Panel():set_right(self.HUDVersion:Panel():left() - 120)
            item:Panel():set_world_center_y(self.TopBar:Panel():world_center_y())
        end,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 15,
        font = NepgearsyHUDReborn:SetFont(font),
        on_callback = callback(self, self, "open_url", "https://github.com/AzureeDev/Sora-HUD-Reborn/issues")
    })
end

function NepHudMenu:InitBackground()
    self.Background = self._menu._panel:bitmap({
        name = "Background",
        w = self._menu._panel:w(),
        h = self._menu._panel:h() - self.TopBar:Panel():h(),
        texture = "NepgearsyHUDReborn/Menu/MenuBackgrounds/SoraHudReborn",
        alpha = 1
    })
    self.Background:set_top(self.TopBar:Panel():bottom())

    self.ColorBG = self._menu._panel:bitmap({
        name = "ColorBG",
        w = self._menu._panel:w(),
        h = self._menu._panel:h() - self.TopBar:Panel():h(),
        texture = "NepgearsyHUDReborn/Menu/BGColor",
        color = NepgearsyHUDReborn:GetOption("SoraCPColor"),
        layer = -2
    })
    self.ColorBG:set_top(self.TopBar:Panel():bottom())
end

function NepHudMenu:SetEnabled(state)
    if not self._menu then
        self:init()
    end

    self._menu:SetEnabled(state)
end

function NepHudMenu:InitMenu()
    self.MainMenu = self._menu:Menu({
        name = "MainMenu",
        w = self._menu._panel:w() / 4,
        h = self._menu._panel:h() - self.TopBar:Panel():h(),
        size = 15,
        border_color = self.BorderColor,
        offset = 8,
        text_align = "left",
        text_vertical = "center",
        localized = true,
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom())
            item:Panel():set_right(self._menu._panel:right())
        end
    })

    self.TeammateSkins = self._menu:Menu({
        name = "TeammateSkins",
        background_color = MenuBgs,
        h = 600,
        scrollbar = true,
        w = self._menu._panel:w() / 2.1,
        align_method = "grid",
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom() + 15)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end,
        visible = false
    })

    self:InitMainMenu()
end

function NepHudMenu:InitMainMenu()
    self:ClearMenu()
    self:VisOptionalMenuParts(true)

    if self.TeammateSkins then
        self.TeammateSkins:SetVisible(false)
    end

    self.ForcedLocalization = self.MainMenu:ComboBox({
        name = "ForcedLocalization",
        border_left = true,
        items = NepgearsyHUDReborn.localization,
        value = NepgearsyHUDReborn:GetOption("ForcedLocalization"),
        text = "NepgearsyHUDRebornMenu/ForcedLocalization",
        on_callback = callback(self, self, "MainClbk")
    })

    self.MainMenuOptionsCat = self.MainMenu:Divider({
        name = "MainMenuOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/MainMenuOptionsCat",
        offset_y = 20,
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    self.MainMenuOptions = {
        HUDOptionsButton = self.MainMenu:Button({
            name = "HUDOptionsButton",
            border_color = self.BorderColor,
            border_left = true,
            text = "NepgearsyHUDRebornMenu/Buttons/HUDOptions",
            localized = true,
            on_callback = callback(self, self, "InitHUDOptions")
        }),

        MenuOptionsButton = self.MainMenu:Button({
            name = "MenuOptionsButton",
            border_color = self.BorderColor,
            border_left = true,
            text = "NepgearsyHUDRebornMenu/Buttons/MenuOptionsButton",
            localized = true,
            on_callback = callback(self, self, "InitMenuOptions")
        }),

        ColorOptionsButton = self.MainMenu:Button({
            name = "ColorOptionsButton",
            border_color = self.BorderColor,
            border_left = true,
            text = "NepgearsyHUDRebornMenu/Buttons/ColorOptions",
            localized = true,
            on_callback = callback(self, self, "InitColorOptions")
        }),

        TeammatePanelSkinButton = self.MainMenu:Button({
            name = "TeammatePanelSkinButton",
            border_color = self.BorderColor,
            border_left = true,
            text = "NepgearsyHUDRebornMenu/Buttons/TeammatePanelSkinButton",
            localized = true,
            on_callback = callback(self, self, "InitTeammateSkins")
        }),

        DiscordRichPresenceButton = self.MainMenu:Button({
            name = "DiscordRichPresenceButton",
            border_color = self.BorderColor,
            border_left = true,
            text = "NepgearsyHUDRebornMenu/Buttons/DiscordRichPresenceButton",
            localized = true,
            on_callback = callback(self, self, "InitDiscordRichPresence")
        })
    }
end

function NepHudMenu:InitHUDOptions()
    self:ClearMenu()

    self.HUDOptionsCat = self.MainMenu:Divider({
        name = "HUDOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/HUDOptions",
        offset_y = 20,
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    self.HUDOptions = {
        AssaultBarFont = self.MainMenu:ComboBox({
            name = "AssaultBarFont",
            border_left = true,
            items = NepgearsyHUDReborn.fonts,
            value = NepgearsyHUDReborn:GetOption("AssaultBarFont"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultBarFont",
            on_callback = callback(self, self, "MainClbk")
        }),

        PlayerNameFont = self.MainMenu:ComboBox({
            name = "PlayerNameFont",
            border_left = true,
            items = NepgearsyHUDReborn.fonts,
            value = NepgearsyHUDReborn:GetOption("PlayerNameFont"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/PlayerNameFont",
            on_callback = callback(self, self, "MainClbk")
        }),

        InteractionFont = self.MainMenu:ComboBox({
            name = "InteractionFont",
            border_left = true,
            items = NepgearsyHUDReborn.fonts,
            value = NepgearsyHUDReborn:GetOption("InteractionFont"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/InteractionFont",
            on_callback = callback(self, self, "MainClbk")
        }),

        --[[
        TeammatePanelStyle = self.MainMenu:ComboBox({
            name = "TeammatePanelStyle",
            border_left = true,
            offset_y = 20,
            items = NepgearsyHUDReborn.TeammatePanelStyles,
            value = NepgearsyHUDReborn:GetOption("TeammatePanelStyle"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/TeammatePanelStyle",
            on_callback = callback(self, self, "MainClbk")
        }),
        ]]

        Minimap = self.MainMenu:Toggle({
            name = "EnableMinimap",
            border_left = true,
            offset_y = 20,
            value = NepgearsyHUDReborn:GetOption("EnableMinimap"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/Minimap",
            on_callback = callback(self, self, "MainClbk")
        }),

        MinimapForce = self.MainMenu:Toggle({
            name = "MinimapForce",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("MinimapForce"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapForce",
            help = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapForceHelp",
            on_callback = callback(self, self, "MainClbk")
        }),

        MinimapSize = self.MainMenu:Slider({
            name = "MinimapSize",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("MinimapSize"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapSize",
            min = 150,
            max = 200,
            step = 1,
            on_callback = callback(self, self, "MainClbk")
        }),

        MinimapZoom = self.MainMenu:Slider({
            name = "MinimapZoom",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("MinimapZoom"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapZoom",
            min = 0.25,
            max = 1,
            step = 0.01,
            on_callback = callback(self, self, "MainClbk")
        }),

        ActivateMoneyHUD = self.MainMenu:Toggle({
            name = "ActivateMoneyHUD",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ActivateMoneyHUD"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/ActivateMoneyHUD",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        Trackers = self.MainMenu:Toggle({
            name = "EnableTrackers",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableTrackers"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/Trackers",
            help = "NepgearsyHUDRebornMenu/Buttons/HUD/TrackersHelp",
            on_callback = callback(self, self, "MainClbk")
        }),

        CopTracker = self.MainMenu:Toggle({
            name = "EnableCopTracker",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableCopTracker"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/CopTracker",
            on_callback = callback(self, self, "MainClbk")
        }),

        AssaultTrackersScale = self.MainMenu:Slider({
            name = "AssaultTrackersScale",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("AssaultTrackersScale"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultTrackersScale",
            help = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultTrackersScaleHelp",
            min = 0.1,
            max = 2,
            step = 0.01,
            on_callback = callback(self, self, "MainClbk")
        }),

        AssaultScale = self.MainMenu:Slider({
            name = "AssaultScale",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("AssaultScale"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultScale",
            min = 0.1,
            max = 2,
            step = 0.01,
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        HealthStyle = self.MainMenu:ComboBox({
            name = "HealthStyle",
            items = NepgearsyHUDReborn.HealthStyle,
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("HealthStyle"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/HealthStyle",
            on_callback = callback(self, self, "MainClbk")
        }),

        StatusNumberType = self.MainMenu:ComboBox({
            name = "StatusNumberType",
            items = NepgearsyHUDReborn.StatusNumberType,
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("StatusNumberType"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/StatusNumberType",
            on_callback = callback(self, self, "MainClbk")
        }),

        EnablePlayerLevel = self.MainMenu:Toggle({
            name = "EnablePlayerLevel",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnablePlayerLevel"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnablePlayerLevel",
            on_callback = callback(self, self, "MainClbk")
        }),

        EnableSteamAvatars = self.MainMenu:Toggle({
            name = "EnableSteamAvatars",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableSteamAvatars"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableSteamAvatars",
            on_callback = callback(self, self, "MainClbk")
        }),

        EnableDownCounter = self.MainMenu:Toggle({
            name = "EnableDownCounter",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableDownCounter"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableDownCounter",
            on_callback = callback(self, self, "MainClbk")
        }),

        RealAmmo = self.MainMenu:Toggle({
            name = "EnableRealAmmo",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableRealAmmo"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/RealAmmo",
            on_callback = callback(self, self, "MainClbk")
        }),

        EnableInteraction = self.MainMenu:Toggle({
            name = "EnableInteraction",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableInteraction"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableInteraction",
            on_callback = callback(self, self, "MainClbk")
        }),

        ActivateStaminaBar = self.MainMenu:Toggle({
            name = "ActivateStaminaBar",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ActivateStaminaBar"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/ActivateStaminaBar",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        EnableHPSMeter = self.MainMenu:Toggle({
            name = "EnableHPSMeter",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableHPSMeter"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableHPSMeter",
            on_callback = callback(self, self, "MainClbk")
        }),

        HPSRefreshRate = self.MainMenu:Slider({
            name = "HPSRefreshRate",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("HPSRefreshRate"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/HPSRefreshRate",
            min = 0.1,
            max = 10,
            step = 1,
            on_callback = callback(self, self, "MainClbk"),
            --enabled = NepgearsyHUDReborn:GetOption("EnableHPSMeter")
        }),

        ShowHPSCurrent = self.MainMenu:Toggle({
            name = "ShowHPSCurrent",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ShowHPSCurrent"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/ShowHPSCurrent",
            on_callback = callback(self, self, "MainClbk"),
            --enabled = NepgearsyHUDReborn:GetOption("EnableHPSMeter")
        }),

        CurrentHPSTimeout = self.MainMenu:Slider({
            name = "CurrentHPSTimeout",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("CurrentHPSTimeout"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/CurrentHPSTimeout",
            min = 1,
            max = 10,
            step = 1,
            on_callback = callback(self, self, "MainClbk"),
            --enabled = NepgearsyHUDReborn:GetOption("EnableHPSMeter")
        }),

        ShowHPSTotal = self.MainMenu:Toggle({
            name = "ShowHPSTotal",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ShowHPSTotal"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/ShowHPSTotal",
            on_callback = callback(self, self, "MainClbk"),
            --enabled = NepgearsyHUDReborn:GetOption("EnableHPSMeter")
        }),

        self.MainMenu:Divider({ size = 5 }),

        ColorWithSkinPanels = self.MainMenu:Toggle({
            name = "ColorWithSkinPanels",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ColorWithSkinPanels"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/ColorWithSkinPanels",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        EnableSteamAvatarsInChat = self.MainMenu:Toggle({
            name = "EnableSteamAvatarsInChat",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableSteamAvatarsInChat"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableSteamAvatarsInChat",
            on_callback = callback(self, self, "MainClbk")
        }),

        Scale = self.MainMenu:Slider({
            name = "Scale",
            border_left = true,
            offset_y = 20,
            value = NepgearsyHUDReborn:GetOption("Scale"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/Scale",
            help = "NepgearsyHUDRebornMenu/Buttons/HUD/ScaleHelp",
            min = 0.1,
            max = 1.5,
            step = 0.01,
            on_callback = callback(self, self, "SetHudScaleSpacing")
        }),

        Spacing = self.MainMenu:Slider({
            name = "Spacing",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("Spacing"),
            text = "NepgearsyHUDRebornMenu/Buttons/HUD/Spacing",
            help = "NepgearsyHUDRebornMenu/Buttons/HUD/ScaleHelp",
            min = 0.1,
            max = 1,
            step = 0.01,
            on_callback = callback(self, self, "SetHudScaleSpacing")
        })
    }

    self.MainMenu:Divider({ size = 10 })

    self.MainMenu:Button({
        name = "ResetHUDOptions",
        border_color = self.BorderColor,
        border_left = true,
        localized = true,
        text = "NepgearsyHUDRebornMenu/Buttons/ResetOption",
        on_callback = callback(self, self, "ResetHUD")
    })

    self:CreateSharedBackButton()
end

function NepHudMenu:InitMenuOptions()
    self:ClearMenu()

    self.MenuLobbyOptionsCat = self.MainMenu:Divider({
        name = "MenuLobbyOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/MenuLobbyOptionsCat",
        offset_y = 20,
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    self.MenuLobbyOptions = {
        EnableSteamAvatarsInLobby = self.MainMenu:Toggle({
            name = "EnableSteamAvatarsInLobby",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableSteamAvatarsInLobby"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/EnableSteamAvatarsInLobby",
            on_callback = callback(self, self, "MainClbk")
        }),

        HorizontalLoadout = self.MainMenu:Toggle({
            name = "EnableHorizontalLoadout",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableHorizontalLoadout"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/EnableHorizontalLoadout",
            on_callback = callback(self, self, "MainClbk")
        }),

        HorizontalPerkDeck = self.MainMenu:Toggle({
            name = "HorizontalPerkDeck",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("HorizontalPerkDeck"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/HorizontalPerkDeck",
            help = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/HorizontalPerkDeckHelp",
            on_callback = callback(self, self, "MainClbk"),
            --enabled = NepgearsyHUDReborn:GetOption("EnableHorizontalLoadout")
        }),

        self.MainMenu:Divider({ size = 5 }),

        StarringScreen = self.MainMenu:Toggle({
            name = "EnableStarring",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("EnableStarring"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringScreen",
            on_callback = callback(self, self, "MainClbk")
        }),

        StarringColor = self.MainMenu:ComboBox({
            name = "StarringColor",
            items = NepgearsyHUDReborn.colors,
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("StarringColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        StarringText = self.MainMenu:TextBox({
            name = "StarringText",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("StarringText"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringText",
            on_callback = callback(self, self, "MainClbk")
        }),

        ShowMapStarring = self.MainMenu:Toggle({
            name = "ShowMapStarring",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ShowMapStarring"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/ShowMapStarring",
            on_callback = callback(self, self, "MainClbk")
        }),

        ShowMapTexture = self.MainMenu:Toggle({
            name = "ShowMapTexture",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("ShowMapTexture"),
            text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/ShowMapTexture",
            help = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/ShowMapTextureHelp",
            on_callback = callback(self, self, "MainClbk"),
            --enabled = NepgearsyHUDReborn:GetOption("ShowMapStarring")
        })
    }

    self:CreateSharedBackButton()
end

function NepHudMenu:InitColorOptions()
    self:ClearMenu()

    self.ColorsCat = self.MainMenu:Divider({
        name = "ColorsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/ColorOptions",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    self.MainMenu:QuickText("NepgearsyHUDRebornMenu/Help/NewColors", { localized = true, size = 16 })

    self.Colors = {
        SoraCPColor = self.MainMenu:ColorTextBox({
            name = "SoraCPColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraCPColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/CPColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraCPBorderColor = self.MainMenu:ColorTextBox({
            name = "SoraCPBorderColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraCPBorderColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/CPBorderColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        HealthColor = self.MainMenu:ComboBox({
            name = "HealthColor",
            border_left = true,
            items = NepgearsyHUDReborn.colors,
            value = NepgearsyHUDReborn:GetOption("HealthColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/HealthColor",
            help = "NepgearsyHUDRebornMenu/Buttons/Colors/HealthColorHelp",
            on_callback = callback(self, self, "MainClbk")
        }),

        ShieldColor = self.MainMenu:ComboBox({
            name = "ShieldColor",
            border_left = true,
            items = NepgearsyHUDReborn.colors,
            value = NepgearsyHUDReborn:GetOption("ShieldColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/ShieldColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        SoraObjectiveColor = self.MainMenu:ColorTextBox({
            name = "SoraObjectiveColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraObjectiveColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/ObjectiveColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraInteractionColor = self.MainMenu:ColorTextBox({
            name = "SoraInteractionColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraInteractionColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/InteractionColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        SoraAssaultBarColor = self.MainMenu:ColorTextBox({
            name = "SoraAssaultBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraAssaultBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/AssaultBar",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraSurvivedBarColor = self.MainMenu:ColorTextBox({
            name = "SoraSurvivedBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraSurvivedBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/AssaultBarSurvived",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraStealthBarColor = self.MainMenu:ColorTextBox({
            name = "SoraStealthBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraStealthBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/AssaultBarStealth",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraPONRBarColor = self.MainMenu:ColorTextBox({
            name = "SoraPONRBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraPONRBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/AssaultBarPONR",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraWintersBarColor = self.MainMenu:ColorTextBox({
            name = "SoraWintersBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraWintersBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/AssaultBarWinters",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        SoraPeerOneColor = self.MainMenu:ColorTextBox({
            name = "SoraPeerOneColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraPeerOneColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/PeerOneColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraPeerTwoColor = self.MainMenu:ColorTextBox({
            name = "SoraPeerTwoColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraPeerTwoColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/PeerTwoColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraPeerThreeColor = self.MainMenu:ColorTextBox({
            name = "SoraPeerThreeColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraPeerThreeColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/PeerThreeColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraPeerFourColor = self.MainMenu:ColorTextBox({
            name = "SoraPeerFourColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraPeerFourColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/PeerFourColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        SoraAIColor = self.MainMenu:ColorTextBox({
            name = "SoraAIColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("SoraAIColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/AIColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        self.MainMenu:Divider({ size = 5 }),

        StaminaBarColor = self.MainMenu:ColorTextBox({
            name = "StaminaBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("StaminaBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/StaminaBarColor",
            on_callback = callback(self, self, "MainClbk")
        }),

        LowStaminaBarColor = self.MainMenu:ColorTextBox({
            name = "LowStaminaBarColor",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("LowStaminaBarColor"),
            text = "NepgearsyHUDRebornMenu/Buttons/Colors/LowStaminaBarColor",
            on_callback = callback(self, self, "MainClbk")
        })
    }

    self.MainMenu:Divider({ size = 10 })

    self.MainMenu:Button({
        name = "ResetColors",
        border_color = self.BorderColor,
        border_left = true,
        localized = true,
        text = "NepgearsyHUDRebornMenu/Buttons/ResetOption",
        on_callback = callback(self, self, "ResetColors")
    })

    self:CreateSharedBackButton()
end

function NepHudMenu:InitTeammateSkins()
    self:ClearMenu()
    self:ClearSkinMenu()
    self:VisOptionalMenuParts(false)

    self.TeammateSkinsHeader = self.MainMenu:Divider({
        name = "TeammateSkinsHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkinsHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    self.MainMenu:Divider({
        name = "SkinExplaination",
        text = "NepgearsyHUDRebornMenu/Help/TeammateSkinsExplaination",
        localized = true
    })

    self.MainMenu:Divider({
        name = "SkinEquippedHeader",
        text = "NepgearsyHUDRebornMenu/Help/SkinEquipped",
        background_color = Color(0, 0, 0),
        text_align = "center",
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    local skin_w = NepgearsyHUDReborn:IsTeammatePanelWide() and 168 or 154
    local skin_h = NepgearsyHUDReborn:IsTeammatePanelWide() and 68 or 45

    self.EquippedSkin = self.MainMenu:Image({
        name = "EquippedSkin",
        texture = NepgearsyHUDReborn:GetTeammateSkinBySave(),
        w = skin_w,
        h = skin_h,
        offset_x = 82,
        offset_y = 10
    })

    self:CreateSharedBackButton()

    self.TeammateSkins:SetVisible(true)

    self.TeammateSkinsCategory = self.TeammateSkins:Holder({
        background_color = Color(0.5, 0, 0, 0),
        w = self.TeammateSkins:W(),
        align_method = "grid"
    })

    for _, category_id in ipairs(NepgearsyHUDReborn.TeammateSkinsCollectionLegacy) do
        self.TeammateSkinsCategory:ImageButton({
            texture = "NepgearsyHUDReborn/HUD/TeammateSkinsCategories/" .. category_id,
            w = 48,
            h = 48,
            on_callback = callback(self, self, "ClbkSkinChangeCat", category_id),
            border_bottom = true
        })
    end

    if self.CurrentTeammateSkinCategory == "community" then
        self.TeammateSkins:Divider({
            text = "NepgearsyHUDRebornMenu/Help/CommunityHelpText",
            localized = true,
            text_align = "center",
            background_color = Color(0.5, 0, 0, 0)
        })
    end

    for category_id, category_title in pairs(NepgearsyHUDReborn.TeammateSkinsCollection) do
        if category_id == self.CurrentTeammateSkinCategory then
            self.TeammateSkins:Divider({
                name = "DefaultHeader",
                text = tostring(category_title),
                background_color = Color(0, 0, 0),
                text_align = "center",
                localized = true,
                text_vertical = "center",
                font_size = 20,
                font = NepgearsyHUDReborn:SetFont(font)
            })

            self:GenerateSkinButtonsByCat(category_id)

            break
        end
    end
end

function NepHudMenu:GenerateSkinButtonsByCat(category)
    for skin_id, skin_data in pairs(NepgearsyHUDReborn.TeammateSkins) do
        if category == skin_data.collection then
            if not skin_data.dev then
                local author = skin_data.author
                local name = skin_data.name
                local texture = skin_data.texture

                local skin_button_panel = self.TeammateSkins:Button({
                    name = "skin_button_panel_" .. author .. name,
                    text = "",
                    w = 154 * 1.22,
                    h = 65,
                    border_left = true,
                    border_color = self.BorderColor,
                    offset_x = 5,
                    offset_y = 15,
                    background_color = Color(0.35, 0, 0, 0),
                    on_callback = callback(self, self, "SkinSetClbk", skin_id),
                    enabled = not NepgearsyHUDReborn:IsTeammatePanelWide() or skin_data.wide_counterpart
                })

                local skin_button = skin_button_panel:Image({
                    name = "skin_button_" .. author .. name,
                    texture = texture,
                    w = 154,
                    h = 45,
                    offset_y = 5,
                    position = "CenterTop"
                })

                local skin_title = skin_button_panel:Divider({
                    text = name .. " by " .. author,
                    font = "fonts/font_large_mf",
                    background_color = Color.transparent,
                    font_size = 14,
                    offset_y = -5,
                    position = "CenterBottom",
                    text_align = "center"
                })

                --[[
                local skin_panel = self.TeammateSkins:Panel()
                local skin_button_panel = skin_button:Panel()

                local skin_title = skin_panel:text({
                    text = name,
                    font = font,
                    color = Color.white,
                    font_size = 16
                })
                skin_title:set_top(skin_button_panel:bottom() - 3)
                skin_title:set_left(skin_button_panel:left())
                ]]
            end
        end
    end
end

function NepHudMenu:ClbkSkinChangeCat(category)
    self.CurrentTeammateSkinCategory = category
    self:InitTeammateSkins()
end

function NepHudMenu:InitDiscordRichPresence()
    self:ClearMenu()

    local has_presence_active = false
    local status = {
        text = "NepgearsyHUDRebornMenu/Status/DiscordRichPresenceInactive",
        color = Color(1, 0.5, 0)
    }
    if NepgearsyHUDReborn:GetOption("UseDiscordRichPresence") then
        status.text = "NepgearsyHUDRebornMenu/Status/DiscordRichPresenceActive"
        status.color = Color.green
        has_presence_active = true
    end

    self.DiscordRichPresenceHeader = self.MainMenu:Divider({
        name = "DiscordRichPresenceHeader",
        text = "NepgearsyHUDRebornMenu/Header/DiscordRichPresenceHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        text_vertical = "center",
        offset_y = 5,
        font_size = 20,
        font = NepgearsyHUDReborn:SetFont(font)
    })

    self.PresenceVersionCheck = self.MainMenu:Divider({
        name = "PresenceVersionCheck",
        text = status.text,
        foreground = status.color,
        background_color = Color(0.25, 0, 0, 0),
        text_align = "center",
        text_vertical = "center",
        offset_y = 5,
        font_size = 14,
        font = "fonts/font_large_mf"
    })

    self.DiscordRichPresenceHelp = self.MainMenu:Divider({
        name = "DiscordRichPresenceHelp",
        text = "NepgearsyHUDRebornMenu/Help/DiscordRichPresenceHelp",
        background_color = Color(0.25, 0, 0, 0),
        text_vertical = "center",
        offset_y = 20,
        font_size = 14,
        font = "fonts/font_large_mf"
    })

    self.DiscordRichPresencePicHelp = self.MainMenu:Image({
        name = "DiscordRichPresencePicHelp",
        texture = "NepgearsyHUDReborn/Menu/DiscordRichPresence",
        h = 386 / 1.25,
        w = 368 / 1.25
    })

    self.DiscordOptions = {
        UseDiscordRichPresence = self.MainMenu:Toggle({
            name = "UseDiscordRichPresence",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("UseDiscordRichPresence"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/UseDiscordRichPresence",
            on_callback = callback(self, self, "MainClbk")
        }),

        DiscordRichPresenceType = self.MainMenu:ComboBox({
            name = "DiscordRichPresenceType",
            border_left = true,
            items = NepgearsyHUDReborn.DiscordRichPresenceTypes,
            value = NepgearsyHUDReborn:GetOption("DiscordRichPresenceType"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/DiscordRichPresenceType",
            on_callback = callback(self, self, "MainClbk"),
            enabled = has_presence_active
        }),

        DiscordRichPresenceLargeImageType = self.MainMenu:ComboBox({
            name = "DiscordRichPresenceLargeImageType",
            border_left = true,
            items = NepgearsyHUDReborn.DiscordRichPresenceLargeImageTypes,
            value = NepgearsyHUDReborn:GetOption("DiscordRichPresenceLargeImageType"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/DiscordRichPresenceLargeImageType",
            help = "NepgearsyHUDRebornMenu/Buttons/Menu/DiscordRichPresenceLargeImageTypeHelp",
            on_callback = callback(self, self, "MainClbk"),
            enabled = has_presence_active
        }),

        DRPAllowTimeElapsed = self.MainMenu:Toggle({
            name = "DRPAllowTimeElapsed",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("DRPAllowTimeElapsed"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/DRPAllowTimeElapsed",
            on_callback = callback(self, self, "MainClbk"),
            enabled = has_presence_active
        }),

        DiscordUsername = self.MainMenu:Toggle({
            name = "DiscordUsername",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("DiscordUsername"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/DiscordUsername",
            on_callback = callback(self, self, "MainClbk"),
            enabled = has_presence_active
        }),

        DiscordUsernameCustom = self.MainMenu:TextBox({
            name = "DiscordUsernameCustom",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("DiscordUsernameCustom"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/DiscordUsernameCustom",
            on_callback = callback(self, self, "MainClbk"),
            enabled = has_presence_active
        }),

        DiscordRichPresenceCustomLimitation = self.MainMenu:Divider({
            name = "DiscordRichPresenceCustomLimitation",
            text = "NepgearsyHUDRebornMenu/Help/DiscordCustomPresenceLimitation",
            background_color = Color(0.25, 0, 0, 0),
            text_vertical = "center",
            font_size = 14,
            font = "fonts/font_large_mf"
        }),

        DiscordRichPresenceCustom = self.MainMenu:TextBox({
            name = "DiscordRichPresenceCustom",
            border_left = true,
            value = NepgearsyHUDReborn:GetOption("DiscordRichPresenceCustom"),
            text = "NepgearsyHUDRebornMenu/Buttons/Menu/DiscordRichPresenceCustom",
            on_callback = callback(self, self, "MainClbk"),
            enabled = has_presence_active
        })
    }

    self:CreateSharedBackButton()
end

function NepHudMenu:CreateSharedBackButton()
    self.SharedBackButtonMenu = self.MainMenu:Button({
        name = "HUDOptionsButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/Back",
        offset_y = 30,
        localized = true,
        on_callback = callback(self, self, "InitMainMenu")
    })
end

function NepHudMenu:ClearMenu()
    self.MainMenu:ClearItems()
end

function NepHudMenu:ClearSkinMenu()
    self.TeammateSkins:ClearItems()
end

function NepHudMenu:InitCollab()
    self.CollabMenu = self._menu:Menu({
        name = "CollabMenu",
        background_color = MenuBgs,
        h = 270,
        w = self._menu._panel:w() / 2.1,
        scrollbar = true,
        offset = 8,
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom() + 15)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    self.CollabMenuHeader = self.CollabMenu:Divider({
        name = "CollabMenuHeader",
        text = "NepgearsyHUDRebornMenu/Collaborators/Header",
        localized = true,
        font = NepgearsyHUDReborn:SetFont(font),
        size = 20,
        background_color = Color(0.75, 0, 0, 0),
        highlight_color = Color(0.75, 0, 0, 0),
        text_vertical = "center",
        text_align = "center"
    })

    for i, collab_data in ipairs(NepgearsyHUDReborn.creators) do
        local built_steam_url = nil
        local cbk = nil
        if collab_data.steam_id then
            built_steam_url = "https://steamcommunity.com/profiles/" .. collab_data.steam_id
            cbk = callback(self, self, "open_url", built_steam_url)
        end

        local Collaborator = self.CollabMenu:Button({
            name = "Collaborator_" .. i,
            h = 24,
            text = "",
            border_left = false,
            background_color = MenuBgs,
            highlight_color = HighlightColor,
            on_callback = cbk
        })

        local CollabPanel = Collaborator:Panel()
        local CollabAvatar = CollabPanel:bitmap({
            texture = "guis/textures/pd2/none_icon",
            h = CollabPanel:h(),
            w = CollabPanel:h(),
            x = 5,
            layer = BaseLayer
        })

        if collab_data.steam_id then
            NepgearsyHUDReborn:SteamAvatar(collab_data.steam_id, function(texture)
                if texture then
                    CollabAvatar:set_image(texture)
                end
            end, {refresh = true})
        end

        local CollabName = CollabPanel:text({
            text = collab_data.name,
            font = NepgearsyHUDReborn:SetFont(font),
            font_size = 18,
            color = i == 1 and Color(0.63, 0.58, 0.95) or Color.white,
            layer = BaseLayer,
            vertical = "center"
        })
        CollabName:set_left(CollabAvatar:right() + 5)

        local CollabAction = CollabPanel:text({
            text = collab_data.desc,
            font = "fonts/font_large_mf",
            font_size = 18,
            color = Color(0.5, 0.5, 0.5),
            layer = BaseLayer,
            vertical = "center",
            align = "right",
            x = -5
        })
    end
end

function NepHudMenu:InitChangelog()
    self.ChangelogMenu = self._menu:Holder({
        name = "ChangelogMenu",
        background_color = MenuBgs,
        h = 320,
        offset = 8,
        w = self._menu._panel:w() / 2.1,
        position = function(item)
            item:Panel():set_top(self.CollabMenu:Panel():bottom() + 10)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    --[[
    self.ChangelogMenuHeader = self.ChangelogMenu:Divider({
        name = "ChangelogMenuHeader",
        text = managers.localization:text("NepgearsyHUDRebornMenu/Changelog/Header", { version = NepgearsyHUDReborn.Version }),
        localized = false,
        font = font,
        font_size = 20,
        background_color = Color(0.75, 0, 0, 0),
        highlight_color = Color(0.75, 0, 0, 0),
        text_vertical = "center",
        text_align = "center"
    })

    self.Changelog = self.ChangelogMenu:Divider({
        text = NepgearsyHUDReborn.Changelog,
        font = "fonts/font_large_mf",
        font_size = 16,
        border_color = self.BorderColor,
        highlight_color = Color.transparent,
        border_left = true,
        localized = false,
        on_callback = callback(self, self, "open_url", "https://github.com/AzureeDev/Sora-HUD-Reborn/commits/master")
    })
    ]]

    local notebook = self.ChangelogMenu:NoteBook({
        name = "Changelog",
        auto_height = false,
        h = self.ChangelogMenu:H() - 15
    })

    for i, data in ipairs(SoraHUDChangelog.log) do
        notebook:AddItemPage(data.label, SoraHUDChangelog:DrawVersion(notebook, i))
    end
end

function NepHudMenu:InitBack()
    self.BackMenu = self._menu:Holder({
        name = "BackMenu",
        background_color = MenuBgs,
        h = 50,
        w = self._menu._panel:w() / 2.1,
        position = function(item)
            item:Panel():set_top(self.ChangelogMenu:Panel():bottom() + 10)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    self.BackButton = self.BackMenu:Button({
        name = "BackButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/Close",
        background_color = MenuBgs,
        highlight_color = HighlightColor,
        position = "Center",
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        on_callback = callback(self._menu, self._menu, "SetEnabled", false)
    })
end

function NepHudMenu:open_url(url)
    if Steam:overlay_enabled() then
        Steam:overlay_activate("url", url)
    else
        os.execute("start /min " .. url)
    end
end

function NepHudMenu:ResetHUD()
    for option_name, _ in pairs(self.HUDOptions) do
        local option = NepgearsyHUDReborn.Options:GetOption(option_name)

        if option then
            self.HUDOptions[option_name]:SetValue(option.default_value)
            NepgearsyHUDReborn:SetOption(option_name, option.default_value)
        end
    end
end

function NepHudMenu:ResetColors()
    for option_name, _ in pairs(self.Colors) do
        local option = NepgearsyHUDReborn.Options:GetOption(option_name)

        if option then
            self.Colors[option_name]:SetValue(option.default_value)
            NepgearsyHUDReborn:SetOption(option_name, option.default_value)
        end

        if option_name == "SoraCPColor" then
            self.ColorBG:set_color(option.default_value)
        end
    end
end

function NepHudMenu:SetBackgroundVis(vis)
    self.Background:set_visible(vis)
    self.ColorBG:set_visible(vis)
end

function NepHudMenu:VisOptionalMenuParts(state)
    if self.CollabMenu and self.ChangelogMenu then
        self.CollabMenu:SetVisible(state)
        self.ChangelogMenu:SetVisible(state)
    end
end

function NepHudMenu:background_switch()
    local enabled = not self._background_enabled
    self._background_enabled = enabled

    self:SetBackgroundVis(enabled)
    self:VisOptionalMenuParts(enabled)
    self.BackgroundEnabler:SetImage(enabled and "NepgearsyHUDReborn/Menu/DisableBackground" or "NepgearsyHUDReborn/Menu/EnableBackground")
end

function NepHudMenu:MainClbk(item)
    if item then
        NepgearsyHUDReborn:SetOption(item.name, item:Value())

        if item.name == "SoraCPColor" then
            --local new_color = NepgearsyHUDReborn:StringToColor("cpcolor", NepgearsyHUDReborn:GetOption("CPColor"))
            self.ColorBG:set_color(item:Value())
        end

        if item.name == "ForcedLocalization" then
            if NepgearsyHUDReborn:IsLanguageFontLimited(item:Value()) then
                local enabled = self._background_enabled
                if enabled then
                    self:background_switch()
                end

                QuickMenu:new(
                    managers.localization:text("dialog_warning_title"),
                    "This localization may not support fonts beyond font_large_mf.",
                    {
                        {
                            text = managers.localization:text("dialog_ok"),
                            is_cancel_button = true,
                            callback = function()
                                if enabled and not self._background_enabled then
                                    self:background_switch()
                                end
                            end
                        }
                    },
                    true
                )
            end
        end

        if item.name == "UseDiscordRichPresence" then
            local enabled = self._background_enabled
            if enabled then
                self:background_switch()
            end

            QuickMenu:new(
                managers.localization:text("dialog_warning_title"),
                "The game needs to restart to apply this change. Do you want to quit now?",
                {
                    {
                        text = managers.localization:text("dialog_yes"),
                        callback = callback(Setup, Setup, "quit"),
                    },
                    {
                        text = managers.localization:text("dialog_no"),
                        is_cancel_button = true,
                        callback = function()
                            if enabled and not self._background_enabled then
                                self:background_switch()
                            end
                        end
                    }
                },
                true
            )
        end
    end
end

function NepHudMenu:SkinSetClbk(skin_id)
    if skin_id then
        NepgearsyHUDReborn:SetOption("TeammateSkin", skin_id)
        self.EquippedSkin:SetImage(NepgearsyHUDReborn:GetTeammateSkinById(skin_id))
    end
end

function NepHudMenu:SetHudScaleSpacing(item)
    NepgearsyHUDReborn:SetOption(item:Name(), item:Value())
    if managers.hud and managers.hud.recreate_player_info_hud_pd2 then
        if NepgearsyHUDReborn:IsTeammatePanelWide() then
            managers.gui_data:layout_scaled_fullscreen_workspace(managers.hud._saferect, 0.95, 1)
            managers.hud:recreate_player_info_hud_pd2()
            return
        end

        managers.gui_data:layout_scaled_fullscreen_workspace(managers.hud._saferect, NepgearsyHUDReborn:GetOption("Scale"), NepgearsyHUDReborn:GetOption("Spacing"))
        managers.hud:recreate_player_info_hud_pd2()
    end
end
