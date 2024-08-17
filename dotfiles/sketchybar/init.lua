-- Require the sketchybar module globally
sbar = require("sketchybar")
settings = require("settings")
colours = require("colours")
app_icons = require("app_icons")
icons = require("icons")

-- Do setup in one config call
sbar.begin_config()

-- Options
sbar.hotload(true)

-- Modules
require("bar")
require("defaults")
require("items")
require("brackets")

sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- bi-directional communication between the lua module and sketchybar)
-- This must be the last thing in the config, nothing runs after this:
sbar.event_loop()
