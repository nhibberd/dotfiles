-- advanced xmonad config based upon Brent Yorgey's
--  see: http://haskell.org/haskellwiki/Xmonad/Config_archive/Brent_Yorgey%27s_darcs_xmonad.hs
-- http://haskell.org/haskellwiki/Xmonad/Config_archive/Brent_Yorgey%27s_xmonad.hs
import XMonad                          -- (0) core xmonad libraries
import Control.Monad
import System.Exit 
import qualified XMonad.StackSet as W  -- (0a) window stack manipulation
import qualified Data.Map as M         -- (0b) map creation
 
-- Hooks -----------------------------------------------------
 
import XMonad.Hooks.DynamicLog     -- (1)  for dzen status bar
import XMonad.Hooks.UrgencyHook    -- (2)  alert me when people use my nick
                                   --      on IRC
import XMonad.Hooks.ManageDocks    -- (3)  automatically avoid covering my
                                   --      status bar with windows
import XMonad.Hooks.ManageHelpers  -- (4)  for doCenterFloat, put floating
                                   --      windows in the middle of the
                                   --      screen
import XMonad.Hooks.SetWMName
 
-- Layout ----------------------------------------------------

import XMonad.Layout.Accordion  
import XMonad.Layout.ResizableTile -- (5)  resize non-master windows too
import XMonad.Layout.Grid          -- (6)  grid layout
import XMonad.Layout.TwoPane
import XMonad.Layout.NoBorders     -- (7)  get rid of borders sometimes
                                   -- (8)  navigate between windows
import XMonad.Layout.WindowNavigation  --  directionally
import XMonad.Layout.Named         -- (9)  rename some layouts
import XMonad.Layout.PerWorkspace  -- (10) use different layouts on different WSs
import XMonad.Layout.WorkspaceDir  -- (11) set working directory
                                   --      per-workspace
import XMonad.Layout.Reflect       -- (13) ability to reflect layouts
import XMonad.Layout.MultiToggle   -- (14) apply layout modifiers dynamically
import XMonad.Layout.MultiToggle.Instances
                                   -- (15) ability to magnify the focused
                                   --      window
import qualified XMonad.Layout.Magnifier as Mag
 
import XMonad.Layout.Gaps
 
-- Actions ---------------------------------------------------
 
import XMonad.Actions.CycleWS      -- (16) general workspace-switching
                                   --      goodness
import XMonad.Actions.CycleRecentWS
                                   -- (17) more flexible window resizing
import qualified XMonad.Actions.FlexibleManipulate as Flex
import XMonad.Actions.Warp         -- (18) warp the mouse pointer
import XMonad.Actions.Submap       -- (19) create keybinding submaps
import XMonad.Actions.Search       -- (20) some predefined web searches
import XMonad.Actions.WindowGo     -- (21) runOrRaise
import XMonad.Actions.UpdatePointer -- (22) auto-warp the pointer to the LR
                                    --      corner of the focused window
import XMonad.Actions.GridSelect

-- Prompts ---------------------------------------------------
 
import XMonad.Prompt                -- (23) general prompt stuff.
import XMonad.Prompt.Man            -- (24) man page prompt
import XMonad.Prompt.AppendFile     -- (25) append stuff to my NOTES file
import XMonad.Prompt.Shell          -- (26) shell prompt
import XMonad.Prompt.Input          -- (27) generic input prompt, used for
                                    --      making more generic search
                                    --      prompts than those in
                                    --      XMonad.Prompt.Search
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Window
 
-- Utilities -------------------------------------------------
 
import XMonad.Util.Loggers          -- (28) some extra loggers for my
                                    --      status bar
import XMonad.Util.EZConfig         -- (29) "M-C-x" style keybindings
import XMonad.Util.Scratchpad       -- (30) 'scratchpad' terminal
import XMonad.Util.Run              -- (31) for 'spawnPipe', 'hPutStrLn'

-- Multimedia Keys ----

import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioMute,
                                     xF86XK_AudioRaiseVolume,
                                     xF86XK_AudioLowerVolume,
                                     xF86XK_AudioPlay,
                                     xF86XK_AudioStop,
                                     xF86XK_AudioNext,
                                     xF86XK_AudioPrev)


main = do h <- spawnPipe "dzen2 -ta r -fg '#a8a3f7' -bg '#3f3c6d' -e 'onstart=lower'"
          xmonad $ nickConfig h              



 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.

 
nickConfig h = myUrgencyHook $
     defaultConfig 
       {
          borderWidth             = 2
       ,  terminal                = "xterm"
       ,  workspaces              = myWorkspaces
       ,  modMask                 = mod4Mask
       ,  normalBorderColor       = "#262626"
       ,  focusedBorderColor      = "#666666"
       ,  logHook                 = myDynamicLog h >> updatePointer (Relative 1 1) >> setWMName "LG3D"
   --    , logHook                  = myLogHook
       ,  mouseBindings           = myMouseBindings
       ,  keys                    = myKeys
       ,  manageHook              = myManageHook <+> manageHook defaultConfig
       ,  layoutHook              = myLayout
       ,  focusFollowsMouse       = True
       ,  startupHook             = myStartupHook
       }
 


myUrgencyHook = withUrgencyHook dzenUrgencyHook
  { args = ["-bg", "yellow", "-fg", "black"] }

myWorkspaces = ["1:code", "2:sys", "3:www", "4:email", "5:im", "6:music"] ++ map show [7..9]
nickPP :: PP
nickPP = defaultPP { ppHiddenNoWindows = showNamedWorkspaces
                      , ppHidden  = dzenColor "#ffffff"  "#262626" . pad
                      , ppCurrent = dzenColor "#ffffff" "#666666" . pad
                      , ppUrgent  = dzenColor "red"    "yellow"
                      , ppSep     = " | "
                      , ppWsSep   = ""
                      , ppTitle   = shorten 45
                      , ppOrder   = \(ws:l:t:exs) -> [t,l,ws]++exs
                      , ppExtras  = [ onLogger (wrap "volume: " "^fg()")  (logCmd "amixer get Master | grep 'Front Left: Playback' | awk -F'[][]' '{print $2}'")
                                      , onLogger (wrap "cpu: " "^fg()c")  (logCmd "cat /sys/devices/platform/coretemp.0/temp2_input | awk '{print $1/1000}'") 
                                      , date "%a %b %d  %I:%M %p" ]
                      }
  where 
    showNamedWorkspaces wsId = if any (`elem` wsId) ['a'..'z']
                                       then pad wsId
                                       else ""

myDynamicLog h = dynamicLogWithPP $ nickPP                   -- (1)
--  { ppExtras = [ date "%a %b %d  %I:%M %p"                      -- (1,28)
--               , loadAvg                                        -- (28)
--               , battery
--               ]
--  , ppOrder  = \(ws:l:t:exs) -> [t,l,ws]++exs                    -- (1)
--  , ppOutput = hPutStrLn h                                      -- (1,31)
--  , ppTitle  = shorten 45
--  }




-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    , ((modm, xK_Right), nextWS )
    , ((modm, xK_Left ), prevWS )
    , ((modm .|. shiftMask,   xK_Right), shiftToNext )
    , ((modm .|. shiftMask,   xK_Left ), shiftToPrev )
    , ((modm .|. shiftMask .|. controlMask, xK_Right), shiftToNext >> nextWS )
    , ((modm .|. shiftMask .|. controlMask, xK_Left ), shiftToPrev >> prevWS )


    , ((modm, xK_z), toggleWS)

    , ((modm .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")

    -- close focused window 
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -------------------------------
    
    -- grid select
    , ((modm,               xK_g), goToSelected defaultGSConfig) 
      

    -- grid select
    , ((modm .|. shiftMask, xK_g), bringSelected defaultGSConfig)       


    , ((modm .|. controlMask, xK_g     ), windowPromptGoto
                                            defaultXPConfig { autoComplete = Just 500000 } )

    , ((modm .|. controlMask .|. shiftMask, xK_g     ), windowPromptBring defaultXPConfig)

    -------------------------------

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
    -- , ((modm , xK_b ), sendMessage ToggleStruts)

    , ((modm .|. shiftMask, xK_f), runOrRaise "firefox3" (className =? "firefox-bin"))

    , ((controlMask, xK_Right), sendMessage $ Go R)
    , ((controlMask, xK_Left), sendMessage $ Go L)
    , ((controlMask, xK_Up), sendMessage $ Go U)
    , ((controlMask, xK_Down), sendMessage $ Go D)

     -- Applications
    , ((modm              , xK_c    ), spawn "chromium")
    , ((modm .|. shiftMask, xK_m    ), spawn "chromium --app='https://mail.google.com'")

     -- volume control
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 5%+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 5%-")
    , ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
    , ((0, xF86XK_AudioPlay), spawn "rhythmbox-client --play")
    , ((0, xF86XK_AudioStop), spawn "rhythmbox-client --pause")
    , ((0, xF86XK_AudioPrev), spawn "rhythmbox-client --previous")
    , ((0, xF86XK_AudioNext), spawn "rhythmbox-client --next") 

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), restart "xmonad" True)

    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full) ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "sublime-text" --> doShift "1:code"
    , className =? "jetbrains-idea-ce" --> doShift "1:code" 
    , (resource  =? "mail.google.com" <&&> className =? "Chromium") --> doShift "4:email"
    , className =? "Chromium" --> doShift "3:www"
    , className =? "Firefox" --> doShift "3:www" 
    , className =? "Thunderbird" --> doShift "4:email"
    , className =? "Pidgin" --> doShift "5:im"
    , className =? "Rhythmbox" --> doShift "6:music" ]
  
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
--myLogHook = dynamicLogDzen
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
--main = xmonad defaults
 
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
--defaults = defaultConfig {
--      -- simple stuff
--        terminal           = myTerminal,
--        focusFollowsMouse  = myFocusFollowsMouse,
--        borderWidth        = myBorderWidth,
--
--
--        workspaces         = myWorkspaces,
--        normalBorderColor  = myNormalBorderColor,
--        focusedBorderColor = myFocusedBorderColor,
-- 
--      -- key bindings
--        keys               = myKeys,
--        mouseBindings      = myMouseBindings,
-- 
--      -- hooks, layouts
--        layoutHook         = myLayout,
--        manageHook         = myManageHook,
--        logHook            = myLogHook,
--        startupHook        = myStartupHook
--    }



