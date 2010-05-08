-- XMonad Configuration

--{{{ Imports
import XMonad hiding ( (|||) )
import Monad
import XMonad.Layout.HintedGrid
import Data.Monoid
import XMonad.Hooks.UrgencyHook
import System.Exit
import XMonad.Hooks.DynamicLog
import XMonad.Actions.SpawnOn
import XMonad.Layout.ResizableTile
import XMonad.Layout.Magnifier
import XMonad.Hooks.ManageDocks

import XMonad.Util.Scratchpad (scratchpadSpawnActionCustom)

--centerFloat
import XMonad.Hooks.ManageHelpers

import XMonad.Prompt
import XMonad.Prompt.Window

--Grid
--import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace  (onWorkspace)
import XMonad.Layout.LayoutCombinators
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Actions.CycleWS
-- import XMonad.Layout.Monitor

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.Magnifier as Mag
--}}}

--{{{ Variables
myTerminal      = "urxvt"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myBorderWidth   = 0
myModMask       = mod4Mask
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myXPConfig = defaultXPConfig                                    
    { 
	font  = "xft:Bitstream Vera Sans Mono:pixelsize=14" 
	,fgColor = "white"
	, bgColor = "black"
	, position = Top
    }
--}}}

--{{{ Keybindings 
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

     [ ((controlMask, xK_q     ), kill)

    , ((shiftMask, xK_Up), scratchpadSpawnActionCustom "$HOME/bin/scratcher")
   
    , ((modm, xK_period), toggleWS )

    , ((modm, xK_slash), windowPromptGoto myXPConfig)

    , ((modm,               xK_space ), sendMessage NextLayout)

    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modm .|. shiftMask, xK_h ), sendMessage MirrorShrink)

    , ((modm .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    , ((modm,               xK_n     ), refresh)

    , ((modm .|. shiftMask, xK_Right),  nextWS)
   
    , ((modm, xK_Up),  shiftToNext)

    , ((modm, xK_Down),    shiftToPrev)

    , ((modm .|. shiftMask, xK_Left),   prevWS)
  
    , ((modm,               xK_Right     ), windows W.focusDown)

    , ((modm,               xK_Left     ), windows W.focusUp  )

    , ((modm,               xK_m     ), windows W.focusMaster  )

    , ((modm,               xK_Return), windows W.swapMaster)

    --, ((modm .|. shiftMask, xK_Right     ), windows W.swapDown  )

    --, ((modm .|. shiftMask, xK_Left     ), windows W.swapUp    )

    , ((controlMask, xK_0), spawn "xset +dpms;sleep 1;xset dpms force off")

    , ((modm,               xK_h     ), sendMessage Shrink)

    , ((modm,               xK_l     ), sendMessage Expand)

    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    , ((controlMask              , xK_comma ), sendMessage (IncMasterN 1))

    , ((controlMask             , xK_period), sendMessage (IncMasterN (-1)))

    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((shiftMask, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((shiftMask, button2), (\w -> focus w >> windows W.shiftMaster))

    , ((shiftMask, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    ]
--}}}  

--{{{ Layout
myLayout =  onWorkspace "4:video" vidLayout $ onWorkspace "7:games" Full $ defLayout
      where
          defLayout = avoidStruts $ Mag.magnifier (tiled ||| Full ||| Mirror tiled)
          tiled   = smartBorders (ResizableTall 1 (2/100) (1/2) [])
          vidLayout =  noBorders (GridRatio (4/3) False ||| Full)
--}}}

--{{{ Workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces    = ["1:norm","2:term","3:browser","4:video","5:pdf","6:note","7:thunar","8:games","9:torrent"]
myManageHook = composeAll
    [ className =? "MPlayer" --> doFloat 
    , className =? "Wine" --> doShift "8:games"
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Opera"  --> doShift "3:browser"
    , className =? "Thunar" --> doShift "7:thunar"
    , className =? "Rednotebook" --> doShift "6:note"
	, isDialog  --> doCenterFloat
    , className =? "Xmessage" --> doCenterFloat
    , className =? "feh"	--> doCenterFloat 
    , className =? "Apvlv"		--> doShift "5:pdf"
    , className =? "torrent"    --> doShift "9:torrent"
    , className =? "Evince"		-->  doShift "5:pdf"
    , className =? "xterm"          --> doFloat ]
--}}}

--{{{ Events
myEventHook = mempty
--}}}

--{{{ Core
myStartupHook = startup
startup :: X()
startup = do
	--spawn "$LOCK/xail $HOME/bin/xail"
	--do
	  spawnOn "2:term" "$LOCK/term xterm -bg '#2e2e2e' -fs 12 -e 'screen -d -R -S term'" 
	  spawnOn "9:torrent" "$LOCK/torrent xterm  -bg '#2e2e2e' -fs 12 -fg black"
		--spawnOn "3:browser" "$LOCK/browser xterm"
		--spawnOn "4:mail" "xterm -e 'screen -d -R'"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = myLayout,

        manageHook         = composeAll 
                               [ myManageHook
                                ,manageSpawn 
                               ],
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ xmobarPP
                                         { ppOutput = hPutStrLn xmproc
										 , ppUrgent = xmobarColor "red" "" . wrap "*" "*" 
                                         , ppTitle = xmobarColor "green" "" . shorten 10      
                                         }, 
        startupHook        = myStartupHook
    }
--}}} 
