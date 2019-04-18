-- Imports {{{
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86
import System.IO

import XMonad
import XMonad.Actions.Plane
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Prompt
import XMonad.Prompt.Shell
import qualified XMonad.StackSet as W
import XMonad.StackSet (greedyView, swapMaster, view)
import XMonad.Util.Run (spawnPipe)
-- }}}

-- Key Bindings {{{
myMovementKeys config = M.fromList $
    [ ((ctrl, xK_h), pMove ToLeft)
    , ((ctrl, xK_j), pMove ToDown)
    , ((ctrl, xK_k), pMove ToUp)
    , ((ctrl, xK_l), pMove ToRight)
    , ((both, xK_h), pShift ToLeft)
    , ((both, xK_j), pShift ToDown)
    , ((both, xK_k), pShift ToUp)
    , ((both, xK_l), pShift ToRight)
    , ((mask, xK_s), spawn "gnome-screenshot")
    , ((0,    xF86XK_AudioMute),        spawn "amixer -q -D pulse set Master toggle")
    , ((0,    xF86XK_AudioLowerVolume), spawn "amixer -q -D pulse set Master 5%-")
    , ((0,    xF86XK_AudioRaiseVolume), spawn "amixer -q -D pulse set Master 5%+")
    ] where
        mask    = modMask config
        shft    = mask .|. shiftMask
        ctrl    = mask .|. controlMask
        both    = shft .|. controlMask
        pMove   = planeMove (Lines 3) Circular
        pShift  = planeShift (Lines 3) Circular

myKeys config = M.union (keys defaultConfig config) (myMovementKeys config)

myMouseBindings config = M.fromList $
    [ ((modMask config, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modMask config, button2), (\w -> focus w >> windows swapMaster))
    , ((modMask config, button3), (\w -> focus w >> mouseResizeWindow w))
    ]
-- }}}

myWorkspaces =
    [ "1:rgaf", "2:http", "3:lang"
    , "4:logs", "5:code", "6:dbug"
    , "7:mail", "8:psql", "9:chat"
    ]

myLayouts = tall ||| Mirror (tall) ||| Grid ||| Mirror Grid ||| full
    where
      tall = ResizableTall 1 (3 / 100) (3 / 4) []
      full = noBorders (fullscreenFull Full)

myStartupHook = do
    setWMName "LG3D"
    windows $ view "5:code"

main = do
    xmproc <- spawnPipe "xmobar /home/rgaf/.xmobarrc"
    xmonad $ defaultConfig
        { terminal = "WINIT_HIDPI_FACTOR=1.0 alacritty"
        , focusFollowsMouse = True
        , borderWidth = 1
        , normalBorderColor = "#cccccc"
        , focusedBorderColor = "#00ff00"
        , modMask = mod4Mask
        , workspaces = myWorkspaces
        , keys = myKeys
        , mouseBindings = myMouseBindings
        , manageHook = manageDocks <+>  manageHook defaultConfig
        , layoutHook = avoidStruts $ smartBorders $ myLayouts
        , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , startupHook = setWMName "LG3D"
        }
