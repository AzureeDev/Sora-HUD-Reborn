local BaseLayer = 1500
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
		use_default_close_key = true,
		background_color = Color.transparent,
		inherit_values = {
			background_color = Color(0.3, 0, 0, 0),
			scroll_color = Color.white:with_alpha(0.1),
			highlight_color = HighlightColor
		},
        animate_toggle = true
    })
    self._menu_panel = self._menu._panel
    self.BackgroundStatus = true
    self.BorderColor = NepgearsyHUDReborn:StringToColor("cpbordercolor", NepgearsyHUDReborn:GetOption("CPBorderColor"))

    self:InitTopBar()
    self:InitBackground()
    self:InitMenu()
    self:InitCollab()
    self:InitChangelog()
    self:InitBack()

    MenuCallbackHandler.NepgearsyHUDRebornMenu = ClassClbk(self._menu, "SetEnabled", true)
    MenuHelperPlus:AddButton({
        id = "NepgearsyHUDRebornMenu",
        title = "NepgearsyHUDRebornMenu",
        node_name = "blt_options",
        callback = "NepgearsyHUDRebornMenu"
    })
end

function NepHudMenu:InitTopBar()
    self.TopBar = self._menu:Menu({
        name = "TopBar",
        background_color = Color(0.05, 0.05, 0.05),
		h = 30,
		text_offset = 0,
		align_method = "grid",
        w = self._menu_panel:w(),
        scrollbar = false,
        position = "Top"
    })

    self.HUDName = self.TopBar:Divider({
		text = managers.localization:to_upper_text("NepgearsyHUDReborn"),
        font = Font,
		size = 25,
		border_left = false,
		size_by_text = true,
        color = Color(0.8, 0.8, 0.8),
        layer = BaseLayer,
    })

    local BackgroundEnabler = self.TopBar:ImageButton({
        name = "BackgroundEnabler",
        texture = "NepgearsyHUDReborn/Menu/DisableBackground",
        w = 26,
        h = 26,
        offset_x = 20,
        help = "Enable or disable the background, and optional parts of the menu.",
        on_callback = ClassClbk(self, "background_enable_switch")
    })
    self.BackgroundEnabler = BackgroundEnabler

    local MWSProfile = self.TopBar:ImageButton({
        name = "MWSProfile",
        texture = "NepgearsyHUDReborn/Menu/MWSProfile",
        w = 26,
        h = 26,
        offset_x = 5,
        help = "Go to the mod's page.",
        on_callback = ClassClbk(self, "open_url", "https://modworkshop.net/mydownloads.php?action=view_down&did=22152")
    })
    self.MWSProfile = MWSProfile
    local Discord = self.TopBar:ImageButton({
        name = "Discord",
        texture = "NepgearsyHUDReborn/Menu/Discord",
        w = 26,
        h = 26,
        offset_x = 5,
        help = "Join our Discord Modserver!",
        on_callback = ClassClbk(self, "open_url", "https://discord.gg/yy6cxwZ")
    })

    local HUDVersion = self.TopBar:Button({
        name = "HUDVersion",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/Version", { version = NepgearsyHUDReborn.Version }),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(0.4, 0.4, 0.4),
        foreground_highlight = self.BorderColor,
        position = "RightOffset-x",
		offset_x = 5,
        localized = false,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 25,
        font = Font,
        on_callback = ClassClbk(self, "open_url", "https://github.com/Nepgearsy/Nepgearsy-HUD-Reborn/commits/master")
    })

    local PostIssue = self.TopBar:Button({
        name = "PostIssue",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/PostIssue"),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(1, 0, 0),
        foreground_highlight = Color(1, 0, 0),
        position = function(item)
            item:Panel():set_right(HUDVersion:Panel():left() - 15)
            item:Panel():set_world_center_y(self.TopBar:Panel():world_center_y())
        end,
        localized = false,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 15,
        font = Font,
        on_callback = ClassClbk(self, "open_url", "https://github.com/Nepgearsy/Nepgearsy-HUD-Reborn/issues")
    })

    local PostRequest = self.TopBar:Button({
        name = "PostRequest",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/PostRequest"),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(1, 1, 1),
        foreground_highlight = self.BorderColor,
        position = function(item)
            item:Panel():set_right(PostIssue:Panel():left() - 15)
        end,
        localized = false,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 15,
        font = Font,
        on_callback = ClassClbk(self, "open_url", "https://feathub.com/Nepgearsy/Nepgearsy-HUD-Reborn")
    })
    PostRequest:Panel():set_world_center_y(self.TopBar:Panel():world_center_y())
end


function NepHudMenu:InitBackground()
    local Background = self._menu_panel:bitmap({
        name = "Background",
        w = self._menu_panel:w(),
        h = self._menu_panel:h() - self.TopBar:Panel():h(),
        texture = "NepgearsyHUDReborn/Menu/NepHudMenu",
        alpha = 0.9
    })
    Background:set_top(self.TopBar:Panel():bottom())

    local ColorBG = self._menu_panel:bitmap({
        name = "ColorBG",
        w = self._menu_panel:w(),
        h = self._menu_panel:h() - self.TopBar:Panel():h(),
        texture = "NepgearsyHUDReborn/Menu/BGColor",
        color = NepgearsyHUDReborn:StringToColor("cpcolor", NepgearsyHUDReborn.Options:GetValue("CPColor")),
        layer = -2
    })
    ColorBG:set_top(self.TopBar:Panel():bottom())

    self.ColorBG = ColorBG
end

function NepHudMenu:SetBackgroundVis(vis)
    local Background = self._menu_panel:child("Background")
    Background:set_visible(vis)
    self.ColorBG:set_visible(vis)
end

function NepHudMenu:InitMenu()
    self.MainMenu = self._menu:Menu({
        name = "MainMenu",
        h = self._menu_panel:h() - self.TopBar:Panel():h(),
		w = self._menu_panel:w() / 4,
		size = 15,
		border_color = self.BorderColor,
		offset = 8,
		text_align = "left",
		text_vertical = "center",
		localized = true,
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom())
            item:Panel():set_right(self._menu_panel:right())
        end
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
        items = NepgearsyHUDReborn.LocalizationTable,
        value = NepgearsyHUDReborn.Options:GetValue("ForcedLocalization"),
        text = "NepgearsyHUDRebornMenu/ForcedLocalization",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.MainMenuOptionsCat = self.MainMenu:Divider({
        name = "MainMenuOptionsCat",
		text = "NepgearsyHUDRebornMenu/Buttons/MainMenuOptionsCat",
		offset_y = 20,
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
        font_size = 20,
        font = Font
    })

    self.MainMenuOptions = {}
    self.MainMenuOptions.HUDOptionsButton = self.MainMenu:Button({
        name = "HUDOptionsButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/HUDOptionsButton",
        localized = true,
        on_callback = ClassClbk(self, "InitHUDOptions")
    })

    self.MainMenuOptions.MenuOptionsButton = self.MainMenu:Button({
        name = "MenuOptionsButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/MenuOptionsButton",
        localized = true,
        on_callback = ClassClbk(self, "InitMenuOptions")
    })

    self.MainMenuOptions.ColorOptionsButton = self.MainMenu:Button({
        name = "ColorOptionsButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/ColorOptionsButton",
        localized = true,
        on_callback = ClassClbk(self, "InitColorOptions")
    })

    self.MainMenuOptions.TeammatePanelSkinButton = self.MainMenu:Button({
        name = "TeammatePanelSkinButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/TeammatePanelSkinButton",
        localized = true,
        on_callback = ClassClbk(self, "InitTeammateSkins")
    })
end

function NepHudMenu:InitHUDOptions()
    self:ClearMenu()

    self.HUDOptionsCat = self.MainMenu:Divider({
        name = "HUDOptionsCat",
		text = "NepgearsyHUDRebornMenu/Buttons/HUDOptionsCat",
		offset_y = 20,
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
        font_size = 20,
        font = Font
    })

    self.HUDOptions = {}
    self.HUDOptions.AssaultBar = self.MainMenu:ComboBox({
        name = "AssaultBarFont",
        border_left = true,
        items = NepgearsyHUDReborn.AssaultBarFonts,
        value = NepgearsyHUDReborn.Options:GetValue("AssaultBarFont"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultBarFont",
        on_callback = ClassClbk(self, "MainClbk")
    })

	self.HUDOptions.PlayerNameFont = self.MainMenu:ComboBox({
        name = "PlayerNameFont",
        border_left = true,
        items = NepgearsyHUDReborn.PlayerNameFonts,
        value = NepgearsyHUDReborn.Options:GetValue("PlayerNameFont"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/PlayerNameFont",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.Minimap = self.MainMenu:Toggle({
        name = "EnableMinimap",
		border_left = true,
		offset_y = 20,
        value = NepgearsyHUDReborn.Options:GetValue("EnableMinimap"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Minimap",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.MinimapForce = self.MainMenu:Toggle({
        name = "MinimapForce",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("MinimapForce"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapForce",
        help = "Force the minimap anytime, even if the current map doesn't have a texture for it.",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.MinimapSize = self.MainMenu:Slider({
        name = "MinimapSize",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("MinimapSize"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapSize",
        min = 150,
        max = 200,
        step = 1,
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.MinimapZoom = self.MainMenu:Slider({
        name = "MinimapZoom",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("MinimapZoom"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapZoom",
        min = 0.25,
        max = 1,
        step = 0.01,
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.Trackers = self.MainMenu:Toggle({
        name = "EnableTrackers",
		border_left = true,
		offset_y = 20,
        value = NepgearsyHUDReborn.Options:GetValue("EnableTrackers"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Trackers",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.CopTracker = self.MainMenu:Toggle({
        name = "EnableCopTracker",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableCopTracker"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/CopTracker",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.TrueAmmo = self.MainMenu:Toggle({
        name = "EnableTrueAmmo",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableTrueAmmo"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/TrueAmmo",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.HealthStyle = self.MainMenu:ComboBox({
        name = "HealthStyle",
        items = NepgearsyHUDReborn.HealthStyle,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("HealthStyle"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/HealthStyle",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.StatusNumberType = self.MainMenu:ComboBox({
        name = "StatusNumberType",
        items = NepgearsyHUDReborn.StatusNumberType,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("StatusNumberType"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/StatusNumberType",
        on_callback = ClassClbk(self, "MainClbk")
    })

	self.HUDOptions.EnablePlayerLevel = self.MainMenu:Toggle({
        name = "EnablePlayerLevel",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnablePlayerLevel"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnablePlayerLevel",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.EnableSteamAvatars = self.MainMenu:Toggle({
        name = "EnableSteamAvatars",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableSteamAvatars"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableSteamAvatars",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.EnableInteraction = self.MainMenu:Toggle({
        name = "EnableInteraction",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableInteraction"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/EnableInteraction",
        on_callback = ClassClbk(self, "MainClbk")
    })
    
    self.HUDOptions.Scale = self.MainMenu:Slider({
        name = "Scale",
		border_left = true,
		offset_y = 20,
        value = NepgearsyHUDReborn.Options:GetValue("Scale"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Scale",
        help = "If in-game, restart the map to take effect",
        min = 0.1,
        max = 1.5,
        step = 0.01,
        on_callback = ClassClbk(self, "SetHudScaleSpacing")
    })

    self.HUDOptions.Spacing = self.MainMenu:Slider({
        name = "Spacing",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("Spacing"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Spacing",
        help = "If in-game, restart the map to take effect",
        min = 0.1,
        max = 1,
        step = 0.01,
        on_callback = ClassClbk(self, "SetHudScaleSpacing")
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
        font = Font
    })

    self.MenuLobbyOptions = {}
    self.MenuLobbyOptions.StarringScreen = self.MainMenu:Toggle({
        name = "EnableStarring",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableStarring"),
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringScreen",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.MenuLobbyOptions.StarringColor = self.MainMenu:ComboBox({
        name = "StarringColor",
        items = NepgearsyHUDReborn.StarringColors,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("StarringColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.MenuLobbyOptions.StarringText = self.MainMenu:TextBox({
        name = "StarringText",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("StarringText"),
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringText",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.MenuLobbyOptions.HorizontalLoadout = self.MainMenu:Toggle({
        name = "EnableHorizontalLoadout",
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableHorizontalLoadout"),
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/HorizontalLoadout",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self:CreateSharedBackButton()
end

function NepHudMenu:InitColorOptions()
    self:ClearMenu()

    self.ColorsCat = self.MainMenu:Divider({
        name = "ColorsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/ColorsCat",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        text_align = "center",
		text_vertical = "center",
		offset_y = 20,
        font_size = 20,
        font = Font
    })
    self.Colors = {}
    self.Colors.CPColor = self.MainMenu:ComboBox({
        name = "CPColor",
        border_left = true,
        items = NepgearsyHUDReborn.CPColors,
        value = NepgearsyHUDReborn.Options:GetValue("CPColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/CPColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.CPBorderColor = self.MainMenu:ComboBox({
        name = "CPBorderColor",
        border_left = true,
        items = NepgearsyHUDReborn.CPBorderColors,
        value = NepgearsyHUDReborn.Options:GetValue("CPBorderColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/CPBorderColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.HealthColor = self.MainMenu:ComboBox({
        name = "HealthColor",
        border_left = true,
        items = NepgearsyHUDReborn.HealthColor,
        value = NepgearsyHUDReborn.Options:GetValue("HealthColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/HealthColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.ShieldColor = self.MainMenu:ComboBox({
        name = "ShieldColor",
        border_left = true,
        items = NepgearsyHUDReborn.ArmorColor,
        value = NepgearsyHUDReborn.Options:GetValue("ShieldColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/ShieldColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.ObjectiveColor = self.MainMenu:ComboBox({
        name = "ObjectiveColor",
        border_left = true,
        items = NepgearsyHUDReborn.ObjectiveColor,
        value = NepgearsyHUDReborn.Options:GetValue("ObjectiveColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/ObjectiveColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.InteractionColor = self.MainMenu:ComboBox({
        name = "InteractionColor",
        border_left = true,
        items = NepgearsyHUDReborn.InteractionColor,
        value = NepgearsyHUDReborn.Options:GetValue("InteractionColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/InteractionColor",
        on_callback = ClassClbk(self, "MainClbk")
    })

    self:CreateSharedBackButton()
end

function NepHudMenu:InitTeammateSkins()
    self:ClearMenu()
    self:VisOptionalMenuParts(false)

    local TeammateSkinsHeader = self.MainMenu:Divider({
        name = "TeammateSkinsHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkinsHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
		text_vertical = "center",
		offset_y = 20,
        font_size = 20,
        font = Font
    })

    self.MainMenu:Button({
        name = "SkinExplaination",
        border_color = self.BorderColor,
        border_left = true,
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
        font = Font
    })

    self.EquippedSkin = self.MainMenu:ImageButton({
        name = "EquippedSkin",
        texture = NepgearsyHUDReborn:GetTeammateSkinBySave(),
        w = 154,
        h = 45,
        offset_x = 82,
        offset_y = 10
    })

    self:CreateSharedBackButton()

    self.TeammateSkins = self._menu:Menu({
        name = "TeammateSkins",
        background_color = Color(0.3, 0, 0, 0),
		h = 600,
		scrollbar = true,
        w = self._menu_panel:w() / 2.1,
        align_method = "grid",
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom() + 15)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    self.TeammateSkins:Divider({
        name = "DefaultHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/DefaultHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        localized = true,
		text_vertical = "center",
        font_size = 20,
        font = Font
    })

    self:GenerateSkinButtonsByCat("default")

    self.TeammateSkins:Divider({
        name = "HDNHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/HDNHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        localized = true,
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = Font
    })

    self:GenerateSkinButtonsByCat("hdn")

    self.TeammateSkins:Divider({
        name = "SuguriHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/SuguriHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        localized = true,
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = Font
    })

    self:GenerateSkinButtonsByCat("suguri")

    self.TeammateSkins:Divider({
        name = "PlushHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/PlushHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        localized = true,
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = Font
    })

    self:GenerateSkinButtonsByCat("plush")

    self.TeammateSkins:Divider({
        name = "OtherHeader",
        text = "NepgearsyHUDRebornMenu/Buttons/TeammateSkin/OtherHeader",
        background_color = Color(0, 0, 0),
        text_align = "center",
        localized = true,
        text_vertical = "center",
        offset_y = 20,
        font_size = 20,
        font = Font
    })

    self:GenerateSkinButtonsByCat("other")
end

function NepHudMenu:GenerateSkinButtonsByCat(category)
    for skin_id, skin_data in pairs(NepgearsyHUDReborn.TeammateSkins) do
        if category == skin_data.collection then
            local author = skin_data.author
            local name = skin_data.name
            local texture = skin_data.texture

            local skin_button = self.TeammateSkins:ImageButton({
                name = "skin_button_" .. author .. name,
                texture = texture,
                w = 154,
                h = 45,
                offset_x = 35,
                offset_y = 20,
                help = name .. ", created by " .. author,
                on_callback = ClassClbk(self, "SkinSetClbk", skin_id)
            })
--[[
            local skin_panel = self.TeammateSkins:Panel()
            local skin_button_panel = skin_button:Panel()

            local skin_title = skin_panel:text({
                text = name,
                font = Font,
                color = Color.white,
                font_size = 16
            })
            skin_title:set_top(skin_button_panel:bottom() - 3)
            skin_title:set_left(skin_button_panel:left())--]]
        end
    end
end

function NepHudMenu:CreateSharedBackButton()
    self.SharedBackButtonMenu = self.MainMenu:Button({
        name = "HUDOptionsButton",
        border_color = self.BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/Back",
        offset_y = 30,
        localized = true,
        on_callback = ClassClbk(self, "InitMainMenu")
    })
end

function NepHudMenu:ClearMenu()
    self.MainMenu:ClearItems()
end

function NepHudMenu:InitCollab()
    self.CollabMenu = self._menu:Menu({
        name = "CollabMenu",
        background_color = Color(0.3, 0, 0, 0),
        h = 350,
        w = self._menu_panel:w() / 2.1,
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
        font = Font,
        size = 20,
        background_color = Color(0.75, 0, 0, 0),
        highlight_color = Color(0.75, 0, 0, 0),
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
            border_color = self.BorderColor,
            border_left = true,
            background_color = Color(0.3, 0, 0, 0),
            highlight_color = HighlightColor,
            on_callback = callback(self, self, "open_url", built_steam_url)
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
            align = "right",
            x = -5
        })
    end
end

function NepHudMenu:InitChangelog()
    self.ChangelogMenu = self._menu:Menu({
        name = "ChangelogMenu",
        background_color = Color(0.3, 0, 0, 0),
		h = 240,
		offset = 8,
        w = self._menu_panel:w() / 2.1,
        position = function(item)
            item:Panel():set_top(self.CollabMenu:Panel():bottom() + 10)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end,
        scrollbar = true
    })

    self.ChangelogMenuHeader = self.ChangelogMenu:Divider({
        name = "ChangelogMenuHeader",
        text = managers.localization:text("NepgearsyHUDRebornMenu/Changelog/Header", { version = NepgearsyHUDReborn.Version }),
        localized = false,
        font = Font,
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
        on_callback = ClassClbk(self, "open_url", "https://github.com/Nepgearsy/Nepgearsy-HUD-Reborn/commits/master")
    })
end

function NepHudMenu:InitBack()
    self.BackMenu = self._menu:Menu({
        name = "BackMenu",
        background_color = Color(0.3, 0, 0, 0),
		h = 50,
		scrollbar = false,
        w = self._menu_panel:w() / 2.1,
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
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = "Center",
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        on_callback = ClassClbk(self._menu, "SetEnabled", false)
    })
end

function NepHudMenu:open_url(url)
    Steam:overlay_activate("url", url)
end

function NepHudMenu:background_enable_switch()
    if self.BackgroundStatus == true then
        self:SetBackgroundVis(false)
        self:VisOptionalMenuParts(false)
        self.BackgroundEnabler:SetImage("NepgearsyHUDReborn/Menu/EnableBackground")
        self.BackgroundStatus = false
    else
        self:SetBackgroundVis(true)
        self:VisOptionalMenuParts(true)
        self.BackgroundEnabler:SetImage("NepgearsyHUDReborn/Menu/DisableBackground")
        self.BackgroundStatus = true
    end
end

function NepHudMenu:VisOptionalMenuParts(state)
    if self.CollabMenu and self.ChangelogMenu then
        self.CollabMenu:SetVisible(state)
        self.ChangelogMenu:SetVisible(state)
    end
end

function NepHudMenu:SetOption(option_name, option_value)
    --NepgearsyHUDReborn:DebugLog("NAME ; VALUE", tostring(option_name), tostring(option_value))
    NepgearsyHUDReborn.Options:SetValue(option_name, option_value)
    NepgearsyHUDReborn.Options:Save()
end

function NepHudMenu:MainClbk(item)
    if item then
        self:SetOption(item.name, item:Value())

        if item.name == "CPColor" then
            local new_color = NepgearsyHUDReborn:StringToColor("cpcolor", NepgearsyHUDReborn.Options:GetValue("CPColor"))
            self.ColorBG:set_color(new_color)
        end
    end
end

function NepHudMenu:SkinSetClbk(skin_id)
    if skin_id then
        NepgearsyHUDReborn:Log("Teammate skin id set to: ", skin_id)
        self:SetOption("TeammateSkin", skin_id)
        self.EquippedSkin:SetImage(NepgearsyHUDReborn:GetTeammateSkinById(skin_id))
    end
end

function NepHudMenu:SetHudScaleSpacing(item)
	NepgearsyHUDReborn.Options:SetValue(item:Name(), item:Value())
	if managers.hud and managers.hud.recreate_player_info_hud_pd2 then
		managers.gui_data:layout_scaled_fullscreen_workspace(managers.hud._saferect, NepgearsyHUDReborn.Options:GetValue("Scale"), NepgearsyHUDReborn.Options:GetValue("Spacing"))
		managers.hud:recreate_player_info_hud_pd2()
	end
end
