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
    self:InitBack()

    MenuCallbackHandler.NepgearsyHUDRebornMenu = callback(self, self, "set_enabled", true)
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
        w = 26,
        h = 26,
        position = function(item) 
            item:Panel():set_left(self.HUDName:right() + 20)
        end,
        help = "Enable or disable the background, and optional parts of the menu.",
        callback = ClassClbk(self, "background_enable_switch")
    })
    HUDName:set_world_center_y(self.TopBar:Panel():world_center_y())
    self.BackgroundEnabler = BackgroundEnabler

    local MWSProfile = self.TopBar:ImageButton({
        name = "MWSProfile",
        texture = "NepgearsyHUDReborn/Menu/MWSProfile",
        w = 26,
        h = 26,
        position = function(item) 
            item:Panel():set_left(self.BackgroundEnabler:Panel():right() + 5)
        end,
        help = "Go to the mod's page.",
        callback = ClassClbk(self, "open_url", "https://modworkshop.net/mydownloads.php?action=view_down&did=22152")
    })
    self.MWSProfile = MWSProfile
    local Discord = self.TopBar:ImageButton({
        name = "Discord",
        texture = "NepgearsyHUDReborn/Menu/Discord",
        w = 26,
        h = 26,
        position = function(item) 
            item:Panel():set_left(self.MWSProfile:Panel():right() + 5)
        end,
        help = "Join our Discord Modserver!",
        callback = ClassClbk(self, "open_url", "https://discord.gg/yy6cxwZ")
    })

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
        callback = ClassClbk(self, "open_url", "https://github.com/Nepgearsy/Nepgearsy-HUD-Reborn/commits/master")
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
        callback = ClassClbk(self, "open_url", "https://github.com/Nepgearsy/Nepgearsy-HUD-Reborn/issues")
    })

    local PostRequest = self.TopBar:Button({
        name = "PostRequest",
        text = managers.localization:to_upper_text("NepgearsyHUDReborn/PostRequest"),
        background_color = Color.transparent,
        highlight_color = Color.transparent,
        foreground = Color(1, 1, 1),
        foreground_highlight = BorderColor,
        position = function(item) 
            item:Panel():set_right(PostIssue:Panel():left() - 15)
        end,
        localized = false,
        size_by_text = true,
        text_align = "right",
        text_vertical = "center",
        font_size = 15,
        font = Font,
        callback = ClassClbk(self, "open_url", "https://feathub.com/Nepgearsy/Nepgearsy-HUD-Reborn")
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
        background_color = Color(0.3, 0, 0, 0),
        h = self._menu_panel:h() - self.TopBar:Panel():h(),
        w = self._menu_panel:w() / 4, 
        align_method = "normal",
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom())
            item:Panel():set_right(self._menu_panel:right())
        end
    })

    self.ForcedLocalization = self.MainMenu:ComboBox({
        name = "ForcedLocalization",
        border_color = BorderColor,
        border_left = true,
        items = NepgearsyHUDReborn.LocalizationTable,
        value = NepgearsyHUDReborn.Options:GetValue("ForcedLocalization"),        
        text = "NepgearsyHUDRebornMenu/ForcedLocalization",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(item:Panel():parent():top() + 10) 
            item:Panel():set_right(item:Panel():parent():right())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptionsCat = self.MainMenu:Button({
        name = "HUDOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/HUDOptionsCat",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        position = function(item) 
            item:Panel():set_top(self.ForcedLocalization:Panel():bottom() + 15) 
            item:Panel():set_right(item:Panel():parent():right())
        end,
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        font = Font
    })

    self.HUDOptions = {}
    self.HUDOptions.AssaultBar = self.MainMenu:ComboBox({
        name = "AssaultBarFont",
        border_color = BorderColor,
        border_left = true,
        items = NepgearsyHUDReborn.AssaultBarFonts,
        value = NepgearsyHUDReborn.Options:GetValue("AssaultBarFont"),        
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/AssaultBarFont",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptionsCat:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.Minimap = self.MainMenu:Toggle({
        name = "EnableMinimap",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableMinimap"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Minimap",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.AssaultBar:Panel():bottom() + 20) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.MinimapForce = self.MainMenu:Toggle({
        name = "MinimapForce",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("MinimapForce"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapForce",
        help = "Force the minimap anytime, even if the current map doesn't have a texture for it.",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Minimap:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.MinimapSize = self.MainMenu:Slider({
        name = "MinimapSize",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("MinimapSize"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapSize",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.MinimapForce:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        min = 150,
        max = 200,
        step = 1,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.MinimapZoom = self.MainMenu:Slider({
        name = "MinimapZoom",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("MinimapZoom"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/MinimapZoom",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.MinimapSize:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        min = 0.25,
        max = 1,
        step = 0.01,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.Trackers = self.MainMenu:Toggle({
        name = "EnableTrackers",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableTrackers"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Trackers",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.MinimapZoom:Panel():bottom() + 20) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.TrueAmmo = self.MainMenu:Toggle({
        name = "EnableTrueAmmo",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableTrueAmmo"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/TrueAmmo",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Trackers:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.HealthStyle = self.MainMenu:ComboBox({
        name = "HealthStyle",
        items = NepgearsyHUDReborn.HealthStyle,
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("HealthStyle"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/HealthStyle",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.TrueAmmo:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.StatusNumberType = self.MainMenu:ComboBox({
        name = "StatusNumberType",
        items = NepgearsyHUDReborn.StatusNumberType,
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("StatusNumberType"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/StatusNumberType",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.HealthStyle:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.HUDOptions.Scale = self.MainMenu:Slider({
        name = "Scale",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("Scale"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Scale",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.StatusNumberType:Panel():bottom() + 20) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        help = "If in-game, restart the map to take effect",
        localized = true,
        min = 0.1,
        max = 1.5,
        step = 0.01,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "SetHudScaleSpacing")
    })

    self.HUDOptions.Spacing = self.MainMenu:Slider({
        name = "Spacing",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("Spacing"),
        text = "NepgearsyHUDRebornMenu/Buttons/HUD/Spacing",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Scale:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        help = "If in-game, restart the map to take effect",
        localized = true,
        min = 0.1,
        max = 1,
        step = 0.01,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "SetHudScaleSpacing")
    })

    self.MenuLobbyOptionsCat = self.MainMenu:Button({
        name = "MenuLobbyOptionsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/MenuLobbyOptionsCat",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        position = function(item) 
            item:Panel():set_top(self.HUDOptions.Spacing:Panel():bottom() + 15) 
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
        name = "EnableStarring",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableStarring"),
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
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.MenuLobbyOptions.StarringColor = self.MainMenu:ComboBox({
        name = "StarringColor",
        items = NepgearsyHUDReborn.StarringColors,
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("StarringColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringColor",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.MenuLobbyOptions.StarringScreen:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.MenuLobbyOptions.StarringText = self.MainMenu:TextBox({
        name = "StarringText",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("StarringText"),
        text = "NepgearsyHUDRebornMenu/Buttons/LobbyMenu/StarringText",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.MenuLobbyOptions.StarringColor:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.MenuLobbyOptions.HorizontalLoadout = self.MainMenu:Toggle({
        name = "EnableHorizontalLoadout",
        border_color = BorderColor,
        border_left = true,
        value = NepgearsyHUDReborn.Options:GetValue("EnableHorizontalLoadout"),
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
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.ColorsCat = self.MainMenu:Button({
        name = "ColorsCat",
        text = "NepgearsyHUDRebornMenu/Buttons/ColorsCat",
        background_color = Color(0, 0, 0),
        highlight_color = Color.black,
        position = function(item) 
            item:Panel():set_top(self.MenuLobbyOptions.HorizontalLoadout:Panel():bottom() + 15) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        font = Font
    })
    self.Colors = {}
    self.Colors.CPColor = self.MainMenu:ComboBox({
        name = "CPColor",
        border_color = BorderColor,
        border_left = true,
        items = NepgearsyHUDReborn.CPColors,
        value = NepgearsyHUDReborn.Options:GetValue("CPColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/CPColor",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.ColorsCat:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.HealthColor = self.MainMenu:ComboBox({
        name = "HealthColor",
        border_color = BorderColor,
        border_left = true,
        items = NepgearsyHUDReborn.HealthColor,
        value = NepgearsyHUDReborn.Options:GetValue("HealthColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/HealthColor",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.Colors.CPColor:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.ShieldColor = self.MainMenu:ComboBox({
        name = "ShieldColor",
        border_color = BorderColor,
        border_left = true,
        items = NepgearsyHUDReborn.ArmorColor,
        value = NepgearsyHUDReborn.Options:GetValue("ShieldColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/ShieldColor",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.Colors.HealthColor:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
    })

    self.Colors.ObjectiveColor = self.MainMenu:ComboBox({
        name = "ObjectiveColor",
        border_color = BorderColor,
        border_left = true,
        items = NepgearsyHUDReborn.ObjectiveColor,
        value = NepgearsyHUDReborn.Options:GetValue("ObjectiveColor"),
        text = "NepgearsyHUDRebornMenu/Buttons/Colors/ObjectiveColor",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_top(self.Colors.ShieldColor:Panel():bottom() + 5) 
            item:Panel():set_left(self.HUDOptionsCat:Panel():left())
        end,
        localized = true,
        text_align = "left",
        text_vertical = "center",
        font_size = 15,
        callback = ClassClbk(self, "MainClbk")
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
        h = 190,
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

function NepHudMenu:InitBack()
    self.BackMenu = self._menu:Menu({
        name = "BackMenu",
        background_color = Color(0.3, 0, 0, 0),
        h = 50,
        w = self._menu_panel:w() / 2.1, 
        align_method = "normal",
        position = function(item)
            item:Panel():set_top(self.ChangelogMenu:Panel():bottom() + 10)
            item:Panel():set_right(self.MainMenu:Panel():left() - 10)
        end
    })

    self.BackButton = self.BackMenu:Button({
        name = "BackButton",
        border_color = BorderColor,
        border_left = true,
        text = "NepgearsyHUDRebornMenu/Buttons/Close",
        background_color = Color(0.3, 0, 0, 0),
        highlight_color = HighlightColor,
        position = function(item) 
            item:Panel():set_x(10) 
            item:Panel():set_y(10)
        end,
        localized = true,
        text_align = "center",
        text_vertical = "center",
        font_size = 20,
        callback = callback(self, self, "set_enabled", false)
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
    local active_menu = managers.menu:active_menu()

    if self.BackgroundStatus == true then
        if active_menu then
            active_menu.renderer:set_bg_area("none")
        end
        self:SetBackgroundVis(false)
        self.CollabMenu:SetVisible(false)
        self.ChangelogMenu:SetVisible(false)
        self.ChangelogTextMenu:SetVisible(false)
        self.BackgroundEnabler:SetImage("NepgearsyHUDReborn/Menu/EnableBackground")
        self.BackgroundStatus = false
    else
        if active_menu then
            active_menu.renderer:set_bg_area("full")
        end

        self:SetBackgroundVis(true)
        self.CollabMenu:SetVisible(true)
        self.ChangelogMenu:SetVisible(true)
        self.ChangelogTextMenu:SetVisible(true)
        self.BackgroundEnabler:SetImage("NepgearsyHUDReborn/Menu/DisableBackground")         
        self.BackgroundStatus = true
    end
end

function NepHudMenu:SetOption(option_name, option_value)
    --NepgearsyHUDReborn:DebugLog("NAME ; VALUE", tostring(option_name), tostring(option_value))
    NepgearsyHUDReborn.Options:SetValue(option_name, option_value)
    NepgearsyHUDReborn.Options:Save()
end

function NepHudMenu:MainClbk(menu, item)
    if item then
        self:SetOption(item.name, item:Value())

        if item.name == "CPColor" then
            local new_color = NepgearsyHUDReborn:StringToColor("cpcolor", NepgearsyHUDReborn.Options:GetValue("CPColor"))
            self.ColorBG:set_color(new_color)
        end
    end
end

function NepHudMenu:SetHudScaleSpacing(menu, item)
	NepgearsyHUDReborn.Options:SetValue(item:Name(), item:Value())
	if managers.hud and managers.hud.recreate_player_info_hud_pd2 then
		managers.gui_data:layout_scaled_fullscreen_workspace(managers.hud._saferect, NepgearsyHUDReborn.Options:GetValue("Scale"), NepgearsyHUDReborn.Options:GetValue("Spacing"))		
		managers.hud:recreate_player_info_hud_pd2()
	end
end


function NepHudMenu:should_close()
    return self._menu:ShouldClose()
end

function NepHudMenu:hide()
    self:set_enabled(false)
    return true
end