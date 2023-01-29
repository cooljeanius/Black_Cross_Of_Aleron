
local _ = wesnoth.textdomain "wesnoth-celmin-bcoa"

local released_text = {
	male = _"released!",
	female = _"female^released!"
}
local dominated_text = {
	male = _"dominated!",
	female = _"female^dominated!"
}
local resisted_text = {
	male = _"domination^resisted!",
	female = _"female_domination^resisted!"
}

local function enthrall_passes_chance(unit, chance)
	if type(chance) == 'string' then
		chance = 100 - unit:defense(wesnoth.get_terrain(unit.x, unit.y))
	end
	if chance >= 100 then return true end
	if chance <= 0 then return false end
	return mathx.random(1,100) <= chance
end

local function do_enthrall(units, dominator, chance, old_side, new_side, animate)
	for _,u in ipairs(units) do
		local success = enthrall_passes_chance(u, chance)
		if success then
			u.status.dominated = true
			u.variables.was_side = old_side or u.side
			u.side = new_side
		end
		if animate ~= false then
			local anim = wesnoth.units.create_animator()
			local attack
			if dominator then
				attack = dominator:find_attack{range = 'ranged'}
			end
			anim:add(u, 'defend', success and 'hits' or 'miss', {
				text = (success and dominated_text or resisted_text)[u.gender],
				color = success and {255, 51, 0} or {51, 255, 0},
				secondary = attack,
				facing = dominator
			})
			if dominator then
				anim:add(dominator, 'attack', success and 'hits' or 'miss', {
					primary = attack,
					facing = u,
				})
				wesnoth.interface.scroll_to_hex(dominator)
			else
				wesnoth.interface.scroll_to_hex(u)
			end
			anim:run()
			wesnoth.interface.delay(300, true)
		end
	end
end

function wesnoth.wml_actions.enthrall_units(cfg)
	local chance = cfg.chance or 100
	local old_side, new_side = cfg.old_side, cfg.new_side
	local dominator_cfg = wml.get_child(cfg, 'filter_dominator')
	local filter = {
		wml.tag["not"]{status = 'dominated'},
		wml.tag["and"](cfg)
	}
	if dominator_cfg then
		for _,dominator in ipairs(wesnoth.units.find_on_map(dominator_cfg)) do
			std_print('Found dominator ' .. dominator.id)
			local units = wesnoth.units.find_on_map(filter, dominator)
			std_print('Possible units to dominate: '.. #units)
			do_enthrall(units, dominator, chance, old_side, new_side or dominator.side, cfg.animate)
		end
	else
		local units = wesnoth.units.find_on_map(filter)
		do_enthrall(units, nil, chance, old_side, new_side or 1, cfg.animate)
	end
end

function wesnoth.wml_actions.dethrall_units(cfg)
	local units = wesnoth.units.find_on_map{
		status = 'dominated',
		wml.tag["and"](cfg)
	}
	for _,u in ipairs(units) do
		u.status.dominated = false
		u.side = u.variables.was_side
		if cfg.animate ~= false then
			wesnoth.interface.scroll_to_hex(u)
			local anim = wesnoth.units.create_animator()
			anim:add(u, 'healed', 'hits', {
				text = released_text[u.gender],
				color = {0, 128, 50},
			})
			anim:run()
			wesnoth.interface.delay(300, true)
		end
	end
end
	
	
