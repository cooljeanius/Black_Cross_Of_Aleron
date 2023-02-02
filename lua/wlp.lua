
local utils = wesnoth.require "wml-utils"

function wesnoth.wml_actions.scatter_units(cfg) -- replacement for SCATTER_UNITS macro
	local locations = wesnoth.map.find( wml.get_child( cfg, "filter_location" ) ) or wml.error( "Missing required [filter_location] in [scatter_units]" )
	local unit_string = cfg.unit_types or wml.error( "Missing required unit_types= in [scatter_units]" )
	local units = tonumber( cfg.units ) or wml.error( "Missing or wrong required units= in [scatter_units]" )
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
			local index = mathx.random_choice( rand_locs )
			local index2 = mathx.random_choice( rand_units )
			local where_to_place = locations[index]

			local unit_to_put = unit_table
			unit_to_put.type = unit_types[index2]

			local free_x, free_y = wesnoth.paths.find_vacant_hex( where_to_place, unit_to_put)
			-- to avoid placing units in strange terrains, or overwriting, in case that the WML coder placed a wrong filter;
			-- in such case, respect of scatter_radius is not guaranteed, exactly like in SCATTER_UNITS

			unit_to_put.x, unit_to_put.y = free_x, free_y
			wesnoth.units.to_map( unit_to_put )
			table.remove( locations, index ) -- to remove such location from the available list, because it's already busy, and avoid overwriting already placed units
			if scatter_radius then -- loop for scatter_radius; will remove every location within the radius
				-- apparently, a reversed ipairs like below is the best way to check every location
				-- and remove those that are too close
				-- using standard ipairs jumps some locations
				for index = #locations, 1, -1 do --lenght of locations, until 1, step -1
					local distance = wesnoth.map.distance_between(where_to_place, locations[index])

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
	local starting_x = tonumber(cfg.starting_x) or wml.error("Missing required starting_x in [nearest_unit]")
	local starting_y = tonumber(cfg.starting_y) or wml.error("Missing required starting_y in [nearest_unit]")
	local filter = (wml.get_child(cfg, "filter")) or wml.error("Missing required [filter] in [nearest_unit]")
	local variable = cfg.variable or "nearest_unit" -- default

	local current_distance = math.huge -- feed it the biggest value possible
	local nearest_unit_found

	for index,unit in ipairs(wesnoth.units.find_on_map(filter)) do
		local distance = wesnoth.map.distance_between(starting_x, starting_y, unit)
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
	local img = cfg.image or wml.error("[highlight_image] missing required image= key")
	local bg = cfg.background or ""
	local where = wesnoth.map.find(cfg)[1]
	if not where then return end
	
	wesnoth.interface.scroll_to_hex(where, false, false, true)
	if cfg.outline then
		wesnoth.interface.highlight_hex(where)
	end

	for i = 1, 3 do
		wesnoth.interface.add_item_halo(where.x, where.y, img)
		wesnoth.wml_actions.redraw{}
		wesnoth.interface.delay(300)
		wesnoth.interface.remove_item(where.x, where.y)
		wesnoth.interface.add_item_image(where.x, where.y, bg)
		wesnoth.wml_actions.redraw{}
		wesnoth.interface.delay(300)
	end

	if cfg.leave ~= false then
		wesnoth.interface.add_item_image(where.x, where.y, img)
	end
	wesnoth.wml_actions.redraw{}
end

-- Places a unit at a random location matching the filter
-- Automatically excludes locations that already have a unit
-- If all matching locations already have a unit, it does nothing
function wesnoth.wml_actions.random_unit(cfg)
	local filter = wml.get_child(cfg, "filter_location") or wml.error "Missing [filter_location] in [random_unit]"
	if cfg.require_vacant ~= false then
		filter = {
			wml.tag["and"](filter),
			wml.tag["not"]{ wml.tag.filter{} }
		}
	end
	local possible_locations = wesnoth.map.find(filter)
	if #possible_locations == 0 then
		std_print("Error: No matching locations!")
		return
	end
	cfg = wml.shallow_parsed(cfg)
	wml.remove_child(cfg, "filter_location")
	local which_loc = #possible_locations == 1 and 1 or mathx.random(1, #possible_locations)
	cfg.x = possible_locations[which_loc][1]
	cfg.y = possible_locations[which_loc][2]
	wesnoth.wml_actions.unit(cfg)
end

function wesnoth.wml_actions.popup_message(cfg)
	gui.show_popup(cfg.title or "", cfg.message, cfg.image)
end

function wesnoth.micro_ais.envoy(cfg)
	if (cfg.action ~= 'delete') and (not cfg.id) and (not wml.get_child(cfg, "filter")) then
		H.wml_error("Envoy [micro_ai] tag requires either id= key or [filter] tag")
	end
	local required_keys = { "waypoint"}
	local optional_keys = { "id", "enemy_death_chance", "[filter]", "[filter_second]", "invert_order", "messenger_death_chance" }
	local score = cfg.ca_score or 300000
	local CA_parms = {
		ai_id = 'mai_envoy',
		{ ca_id = 'attack', location = '~add-ons/Black_Cross_of_Aleron/lua/ca_envoy_attack.lua', score = score + 2 },
		{ ca_id = 'move', location = '~add-ons/Black_Cross_of_Aleron/lua/ca_envoy_move.lua', score = score + 10 },
		{ ca_id = 'escort_move', location = '~add-ons/Black_Cross_of_Aleron/lua/ca_envoy_escort_move.lua', score = score + 1 }
	}
    return required_keys, optional_keys, CA_parms
end
