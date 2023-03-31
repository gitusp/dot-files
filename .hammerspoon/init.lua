hs.window.animationDuration = 0
units = {
  right   = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left    = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top     = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bottom  = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  one     = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  two     = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  three   = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  four    = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  maximum = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
  center  = { x = 0.17, y = 0.00, w = 0.66, h = 1.00 }
}

mash = { 'option', 'ctrl', 'cmd' }
hs.hotkey.bind(mash , 'right' , function() hs.window.focusedWindow():move(units.right   , nil , true) end)
hs.hotkey.bind(mash , 'left'  , function() hs.window.focusedWindow():move(units.left    , nil , true) end)
hs.hotkey.bind(mash , 'up'    , function() hs.window.focusedWindow():move(units.top     , nil , true) end)
hs.hotkey.bind(mash , 'down'  , function() hs.window.focusedWindow():move(units.bottom  , nil , true) end)
hs.hotkey.bind(mash , '1'     , function() hs.window.focusedWindow():move(units.one     , nil , true) end)
hs.hotkey.bind(mash , '2'     , function() hs.window.focusedWindow():move(units.two     , nil , true) end)
hs.hotkey.bind(mash , '3'     , function() hs.window.focusedWindow():move(units.three   , nil , true) end)
hs.hotkey.bind(mash , '4'     , function() hs.window.focusedWindow():move(units.four    , nil , true) end)
hs.hotkey.bind(mash , 'm'     , function() hs.window.focusedWindow():move(units.maximum , nil , true) end)
hs.hotkey.bind(mash , 'n'     , function() hs.window.focusedWindow():move(units.center  , nil , true) end)
