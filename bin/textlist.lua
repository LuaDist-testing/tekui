#!/usr/bin/env lua

local String = require "tek.lib.string"
local ui = require "tek.ui"

local function getline(color, lnr)
	local line = "Line " .. lnr .. " " .. os.date() .. " - " .. os.date() .. "-------"
	line = String.new():set(line)
	line:setmetadata(color, 1, line:len())
	return line
end

ui.Application:new {
	AuthorStyles = [[
tek.ui.class.textedit.textlist {
	font: ui-fixed:18;
	margin: 6;
}
tek.ui.class.canvas.textlist {
	border-style: inset;
	border-width: 2;
	margin: 4;
}
]],
	Children = {
		ui.Window:new {
-- 			show = function(self)
-- 				ui.Window.show(self)
-- 				self.Drawable:setAttrs { Debug = true }
-- 			end,
			HideOnEscape = true,
			Orientation = "vertical",
			Children = { 
				ui.Group:new {
					Orientation = "vertical",
					Children = {
						ui.Text:new { 
							Style = "font:ui-fixed:18; text-align:left; padding-left:0; border-width:0; margin:0",
							Text = " Table/List Header"
						},
						ui.TextList:new {
							Id = "textlist",
							BGPens = { "#000", "#800", "#fff" },
							FGPens = { "#fff", "#fff", "#000" },
							HardScroll = true,
							-- Latch = "bottom", -- default
							Data = { 
"This is a new text/list class that allows",
"for colorization and efficient resizing.",
"Also it uses the new string class.",
"It's currently in prototype state, so the",
"class implementation is located under",
"bin/tek/ui/class. It will be moved to the",
"main tree when it's finished.",
"Until then, use it on your own risk and be",
"prepared for changes.",
"Use the buttons below to add some lines.",
"Note that the visible range can be latched",
"on to the top and bottom of the list.",
}
						},
					}
				},
				ui.Group:new {
					Children = {
						ui.Button:new {
							Width = "auto",
							Text = "Add On Top",
							InitialFocus = true,
							onClick = function(self)
								local tw = self:getById("textlist")
								local lnr = 1
								tw:addLine(getline(1, lnr), lnr)
							end
						},
						ui.Button:new {
							Width = "auto",
							Text = "Add In Center",
							onClick = function(self)
								local tw = self:getById("textlist")
								local lnr = math.max(1, math.floor(tw:getNumLines() / 2))
								tw:addLine(getline(2, lnr), lnr)
							end
						},
						ui.Button:new {
							Width = "auto",
							Text = "Add On Bottom",
							onClick = function(self)
								local tw = self:getById("textlist")
								local lnr = tw:getNumLines() + 1
								tw:addLine(getline(3, lnr), lnr)
							end
						},
						ui.Area:new { Width = "free", Height = "auto" },
						ui.Button:new {
							Width = "auto",
							Text = "Clear",
							onClick = function(self)
								local tw = self:getById("textlist")
								tw:clear()
							end
						},
					},
				},
			}
		}
	}
}:run()
