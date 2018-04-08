
local helper = wesnoth.require "lua/helper.lua"
local utils = wesnoth.require "wml-utils"

function wesnoth.wml_actions.scatter_units(cfg) -- replacement for SCATTER_UNITS macro
	local locations = wesnoth.get_locations( wml.get_child( cfg, "filter_location" ) ) or helper.wml_error( "Missing required [filter_location] in [scatter_units]" )
	local unit_string = cfg.unit_types or helper.wml_error( "Missing required unit_types= in [scatter_units]" )
	local units = tonumber( cfg.units ) or helper.wml_error( "Missing or wrong required units= in [scatter_units]" )
	local scatter_radius =  tonumber( cfg.scatter_radius ) -- not mandatory, if nil cycle will be jumped
	local unit_table = wml.parsed( wml.get_child( cfg, "wml" ) ) or {} -- initialize as empty table, just in need

	local unit_types = {} -- create a table, then append each value after splitting with string.gmatch.

	for value in string.gmatch( unit_string, "[^%s,][^,]*" ) do
		table.insert( unit_types, value )
	end

	if #locations <=0 then return -- if no locations, end
	else
		repeat -- repeat cycle is executed at least once
			local rand_locs = "1.." .. #locations -- concatenation for use by WML rand
			local rand_units = "1.." .. #unit_types
			local index = helper.rand( rand_locs ) -- use helper.rand, to avoid OOS errors
			local index2 = helper.rand( rand_units )
			local where_to_place = locations[index]

			local unit_to_put = unit_table
			unit_to_put.type = unit_types[index2]

			local free_x, free_y = wesnoth.find_vacant_tile( where_to_place[1], where_to_place[2], unit_to_put)
			-- to avoid placing units in strange terrains, or overwriting, in case that the WML coder placed a wrong filter;
			-- in such case, respect of scatter_radius is not guaranteed, exactly like in SCATTER_UNITS

			unit_to_put.x, unit_to_put.y = free_x, free_y
			wesnoth.put_unit( unit_to_put )
			table.remove( locations, index ) -- to remove such location from the available list, because it's already busy, and avoid overwriting already placed units
			if scatter_radius then -- loop for scatter_radius; will remove every location within the radius
				-- apparently, a reversed ipairs like below is the best way to check every location
				-- and remove those that are too close
				-- using standard ipairs jumps some locations
				for index = #locations, 1, -1 do --lenght of locations, until 1, step -1
					local distance = wesnoth.map.distance_between( where_to_place[1], where_to_place[2], locations[index][1], locations[index][2] )

					if distance < scatter_radius then
						table.remove( locations, index )
					end
				end
			end

			units = units - 1 -- counter variable
		until units <= 0 or #locations <= 0
	end
end

function wesnoth.wml_actions.nearest_unit(cfg)
	local starting_x = tonumber(cfg.starting_x) or helper.wml_error("Missing required starting_x in [nearest_unit]")
	local starting_y = tonumber(cfg.starting_y) or helper.wml_error("Missing required starting_y in [nearest_unit]")
	local filter = (wml.get_child(cfg, "filter")) or helper.wml_error("Missing required [filter] in [nearest_unit]")
	local variable = cfg.variable or "nearest_unit" -- default

	local current_distance = math.huge -- feed it the biggest value possible
	local nearest_unit_found

	for index,unit in ipairs(wesnoth.get_units(filter)) do
		local distance = wesnoth.map.distance_between( starting_x, starting_y, unit.x, unit.y )
		if distance < current_distance then
			current_distance = distance
			nearest_unit_found = unit
		end
	end

	if nearest_unit_found then
		wesnoth.wml_actions.store_unit( { variable = variable, { "filter", { id = nearest_unit_found.id } } } )
	else wesnoth.message( "WML", "No suitable unit found by [nearest_unit]" )
	end
end

-- This isn't actually part of the Wesnoth Lua Pack, but...
-- I didn't feel like creating a new file to host it.
local items = wesnoth.require "wml/items"
function wesnoth.wml_actions.highlight_image(cfg)
	local img = cfg.image or helper.wml_error("[highlight_image] missing required image= key")
	local bg = cfg.background or ""
	local where = wesnoth.get_locations(cfg)[1]
	if not where then return end
	
	wesnoth.scroll_to_tile(where, false, false, true)
	if cfg.outline then
		wesnoth.highlight_hex(where)
	end

	for i = 1, 3 do
		items.place_halo(where[1], where[2], img)
		wesnoth.wml_actions.redraw{}
		wesnoth.delay(300)
		items.remove(where[1], where[2])
		items.place_image(where[1], where[2], bg)
		wesnoth.wml_actions.redraw{}
		wesnoth.delay(300)
	end

	if cfg.leave ~= false then
		items.place_image(where[1], where[2], img)
	end
	wesnoth.wml_actions.redraw{}
end

-- Override move_unit to support location_id
local old_move = wesnoth.wml_actions.move_unit
function wesnoth.wml_actions.move_unit(cfg)
	if cfg.to_location then
		cfg = wml.shallow_parsed(cfg)
		local to = wesnoth.special_locations[cfg.to_location]
		cfg.to_x, cfg.to_y = to[1], to[2]
	elseif cfg.dir then
		-- Well, in this case we need to separate it out to multiple calls to the original.
		-- That's because the locs for each unit are different!
		for _,u in ipairs(wesnoth.get_units(cfg)) do
			local x_locs, y_locs = {}, {}
			x_locs[0], y_locs[0] = u.x, u.y
			for dir in utils.split(cfg.dir) do
				local count = 1
				if dir:find(":") then
					local error_dir = dir
					dir, count = dir:match("([a-z]+):(%d+)")
					if not dir or not count then
						wml.error("Invalid direction:count in move_unit: " .. error_dir)
					end
				end
				local last_x, last_y = x_locs[#x_locs], y_locs[#y_locs]
				next_loc = wesnoth.map.get_direction(last_x, last_y, dir, count)
				table.insert(x_locs, next_loc[1])
				table.insert(y_locs, next_loc[2])
			end
			x_locs[0], y_locs[0] = nil
			local this_cfg = {
				id = u.id,
				to_x = x_locs,
				to_y = y_locs,
			}
			old_move(wml.tovconfig(this_cfg))
		end
		return
	end
	old_move(cfg)
end

-- Override teleport to support location_id
local old_teleport = wesnoth.wml_actions.teleport
function wesnoth.wml_actions.teleport(cfg)
	if cfg.location_id then
		cfg = wml.shallow_parsed(cfg)
		local to = wesnoth.special_locations[cfg.location_id]
		cfg.x, cfg.y = to[1], to[2]
	end
	old_teleport(cfg)
end

-- Add formula= to [variable]
-- Doesn't work for array variables though
-- Note: Remove in 1.15 as it's built-in there
local old_variable = wesnoth.wml_conditionals.variable
function wesnoth.wml_conditionals.variable(cfg)
	if cfg.formula then
		local value = wml.variables[cfg.name]
		local result = wesnoth.eval_formula(cfg.formula, {value = value})
		-- WFL considers 0 as false; Lua doesn't
		if result == 0 then return false end
		return result
	else
		return old_variable(cfg)
	end
end

-- Places a unit at a random location matching the filter
-- Automatically excludes locations that already have a unit
-- If all matching locations already have a unit, it does nothing
function wesnoth.wml_actions.random_unit(cfg)
	local filter = wml.get_child(cfg, "filter_location") or helper.wml_error "Missing [filter_location] in [random_unit]"
	filter = {
		wml.tag["and"](filter),
		wml.tag["not"]{ wml.tag.filter{} }
	}
	local possible_locations = wesnoth.get_locations(filter)
	if #possible_locations == 0 then
		std_print("Error: No matching locations!")
		return
	end
	cfg = wml.shallow_parsed(cfg)
	wml.remove_child(cfg, "filter_location")
	local which_loc = #possible_locations == 1 and 1 or wesnoth.random(1, #possible_locations)
	cfg.x = possible_locations[which_loc][1]
	cfg.y = possible_locations[which_loc][2]
	wesnoth.wml_actions.unit(cfg)
end
