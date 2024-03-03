local M = {}

-- Imports:
--- Left:
local apple = require("items.apple")
local spaces = require("items.spaces")
local front_app = require("items.front_app")

--- Center:
local media = require("items.media")

--- Right:
local calendar = require("items.calendar")
local battery = require("items.battery")
local volume = require("items.volume")
local wifi = require("items.wifi")
local slack = require("items.slack")
local discord = require("items.discord")
local mail = require("items.mail")
local brew = require("items.brew")
local cpu = require("items.cpu")

-- local github = require("items.github") PIXTODO: Finish this figure out the reader
-- local network = require("items.network")
-- local volume = require("items.volume")
-- local memory = require("items.memory")
-- local cpu = require("items.cpu")
-- local cpu_temp = require("items.cpu_temp")
-- local cpu_graph = require("items.cpu_graph

-- Attaching to Module:
M.apple = apple
M.battery = battery
M.brew = brew
M.calendar = calendar
M.discord = discord
M.front_app = front_app
M.media = media
M.mail = mail
M.slack = slack
M.spaces = spaces
M.volume = volume
M.wifi = wifi
M.cpu = cpu
-- M.github = github --PIXTODO: Finish this

-- Returning Module for convience later perhaps.
return M
