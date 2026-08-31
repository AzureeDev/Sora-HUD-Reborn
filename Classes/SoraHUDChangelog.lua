SoraHUDChangelog = SoraHUDChangelog or class()
SoraHUDChangelog.log = {
    {
        label = "Update 2.7.0 - 24.08.2023, 16:51",
        version = "2.7.0 - Epic Update",
        image = "NepgearsyHUDReborn/Menu/Versions/270",
        entries = {
            { title = "Localization", desc = "- The Korean localization has been updated." },
            { title = "Options", desc = "- An option to disable steam avatars for the chat component has been added." },
            { title = "Steam Avatars", desc = "- The various features using steam avatars have been fixed." },
            { title = "Teammate Skins", desc = "- Added several new skins." }
        }
    },
    {
        label = "Update 2.6.1 - 23.12.2022, 14:38",
        version = "2.6.1 - Resurrection",
        image = "NepgearsyHUDReborn/Menu/Versions/261",
        entries = {
            { title = "Localization", desc = "- The Korean localization has been added. This was made by Gullwing Door.\n- Going forward, localizations that does not support custom fonts will automatically default to font_large_mf. A warning will be prompted when selecting a potentially problematic localization." },
            { title = "Bugfixes", desc = "- Fixed the Point of no Return timer not being correctly removed on some heists.\n- Fixed a rare case of a vanilla hostage icon being displayed for no reason.\n- Fixed newly added textures in 2.6.0 having mipmaps when they shouldn't have any." }
        }
    },
    {
        label = "Update 2.6.0 - 21.12.2022, 17:55",
        version = "2.6.0 - Resurrection (?)",
        image = "NepgearsyHUDReborn/Menu/Versions/260",
        entries = {
            { title = "Hello again!", desc = "Glad to see this HUD still being standing strong despite the numerous updates the game had. Instead of leaving this HUD taking dust, I'll be updating it whenever I feel like it." },
            { title = "Down Counter support", desc = "- Added the long-awaited (probably) down counter, in the HUD's style." },
            { title = "Removing Feathub", desc = "- Unfortunately the website is gone, so I'm removing all references to it in the mod. Please post requests in GitHub, in the issues tab with the proper tag." }
        }
    },
    {
        label = "Update 2.5.0 - 04.10.2019, 16:17",
        version = "Final Update",
        image = "NepgearsyHUDReborn/Menu/Versions/250",
        entries = {
            { title = "Dang it Overkill", desc = "- Fixed a crash on the San Martin heist, and added safety checks for other crashes I got a report for." },
            { title = "Farewell!", desc = "The good modding time has come to an end for me.\nThis is the last update, which is doing nothing much, but ends the development support. I believe nothing will break in the future.\n\nThank you so much for using this HUD!\n-Sora." }
        }
    },
    {
        label = "Update 2.4.0 - 06.09.2019, 14:08",
        version = "2.4.0 - Adaptation",
        image = "NepgearsyHUDReborn/Menu/Versions/240",
        entries = {
            -- Lazy...
            --{ title = "HUD Part Activation", desc = "You can now disable parts of the HUD. Note that some features need parts of the HUD to function properly. Disabling the assault corner element will also disable the trackers, even if the two have no relations." },
            { title = "User Request", desc = "Someone requested a way to disable the map preview in the Blackscreen, this is now a thing.\nYou can find it in Menu & Lobby options." },
            { title = "New CP Background", desc = "Looking nice huh? c;" },
            { title = "Player Level fixed", desc = "The player level in the teammate panel now doesn't kiss the side of the panel, and won't eat the text when using the PDTH font anymore." },
            { title = "Teammate Skins", desc = "Added a new skin made by _Direkt. You can find it in the Community tab!\nMore default skins has been added, as well of some Orange_Juice themed skins. These are made by me." },
            { title = "Localization", desc = "The Polish localization has been added. This was made by VladTheH." }
        }
    },
    {
        label = "Update 2.3.2 - 22.08.2019, 19:11",
        version = "2.3.2 - Acceleration - Content Update",
        image = "NepgearsyHUDReborn/Menu/Versions/232",
        entries = {
            { title = "Teammate Skins", desc = "Added new skins! These were made by Syphist, and gabsF. Thanks to them!" },
            { title = "Localization Updated", desc = "The portuguese localization has been updated." }
        }
    },
    {
        label = "Update 2.3.1 - 06.08.2019, 19:46",
        version = "2.3.1 - Acceleration - Bugfix",
        image = "NepgearsyHUDReborn/Menu/Versions/231",
        entries = {
            { title = "Bugfixes", desc = "Fixed an issue where, under exceptionnal circumstances, the game would freeze forever when opening the menu." },
            { title = "New stuff", desc = "2 new teammate panel skins added in the community category." }
        }
    },
    {
        label = "Update 2.3.0 - 29.07.2019, 18:52",
        version = "2.3.0 - Acceleration",
        image = "NepgearsyHUDReborn/Menu/Versions/230",
        entries = {
            { title = "Stamina Bar", desc = "A new stamina bar has been added. You can toggle it on, or off in the HUD options. You can also personalize the colors!" },
            { title = "Integrated Money In HUD", desc = "You can now enjoy a brand new Money in HUD, directly included, adapted to the HUD style. Toggle it on and off in the options." },
            { title = "Teammate Panel Skins are now loading instantly", desc = "A problem that was getting bigger and bigger the more I added skins. This is now definitely fixed. In addition to that, kruiserdb created 10 new teammate panel skins. Check them in the Community category!" },
            { title = "Bugfixes", desc = "- Fixed an issue when switching loadouts in a pre-game: the fire mode was not displaying properly. This is now fixed" }
        }
    },
    {
        label = "Update 2.2.0 - 15.07.2019, 21:22",
        version = "2.2.0 - The Colorful Update",
        image = "NepgearsyHUDReborn/Menu/Versions/220",
        entries = {
            { title = "New Colors", desc = "A lot of options now supports ALL colors. Check them out, as the options are reset. Also added missing color options, and additional ways to customize the HUD." },
            { title = "And also a new Changelog!", desc = "The Changelog part of the menu wasn't touched since the version 1.0.0... Today, it got updated, and it looks nicer than ever. If you missed a previous update, you can now easily check it out by clicking the arrows on the top right." },
            { title = "PDTH Font available for use!", desc = "You can now select the Payday the Heist Font in addition of the two previous choices you had!\nLittle note: Special icons are not supported.", custom_font = "fonts/font_pdth" },
            { title = "Reset to Default Values", desc = "I think that was something asked by a lot of people, and it's now reality. Clicking the button will directly reset all options to their default values." },
            { title = "Difficulty, and Party Size added to the Discord Rich Presence", desc = "A little thing I forgot. Now, the difficulty played on is displayed next to the heist's name, and the party size is displayed when you're in a Multiplayer Lobby." },
            { title = "Current Fire Mode, now displayed", desc = "As well asked for a long time, here's the current firemode of the weapon, now displayed near the ammo counter." },
            { title = "Blackscreen Transition, no more so black..", desc = "It looks nice to have the level loading screen in the blackscreen transition. This change won't be there if you disable the option 'Starring Screen'." },
            { title = "Localizations Updated", desc = "gabsF updated the Portuguese Localization. Thanks to him!"},
            { title = "Bugfixes", desc = "An issue with the teammate panel skins ingame were making them more wide than intended. This is now fixed.\nFixed a crash when trying to retrieve the steam avatar." }
        }
    },
    {
        label = "Update 2.1.0 - 09.07.2019, 18:37",
        version = "2.1.0 - Discord Rich Presence",
        image = "NepgearsyHUDReborn/Menu/Versions/210",
        entries = {
            { title = "CUSTOM DISCORD RICH PRESENCE, NOW AVAILABLE", desc = "Added a new feature : Custom Discord Rich Presence. You can personalize what your friends see when you're playing." },
            { title = "TEAMMATE PANEL SKINS MORE ORGANIZED", desc = "Added a lot of new Teammate Panel Skins! The menu got quite laggy since we added so many of them (close to 100), so it was a better plan to separate the render in their own categories. That way, it's now easier to find the ones you like!" },
            { title = "VARIOUS ADDITIONS", desc = "Bots now have a name background, like players.\nAdded a new option: \"Show the player's color with a Teammate Panel Skin\". This is disabled by default." },
            { title = "BUGFIXES", desc = "- Fixed an issue where collaborator avatars wouldn't load properly sometimes.\n- Fixed an issue with the assault banner, where clients couldn't see \"Prepare for the next assault\".\n- Menu initialization changed." }
        }
    },
    {
        label = "Update 2.0.0",
        version = "2.0.0 - Passage to Sora's HUD Reborn",
        image = "NepgearsyHUDReborn/Menu/Versions/200",
        entries = {
            { title = "NEW IDENTITY", desc = "The HUD goes from Nepgearsy HUD to Sora's HUD. Nothing much else change but the identity of the HUD itself, which hasn't changed despite me changing my name. Now this is done." },
            { title = "BUGFIX 2.0.1", desc = "The mod initialization changed, in order to make other BeardLib mods compatible with this one.." }
        }
    }
}

--local small_text_changelog = 15
local color_header = Color(0.35, 0.65, 1)
local color_changelog = Color(0.7, 0.7, 0.7)
function SoraHUDChangelog:ImageHeader(texture_path, holder)
    holder:Image({
        texture = texture_path,
        w = holder:W(),
        h = 70
    })
end

function SoraHUDChangelog:Title(title, holder, custom_font)
    holder:Divider({
        text = title,
        font = NepgearsyHUDReborn:SetFont(custom_font or "fonts/font_eurostile_ext"),
        size = 24,
        text_align = "center",
        background_color = Color(0.7, 0, 0, 0)
    })
end

function SoraHUDChangelog:Change(title, desc, holder, custom_font)
    holder:Divider({ size = 10 })
    holder:QuickText(utf8.to_upper(title), { foreground = color_header, size = 20, font = custom_font })
    holder:Divider({
        font = custom_font and NepgearsyHUDReborn:SetFont(custom_font),
        text = desc,
        size = 15,
        foreground = color_changelog
    })
end

function SoraHUDChangelog:DrawVersion(notebook, index)
    local data = self.log[index]
    local holder = notebook:Holder({ offset = 0 })
    self:ImageHeader(data.image, holder)
    self:Title(data.version, holder)

    for _, entry in ipairs(data.entries) do
        self:Change(entry.title, entry.desc, holder, entry.custom_font)
    end

    return holder
end