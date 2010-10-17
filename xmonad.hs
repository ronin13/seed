-- XMonad Configuration

--{{{ Imports
--import XMonad.StackSet
import XMonad.Layout.Gaps
import XMonad hiding ( (|||) )
import XMonad.Actions.NoBorders
import Monad
import XMonad.Layout.HintedGrid as H
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
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.LayoutHints
--centerFloat
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.SinkAll
import XMonad.Util.Types
import XMonad.Prompt
import XMonad.Prompt.Window

import Text.Regex
import XMonad.Hooks.InsertPosition
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

import XMonad.Hooks.ServerMode
import XMonad.Actions.Commands
--}}} 

--{{{ Testing 
toggleOrViewNoSP = toggleOrDoSkip ["NSP"]  W.greedyView
--}}}
--
--{{{ Core
main = do
    -- write a perl replacement to remove the workspace name
    --xmproc <- spawnPipe "perl -lpe 's/(\\d):\\w+/\\1/ig' | tee /tmp/testp |  xmobar"
    -- xmproc <- spawnPipe  "tee /tmp/testp | xmobar"
    xmproc <- spawnPipe  "perl -lpe '$|=1; s/(\\d):\\w+/\\1/ig' | xmobar"
-- FocusHook
    xmonad $ ewmh $ withUrgencyHookC NoUrgencyHook urgentConfig $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        mouseBindings      = myMouseBindings,
        keys               = myKeys,
        --layoutHook         = layoutHintsWithPlacement (0,1) myLayout,
        layoutHook         = myLayout,
        --manageHook         = insertPosition Below Newer <+> myManageHook,
        manageHook         = myManageHook,
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
myBorderWidth   = 1
myModMask       = mod4Mask
myNormalBorderColor  = "red"
myFocusedBorderColor = "white"


myXPConfig = defaultXPConfig
    { 
	font  = "xft:Liberation:pixelsize=14" 
	, fgColor = "grey50"
	, bgColor = "grey2"
	, position = Bottom
    }
--}}}

--{{{ Keybindings 
--myKeys conf = mkKeymap conf $
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

     [ ((modm, xK_q     ), kill1)

    ,  ((modm,  xK_r),   withFocused toggleBorder)

    , ((mod1Mask, xK_space), scratchpadSpawnActionCustom "$HOME/bin/scratcher")

    , ((modm, xK_period), toggleWS )

    , ((modm              , xK_BackSpace), focusUrgent)

    , ((modm, xK_slash), windowPromptGoto myXPConfig { autoComplete = Just 5000000 } )

    , ((modm,               xK_space ), sendMessage NextLayout)

    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modm .|. shiftMask, xK_h ), sendMessage MirrorShrink)

    , ((modm .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    -- , ((modm,               xK_n     ), refresh)
    -- , ((modm,               xK_n     ), refresh)

    , ((modm .|. shiftMask, xK_Up),  nextWS)

    , ((modm, xK_Up),  moveTo Next NonEmptyWS)

    , ((modm, xK_Down), moveTo Prev NonEmptyWS)

    {-, ((modm .|. mod1Mask, xK_Up),  moveTo Next EmptyWS)-}

    {-, ((modm .|. mod1Mask, xK_Down), moveTo Next EmptyWS)-}

    , ((modm .|. shiftMask, xK_Down),   prevWS)

    , ((modm,             xK_b), sendMessage ToggleStruts) 

    , ((modm,               xK_Right     ), windows W.focusDown)

    , ((modm,               xK_Left     ), windows W.focusUp  )

    , ((modm,               xK_m     ), windows W.focusMaster  )

    , ((modm , xK_g    ), sendMessage Toggle)

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
myLayout = onWorkspace "3:browser" brLayout $ onWorkspace "7:games" vidLayout $ defLayout
      where
--           defLayout = avoidStruts $ noBorders (tiled ||| Mirror tiled ||| Full)
          defLayout = avoidStruts $ mgFy ( tiled ||| Mirror tiled ||| Full)
          tiled     = smartBorders tall
          tall      = ResizableTall 1 (2/100) (1/2) []
          brLayout  = avoidStruts (Mirror tiled ||| mgFy tiled ||| Full)
          --mgFy      = Mag.magnifiercz 1.4
          mgFy      = Mag.magnifiercz 1.4 
          -- . Mag.magnifierOff
          vidLayout = H.Grid False ||| Full
--}}}

--{{{ Workspaces
-- appName =? "foo" --> (ask >>= \w -> liftX (toggleBorder w) >> idHook)
-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-Monitor.html
myWorkspaces :: [WorkspaceId]
myWorkspaces    = ["1:norm","2:term","3:browser","4:video","5:pdf","6:note","7:thunar","8:games","9:misc"]
myManageHook = composeAll . concat $
    [ [     className =? a                --> doFloat               | a <- myFloats              ]
--    , [     className =? "MPlayer"        --> (ask >>= \w -> liftX (toggleBorder w) >> doFloat)  ]
    , [     isFullscreen                  --> doFullFloat                                      ]
    , [     className =? "Wine"           --> doShift "8:games"                                  ]
    , [     resource  =? c                --> doIgnore              | c <- myIgnores             ]
    , [     className =? "Gpodder"        --> doShift "9:misc"                                   ]
    , [     className =? b                --> doShift "3:browser"   | b <- myBrowsers            ]
    , [     className =? "Thunar"         --> doShift "7:thunar"                                 ]
    , [     className =? "Rednotebook"    --> doShift "6:note"                                   ]
	, [     className =? d  <||> isDialog --> doCenterFloat         | d <- myCenterFloats        ]
    , [     className =? e 		          --> doShift "5:pdf"       | e <- myPDF                 ]
    , [     manageDocks                                                                          ]
    , [     transience'                                                                          ] ]
    where
      myFloats =  ["MPlayer"] 
     -- myFloats =  []
     -- To use mplayer float and fullscreen good, do all mplayer fs type stuff
     -- for isFullscreen to work.. lol
      myCenterFloats = ["Xmessage","feh"]
      myBrowsers = ["Opera","Firefox","Shiretoko","Chromium","Google-chrome","Namoroka"] -- Namoroka
      myPDF = ["Evince","Zathura","Apvlv"]
      myIgnores = ["desktop_window","desktop"]
--}}}

-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-Timer.html
-- for mplayer
--{{{ Events
--myEventHook = mempty
--myEventHook = ewmhDesktopsEventHook
--  http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-ServerMode.html
myEventHook = serverModeEventHook
--}}}

--{{{ Startup
myStartupHook = mempty
-- myStartupHook = startup
-- startup :: X()
-- startup = do
-- 	  spawnOn "2:term" "~/bin/tst" 
--}}}

--{{{ LogHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }
 
---- Looks --
---- bar
customPP :: PP
customPP = defaultPP { 
                ppHidden = xmobarColor "#0000FF" "" . noScratchPad
              , ppOrder = \(ws:l:t:_) -> [l,ws]
              , ppCurrent = xmobarColor "gray" ""
            -- .  head . splitRegex (mkRegex ":")
              , ppUrgent = xmobarColor "green" "" . wrap "*" "*"
            --, ppVisible = head . splitRegex (mkRegex ":")
              , ppWsSep =  " "
              , ppLayout = xmobarColor "DarkOrchid" "" . wrap "[" "]"
              , ppTitle = xmobarColor "slateblue" "" . shorten 25
              , ppSep = "<fc=#0033FF> . </fc>"
            }
        where 
            noScratchPad ws = if ws == "NSP" then "" else pad ws 
--}}}
