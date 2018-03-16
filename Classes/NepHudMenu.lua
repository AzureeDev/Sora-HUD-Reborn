NepHudMenu = NepHudMenu or class()

-- Based on BeardLib Editor & HoloUI's menu.
function NepHudMenu:Init()
    local BaseLayer = 1500
    local BackgroundLayer = BaseLayer - 2
    self._menu = MenuUI:new({
        name = "NepgearsyHUDMenu",
        layer = BaseLayer,
        background_color = Color.transparent,
        animate_toggle = true
    })
    self._menu_panel = self._menu._panel

    self:InitBackground(BackgroundLayer)
    self:InitMenu()

    MenuCallbackHandler.NepgearsyHUDRebornMenu = callback(self, self, "set_enabled", true)
    MenuHelperPlus:AddButton({
        id = "NepgearsyHUDRebornMenu",
        title = "NepgearsyHUDRebornMenu",
        node_name = "options",
        position = 1,
        callback = "NepgearsyHUDRebornMenu"
    })
end

function NepHudMenu:InitBackground(layer)
    local Background = self._menu_panel:bitmap({
        name = "Background",
        w = self._menu_panel:w(),
        h = self._menu_panel:h(),
        texture = "NepgearsyHUDReborn/Menu/NepHudMenu"
    })
end

function NepHudMenu:SetBackgroundVis(vis)
    local Background = self._menu_panel:child("Background")
    Background:set_visible(vis)
end

function NepHudMenu:InitMenu()
    local ButtonH = 30

    local MainMenu = self._menu:Menu({
        name = "MainMenu",
        border_color = Color(0.8, 0, 1),
        background_color = Color(0.3, 0, 0, 0),
        h = self._menu_panel:h(),
        w = self._menu_panel:w() / 3,
        text_align = "center",
        align_method = "grid",
        position = function(item)
            item:SetPositionByString("RightTop")
        end
    })

    local BackButton = MainMenu:Button({
        name = "Close",
        text = "NepgearsyHUDRebornMenu/Buttons/Close",
        background_color = Color(0.3, 0, 0, 0),
        align_method = "grid",
        h = ButtonH,
        w = MainMenu:Panel():w(),
        position = function(item) item:Panel():set_bottom(item:Panel():parent():bottom() - 10) end,
        localized = true,
        text_align = "center",
        text_vertical = "bottom",
        font_size = 22,
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

function NepHudMenu:should_close()
    return self._menu:ShouldClose()
end

function NepHudMenu:hide()
    self:set_enabled(false)
    return true
end