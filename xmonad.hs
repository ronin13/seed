-- XMonad Configuration

--{{{ Imports
import XMonad.Layout.Gaps
import XMonad hiding ( (|||) )
import XMonad.Actions.NoBorders
import Monad
import Data.Monoid
import XMonad.Hooks.UrgencyHook
import System.Exit
import XMonad.Hooks.DynamicLog
import XMonad.Layout.ResizableTile
import XMonad.Layout.Magnifier
import XMonad.Hooks.ManageDocks
import XMonad.Actions.OnScreen
import XMonad.Util.Scratchpad (scratchpadSpawnActionCustom)
import XMonad.Actions.CopyWindow
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.LayoutHints
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.SinkAll
import XMonad.Util.Types
import XMonad.Prompt
import XMonad.Prompt.Window
import XMonad.Actions.SpawnOn
import XMonad.Actions.GridSelect

import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace  (onWorkspace)
import XMonad.Layout.LayoutCombinators
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import XMonad.Actions.CycleWS
{-import qualified XMonad.Layout.Fullscreen as F-}


import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.Magnifier as Mag

--}}} 

--{{{ Testing 
toggleOrViewNoSP = toggleOrDoSkip ["NSP"]  W.greedyView
--}}}
--
--{{{ Core
main = do
    xmproc <- spawnPipe  "xmobar --screen=0"
-- FocusHook
    xmonad $ ewmh $ withUrgencyHookC NoUrgencyHook urgentConfig $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        layoutHook         = myLayout,
        manageHook         = transience' <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook xmproc,
        startupHook        = myStartupHook
        }
 
--}}}
--
--{{{
urgentConfig = UrgencyConfig { suppressWhen = XMonad.Hooks.UrgencyHook.Never, remindWhen = Repeatedly 3 10 }
--}}}

--{{{ Variables
myTerminal      = "urxvtc"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myBorderWidth   = 0
myModMask       = mod4Mask
myNormalBorderColor  = "grey23"
myFocusedBorderColor = "grey56"


--}}}

--{{{ Keybindings 
--myKeys conf = mkKeymap conf $
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

     [ ((modm, xK_d     ), kill1)
    ,  ((modm,  xK_r),   withFocused toggleBorder)
    {-, ((mod1Mask, xK_space), scratchpadSpawnActionCustom "$HOME/bin/scratcher")-}
    , ((modm, xK_period), toggleWS )
    , ((modm              , xK_BackSpace), focusUrgent)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    , ((modm .|. shiftMask, xK_l ), sendMessage MirrorExpand)
    , ((modm .|. shiftMask, xK_Up),  nextWS)
    , ((modm .|. controlMask, xK_Up),  swapPrevScreen)
    , ((modm .|. controlMask, xK_Down), swapNextScreen)
    , ((modm, xK_Down),  moveTo Next NonEmptyWS)
    , ((modm, xK_Up), moveTo Prev NonEmptyWS)
    , ((modm,             xK_b), sendMessage ToggleStruts)
    , ((modm,               xK_Right     ), windows W.focusDown)
    , ((modm,               xK_Left     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_KP_Add     ), nextScreen  )
    , ((modm , xK_g    ), sendMessage Toggle)
    , ((modm .|. shiftMask, xK_t     ), sinkAll)
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((controlMask, xK_0), spawn "xset +dpms;sleep 1;xset dpms force off")
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    {-, ((modm, xK_s), goToSelected defaultGSConfig)-}
    , ((modm, xK_s), bringSelected defaultGSConfig)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((controlMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((controlMask             , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    ]
    ++
     [((m .|. modm, k), f i)
     | (i, k) <- zip (XMonad.workspaces conf) numKeys
     , (f, m) <- [(toggleOrViewNoSP, 0), (windows . W.shift, shiftMask), (windows . copy, mod1Mask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_q,xK_w] [0..]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


numKeys = [ xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down -- 1, 2, 3
             , xK_KP_Left, xK_KP_Begin, xK_KP_Right     -- 4, 5, 6
             , xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up   -- 7, 8, 9
             , xK_KP_Insert]                            -- 0

--}}}

--{{{ Layout
myLayout = onWorkspace "3:browser" brLayout $ onWorkspace "4:video" brLayout $ onWorkspace "8:games" Full $ defLayout
      where
          defLayout = avoidStruts  ( tiled ||| Mirror tiled ||| Full)
          tiled     = smartBorders tall
          tall      = ResizableTall 1 (2/100) (1/2) []
          brLayout  = avoidStruts (Mirror tiled ||| tiled ||| Full)
          mgFy      = Mag.magnifiercz 1.4
--}}}

--{{{ Workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces    = ["1:norm","2:term","3:browser","4:video","5:pdf","6:note","7:thunar","8:games","9:misc"]
myManageHook = composeAll . concat $
    [ 
      [     className =? "MPlayer"        --> doShift "4:video"                                 ]
    , [     isFullscreen                  --> doFullFloat                    ]
    , [     className =? "Wine"           --> doShift "8:games"                                  ]
    , [     className =? "VirtualBox"     --> doShift "8:games"                                  ]
    , [     resource  =? c                --> doIgnore              | c <- myIgnores             ]
    , [     className =? b                --> doShift "3:browser"   | b <- myBrowsers            ]
    , [     className =? "Thunar"         --> doShift "7:thunar"                                 ]
    , [     className =? "Rednotebook"    --> doShift "6:note"                                   ]
    , [     className =? d  <||> isDialog --> doCenterFloat         | d <- myCenterFloats        ]
    , [     className =? e 		  --> doShift "5:pdf"       | e <- myPDF                 ]
    , [     manageDocks                                                                          ] ]
    where
      myCenterFloats = ["Xmessage","feh","Gxmessage"]
      myBrowsers = ["Firefox"]
      myPDF = ["Evince","Zathura","Apvlv"]
      myIgnores = ["desktop_window","desktop"]
--}}}

--{{{ Events
myEventHook = fullscreenEventHook
--}}}

--{{{ Startup
myStartupHook = mempty
--}}}

--{{{ LogHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }
 
---- Looks --
---- bar
customPP :: PP
customPP = defaultPP {
                ppHidden = xmobarColor "#34596B" "" . noScratchPad
              , ppOrder = \(ws:l:t:_) -> [l,ws]
              , ppCurrent = xmobarColor "skyblue" "" . wrap "/" "/"
              , ppUrgent = xmobarColor "green" "" . wrap "*" "*"
              , ppWsSep =  " "
              , ppLayout = xmobarColor "SlateGray2" "" . wrap "[" "]"
              , ppTitle = xmobarColor "slateblue" "" . shorten 25
              , ppSep = "<fc=#0033FF> . </fc>"
            }
        where
            noScratchPad ws = if ws == "NSP" then "" else pad ws 
--}}}
