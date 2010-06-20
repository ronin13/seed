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
import XMonad.Actions.OnScreen
import XMonad.Util.Scratchpad (scratchpadSpawnActionCustom)
import XMonad.Actions.CopyWindow

import XMonad.Layout.LayoutHints (layoutHintsWithPlacement)
--centerFloat
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.SinkAll

import XMonad.Prompt
import XMonad.Prompt.Window

--Grid
--import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace  (onWorkspace)
import XMonad.Layout.LayoutCombinators
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import XMonad.Actions.CycleWS
-- import XMonad.Layout.Monitor

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
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        mouseBindings      = myMouseBindings,
        keys               = myKeys,
        layoutHook         = myLayout,
        manageHook         = composeAll [ myManageHook, manageSpawn ],
        handleEventHook    = myEventHook,
        logHook            = myLogHook xmproc, 
        startupHook        = myStartupHook
        }
 
--}}}

--{{{ Variabl es 
myTerminal      = "xterm"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myBorderWidth   = 1
myModMask       = mod4Mask
myNormalBorderColor  = "green"
myFocusedBorderColor = "white"


myXPConfig = defaultXPConfig                                    
    { 
	font  = "xft:Bitstream Vera Sans Mono:pixelsize=14:bold" 
	, fgColor = "Black"
	, bgColor = "White"
	, position = Bottom
    }
--}}}

--{{{ Keyb indings 
--myKeys conf = mkKeymap conf $
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

     [ ((modm, xK_q     ), kill1)

    , ((mod1Mask, xK_space), scratchpadSpawnActionCustom "$HOME/bin/scratcher")

    , ((modm, xK_period), toggleWS )

    , ((modm, xK_slash), windowPromptGoto myXPConfig { autoComplete = Just 5000000 } )

    , ((modm,               xK_space ), sendMessage NextLayout)

    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modm .|. shiftMask, xK_h ), sendMessage MirrorShrink)

    , ((modm .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    , ((modm,               xK_n     ), refresh)

    , ((modm .|. shiftMask, xK_Right),  nextWS)

    , ((modm, xK_Up),  moveTo Next NonEmptyWS)

    , ((modm, xK_Down), moveTo Next NonEmptyWS)

    , ((modm .|. shiftMask, xK_Left),   prevWS)

    , ((modm,               xK_Right     ), windows W.focusDown)

    , ((modm,               xK_Left     ), windows W.focusUp  )

    , ((modm,               xK_m     ), windows W.focusMaster  )

    , ((modm .|. shiftMask, xK_t     ), sinkAll)

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

    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")

    ]
    ++
     [((m .|. modm, k), f i)
     | (i, k) <- zip (XMonad.workspaces conf) [xK_1 ..]
     , (f, m) <- [(windows . W.view, 0), (windows . W.shift, shiftMask), (windows . copy, mod1Mask),(toggleOrViewNoSP,controlMask)]]
 

   -- ++

   -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
     --   | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      --  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((shiftMask, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((shiftMask, button2), (\w -> focus w >> windows W.shiftMaster))

    , ((shiftMask, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    ]
--}}}  

--{{{ Layout 
myLayout =  onWorkspace "4:video" vidLayout $ onWorkspace "7:games" vidLayout $ defLayout
      where
          defLayout = avoidStruts $ Mag.magnifier (tiled ||| Full ||| Mirror tiled)
          tiled     = hinted (smartBorders (ResizableTall 1 (2/100) (1/2) []))
          vidLayout = smartBorders (Grid False ||| Full)
          hinted l  = layoutHintsWithPlacement (0,0) l
--}}}

--{{{ Workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces    = ["1:norm","2:term","3:browser","4:video","5:pdf","6:note","7:thunar","8:games","9:misc"]
myManageHook = composeAll . concat $
    [ [     className =? a                --> doFloat               | a <- myFloats          ]
    , [     isFullscreen                  --> doFullFloat                                    ]  
    , [     className =? "Wine"           --> doShift "8:games"                              ]
    , [     resource  =? c                --> doIgnore              | c <- myIgnores         ]
    , [     className =? "Gpodder"        --> doShift "9:misc"                               ]
    , [     className =? b                --> doShift "3:browser"   | b <- myBrowsers        ]
    , [     className =? "Thunar"         --> doShift "7:thunar"                             ]
    , [     className =? "Rednotebook"    --> doShift "6:note"                               ]
	, [     className =? d  <||> isDialog --> doCenterFloat         | d <- myCenterFloats    ]
    , [     className =? e 		          --> doShift "5:pdf"       | e <- myPDF             ] ]
    where 
      myFloats =  ["MPlayer"] 
      myCenterFloats = ["Xmessage","feh"]
      myBrowsers = ["Opera","Firefox","Shiretoko","Chromium","Google-chrome"]
      myPDF = ["Evince","Zathura","Apvlv"]
      myIgnores = ["desktop_window","desktop"]
--}}}

--{{{ Events
myEventHook = mempty
--}}}

--{{{ Startup
myStartupHook = startup
startup :: X()
startup = do
	  spawnOn "2:term" "~/bin/tst" 
--}}}

--{{{ LogHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }
 
---- Looks --
---- bar
customPP :: PP
customPP = defaultPP { 
                ppHidden = xmobarColor "#00FF00" "" . noScratchPad
              , ppCurrent = xmobarColor "blue" "" . wrap "[" "]"
              , ppUrgent = xmobarColor "red" "" . wrap "*" "*"
              , ppLayout = xmobarColor "Yellow" ""
              , ppTitle = xmobarColor "green" "" . shorten 20
              , ppSep = "<fc=#0033FF> | </fc>"
            }
        where 
            noScratchPad ws = if ws == "NSP" then "" else pad ws 
--}}}
