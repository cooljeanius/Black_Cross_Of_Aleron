
local _ = wesnoth.textdomain "wesnoth-drusi"
local H = wesnoth.require "helper"

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
	return wesnoth.rand(1,100) <= chance
end

function wesnoth.wml_actions.enthrall_units(cfg)
	local units = wesnoth.get_units{
		wml.tag["not"]{status = 'dominated'},
		wml.tag["and"](cfg)
	}
	local dominator_cfg, dominator = wml.get_child(cfg, 'filter_dominator')
	if dominator_cfg then
		dominator = wesnoth.get_units(dominator_cfg)[1]
	end
	local chance = cfg.chance or 100
	for _,u in ipairs(units) do
		local success = enthrall_passes_chance(u, chance)
		if cfg.animate ~= false then
			local anim = wesnoth.create_animator()
			local attack
			if dominator then
				attack = H.find_attack(dominator, {range = 'ranged'})
			end
			anim:add(u, 'defend', success and 'hits' or 'miss', {
				text = (success and dominated_text or released_text)[u.gender],
				color = success and {255, 51, 0} or {51, 255, 0},
				secondary = attack,
				facing = dominator
			})
			if dominator then
				anim:add(dominator, 'attack', success and 'hits' or 'miss', {
					primary = attack,
					facing = u,
				})
				wesnoth.scroll_to_tile(dominator)
			else
				wesnoth.scroll_to_tile(u)
			end
			anim:run()
			wesnoth.delay(300, true)
		end
		if success then
			u.status.dominated = true
			u.variables.was_side = cfg.old_side or u.side
			u.side = cfg.new_side
		end
	end
end

function wesnoth.wml_actions.dethrall_units(cfg)
	local units = wesnoth.get_units{
		status = 'dominated',
		wml.tag["and"](cfg)
	}
	for _,u in ipairs(units) do
		if cfg.animate ~= false then
			wesnoth.scroll_to_tile(u)
			local anim = wesnoth.create_animator()
			anim:add(u, 'healed', 'hits', {
				text = released_text[u.gender],
				color = {0, 128, 50},
			})
			anim:run()
			wesnoth.delay(300, true)
		end
		u.status.dominated = false
		u.side = u.variables.was_side
	end
end
	
	
