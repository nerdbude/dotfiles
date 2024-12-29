        ------------------------------------------------------------------------
        ---IMPORTS
        ------------------------------------------------------------------------
        -- Base
        import XMonad
        import XMonad.Config.Desktop
        import Data.Monoid
        import Data.Maybe (isJust)
        import System.IO (hPutStrLn)
        import System.Exit (exitSuccess)
        import qualified XMonad.StackSet as W

        -- Utilities
        import XMonad.Util.Loggers
        import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)
        import XMonad.Util.NamedScratchpad
        import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
        import XMonad.Util.SpawnOnce
        
        -- Hooks
        import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
        import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
        import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat)
        import XMonad.Hooks.Place (placeHook, withGaps, smart)
        import XMonad.Hooks.SetWMName
        import XMonad.Hooks.EwmhDesktops
        
        -- Actions
        import XMonad.Actions.Minimize (minimizeWindow)
        import XMonad.Actions.Promote
        import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
        import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
        import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
        import XMonad.Actions.WithAll (sinkAll, killAll)
        import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen, shiftNextScreen, shiftPrevScreen)
        import XMonad.Actions.GridSelect
        import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
        import XMonad.Actions.MouseResize
        import qualified XMonad.Actions.ConstrainedResize as Sqr
        
        -- Layouts modifiers
        import XMonad.Layout.PerWorkspace (onWorkspace)
        import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
        import XMonad.Layout.WorkspaceDir
        import XMonad.Layout.Spacing (spacing)
        import XMonad.Layout.NoBorders
        import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
        import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
        import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
        import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
        import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
        import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
        
        -- Layouts
        import XMonad.Layout.NoFrillsDecoration
        import XMonad.Layout.GridVariants (Grid(Grid))
        import XMonad.Layout.SimplestFloat
        import XMonad.Layout.OneBig
        import XMonad.Layout.ThreeColumns
        import XMonad.Layout.ResizableTile
        import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
        import XMonad.Layout.IM (withIM, Property(Role))
        
        -- Prompts
        import XMonad.Prompt (XPConfig(..), XPPosition(Top), Direction1D(..))
        ------------------------------------------------------------------------
        ---CONFIG
        ------------------------------------------------------------------------
        myFont          = "xft:Berkeley Mono Nerd Font:style=Regular:pixelsize=11"
        myModMask       = mod4Mask
        myTerminal      = "alacritty"
        myTextEditor    = "nvim"
        myBorderWidth   = 2
        windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
        
        main = do
            -- Launching XMobar with config
            xmproc0 <- spawnPipe "xmobar -x 0"
            --xmproc1 <- spawnPipe "xmobar -x 1" -- For XMobar on other Displays in Multi-Monitor Setup
            --xmproc2 <- spawnPipe "xmobar -x 2" --
        
            xmonad $ ewmh desktopConfig
                { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
                , logHook = dynamicLogWithPP xmobarPP
                                { ppOutput = \x -> hPutStrLn xmproc0 x -- >> hPutStrLn xmproc1 x  >> hPutStrLn xmproc2 x
                                , ppCurrent = xmobarColor "#FF79C6" "" . wrap "" "" -- Current workspace in xmobar
                                , ppVisible = xmobarColor "#44475A" ""                -- Visible but not current workspace
                                , ppHidden = xmobarColor "#BD93F9" "" . wrap "" ""   -- Hidden workspaces in xmobar
                                , ppHiddenNoWindows = xmobarColor "#6272A4" ""        -- Hidden workspaces (no windows)
                                , ppTitle = xmobarColor "#8BE9FD" "" . wrap "[ " " ]" . shorten 80     -- Title of active window in xmobar
                                , ppSep =  "<fc=#50FA7B> :: </fc>"                     -- Separators
                                , ppUrgent = xmobarColor "#FF55555" "" . wrap "!" "!"  -- Urgent workspace
                                , ppExtras  = [windowCount]                           -- # of windows current workspace
                                , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                                }
                , modMask            = myModMask
                , terminal           = myTerminal
                , startupHook        = myStartupHook
                , layoutHook         = myLayoutHook
                , workspaces         = myWorkspaces
                , borderWidth        = myBorderWidth
                , normalBorderColor  = "#44475A"
                , focusedBorderColor = "#BD93F9"
                } `additionalKeysP`         myKeys
        
        ------------------------------------------------------------------------
        ---AUTOSTART
        ------------------------------------------------------------------------
        myStartupHook = do
                  spawnOnce "nitrogen --restore &"
                  --- spawnOnce "xmobar -x 0"
        ------------------------------------------------------------------------
        --- SET KEYS - TO FIND KEY IDENTIFIERS: XEV
        ------------------------------------------------------------------------
        myKeys =
            -- Xmonad (Mod + Control/Shift + Key)
                [ ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
                , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
                , ("M-S-q", io exitSuccess)                  -- Quits xmonad
        
            -- Windows (Mod + Shift)
                , ("M-S-c", kill1)                           -- Kill the currently focused client
                , ("M-S-a", killAll)                         -- Kill all the windows on current workspace
        
            -- Floating windows
                , ("M-<Delete>", withFocused $ windows . W.sink)  -- Push floating window back to tile.
                , ("M-S-<Delete>", sinkAll)                  -- Push ALL floating windows back to tile.
        
            -- Windows navigation
                , ("M-m", windows W.focusMaster)             -- Move focus to the master window
                , ("M-j", windows W.focusDown)               -- Move focus to the next window
                , ("M-k", windows W.focusUp)                 -- Move focus to the prev window
                , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window
                , ("M-S-j", windows W.swapDown)              -- Swap the focused window with the next window
                , ("M-S-k", windows W.swapUp)                -- Swap the focused window with the prev window
                , ("M-<Backspace>", promote)                 -- Moves focused window to master, all others maintain order
                , ("M1-S-<Tab>", rotSlavesDown)              -- Rotate all windows except master and keep focus in place
                , ("M1-C-<Tab>", rotAllDown)                 -- Rotate all the windows in the current stack
                , ("M-S-s", windows copyToAll)
                , ("M-C-s", killAllOtherCopies)
        
                , ("M-C-M1-<Up>", sendMessage Arrange)
                , ("M-C-M1-<Down>", sendMessage DeArrange)
                , ("M-<Up>", sendMessage (MoveUp 10))             --  Move focused window to up
                , ("M-<Down>", sendMessage (MoveDown 10))         --  Move focused window to down
                , ("M-<Right>", sendMessage (MoveRight 10))       --  Move focused window to right
                , ("M-<Left>", sendMessage (MoveLeft 10))         --  Move focused window to left
                , ("M-S-<Up>", sendMessage (IncreaseUp 10))       --  Increase size of focused window up
                , ("M-S-<Down>", sendMessage (IncreaseDown 10))   --  Increase size of focused window down
                , ("M-S-<Right>", sendMessage (IncreaseRight 10)) --  Increase size of focused window right
                , ("M-S-<Left>", sendMessage (IncreaseLeft 10))   --  Increase size of focused window left
                , ("M-C-<Up>", sendMessage (DecreaseUp 10))       --  Decrease size of focused window up
                , ("M-C-<Down>", sendMessage (DecreaseDown 10))   --  Decrease size of focused window down
                , ("M-C-<Right>", sendMessage (DecreaseRight 10)) --  Decrease size of focused window right
                , ("M-C-<Left>", sendMessage (DecreaseLeft 10))   --  Decrease size of focused window left
        
            -- Layouts
                , ("M-<Tab>", sendMessage NextLayout)                              -- Switch to next layout
                , ("M-S-<Space>", sendMessage ToggleStruts)                          -- Toggles struts
                , ("M-S-n", sendMessage $ Toggle NOBORDERS)                          -- Toggles noborder
	            , ("M-S-=", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
                , ("M-S-f", sendMessage (T.Toggle "float"))
                , ("M-S-x", sendMessage $ Toggle REFLECTX)
                , ("M-S-y", sendMessage $ Toggle REFLECTY)
                , ("M-S-m", sendMessage $ Toggle MIRROR)
        
                , ("M-h", sendMessage Shrink)
                , ("M-l", sendMessage Expand)
                , ("M-C-j", sendMessage MirrorShrink)
                , ("M-C-k", sendMessage MirrorExpand)
                , ("M-S-;", sendMessage zoomReset)
                , ("M-;", sendMessage ZoomFullToggle)
        
            -- Open Terminal (Mod+Enter)
                , ("M-<Return>", spawn myTerminal)
            --- Firefox
                , ("M-f", spawn "firefox")
        
            --- ROFI (Shift+Mod+Key)
                , ("M-S-<Return>", spawn "rofi -show run")
            -- Screenbrightness
          
	        , ("<xF86MonBrightnessUp>", spawn "xbacklight +100")
	        , ("<xF86MonBrightnessDown>", spawn "xbacklight -20")
                ] where nonNSP          = WSIs (return (\ws -> W.tag ws /= "nsp"))
                        nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))
        
        ------------------------------------------------------------------------
        ---WORKSPACES
        ------------------------------------------------------------------------
        xmobarEscape = concatMap doubleLts
          where
                doubleLts '<' = "<<"
                doubleLts x   = [x]
        
        myWorkspaces :: [String]
        myWorkspaces = clickable . (map xmobarEscape)
                      $ ["●", "●", "●", "●", "●", "●", "●", "●", "●"]
          where
                clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                              (i,ws) <- zip [1..9] l,
                              let n = i ]
        myManageHook :: Query (Data.Monoid.Endo WindowSet)
        myManageHook = composeAll
            [
                className =? "Firefox"     --> doShift "<action=xdotool key super+1>www</action>"
              , title =? "Vivaldi"         --> doShift "<action=xdotool key super+1>www</action>"
              , title =? "irssi"           --> doShift "<action=xdotool key super+9>irc</action>"
              , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
            ] 

        --    <+> namedScratchpadManageHook myScratchPads
        
        ------------------------------------------------------------------------
        --- LAYOUTS
        ------------------------------------------------------------------------
        
        myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $
                       mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
                    where
                        myDefaultLayout = deco ||| grid ||| threeCol ||| threeRow ||| oneBig ||| noBorders monocle ||| space ||| floats ||| tall
        

        tall       = renamed [Replace "T"]     $ limitWindows 12 $ spacing 6 $ ResizableTall 1 (3/100) (1/2) [] 
        grid       = renamed [Replace "G"]     $ limitWindows 12 $ spacing 6 $ mkToggle (single MIRROR) $ Grid (16/10)
        threeCol   = renamed [Replace "3C"]    $ limitWindows 3  $ ThreeCol 1 (3/100) (1/2)
        threeRow   = renamed [Replace "3R"]    $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
        oneBig     = renamed [Replace "1B"]    $ limitWindows 6  $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
        monocle    = renamed [Replace "M"]     $ limitWindows 20 $ Full
        space      = renamed [Replace "S"]     $ limitWindows 4  $ spacing 12 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
        floats     = renamed [Replace "F"]     $ limitWindows 20 $ simplestFloat
        deco	   = renamed [CutWordsLeft 1]  $ noFrillsDeco shrinkText myTitleTheme tall
        
        myTitleTheme :: Theme
        myTitleTheme = def {
                fontName			= "Berkeley Mono Nerd Font:style=Regular"
	            , inactiveBorderColor   = "#44475A"
	            , inactiveColor		    = "#44475A"
	            , inactiveTextColor	    = "#50FA7B"
	            , activeBorderColor	    = "#BD93F9"
	            , activeColor			= "#BD93F9"
	            , activeTextColor		= "#44475A"
	            , urgentBorderColor	    = "#50FA7B"
	            , urgentTextColor		= "#44475A"
	            , urgentColor			= "#50FA7B"
	            , decoHeight			= 12 
        
        }

