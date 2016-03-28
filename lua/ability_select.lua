
local H = wesnoth.require "lua/helper.lua"

local x, y = wesnoth.current.event_context.x1, wesnoth.current.event_context.y1
local initiate = wesnoth.get_unit(x, y)
local chance = H.rand "1..100"
local use_trait

local function debug(msg)
	if wesnoth.game_config.debug then
		wesnoth.message('Initiates', tostring(msg))
	end
end

local function has_trait(u, need_trait)
	local mods = H.get_child(u.__cfg, "modifications")
	for trait in H.child_range(mods, "trait") do
		if trait.id == need_trait then return true end
	end
	return false
end

debug("She is at " .. x .. ',' .. y .. "; the chance was " .. chance)

if chance <= 30 then
	if has_trait(initiate, "intelligent") then
		use_trait = "intelligent"
	elseif has_trait(initiate, "quick") then
		use_trait = "quick"
	elseif has_trait(initiate, "resilient") then
		use_trait = "resilient"
	elseif has_trait(initiate, "dextrous") then
		use_trait = "dextrous"
	elseif has_trait(initiate, "strong") then
		use_trait = "strong"
	end
elseif chance <= 60 then
	if has_trait(initiate, "strong") then
		use_trait = "strong"
	elseif has_trait(initiate, "dextrous") then
		use_trait = "dextrous"
	elseif has_trait(initiate, "resilient") then
		use_trait = "resilient"
	elseif has_trait(initiate, "quick") then
		use_trait = "quick"
	elseif has_trait(initiate, "intelligent") then
		use_trait = "intelligent"
	end
elseif chance <= 90 then
	use_trait = "none"
end

if not use_trait then return end

chance = H.rand "1..100"

debug("Found trait " .. use_trait .. '; secondary chance is ' .. chance)

local chosen_ability = "none"

if use_trait == "none" then
	if chance <= 10 then
		chosen_ability = "hardy"
	elseif chance <= 20 then
		chosen_ability = "speedy"
	elseif chance <= 30 then
		chosen_ability = "thorny"
	elseif chance <= 40 then
		chosen_ability = "slimy"
	end
elseif use_trait == "intelligent" then
	if chance <= 25 then
		chosen_ability = "fire"
	elseif chance <= 50 then
		chosen_ability = "ice"
	elseif chance <= 75 then
		chosen_ability = "arcane"
	else
		chosen_ability = "glow"
	end
elseif use_trait == "quick" then
	if chance <= 45 then
		chosen_ability = "skirmisher"
	elseif chance <= 50 then
		chosen_ability = "treewalk"
	end
elseif use_trait == "resilient" then
	if chance <= 45 then
		chosen_ability = "nature"
	elseif chance <= 75 then
		chosen_ability = "cure"
	end
elseif use_trait == "dextrous" then
	if chance <= 25 then
		chosen_ability = "agile"
	elseif chance <= 40 then
		chosen_ability = "frenzy"
	end
elseif use_trait == "strong" then
	if chance <= 45 then
		chosen_ability = "firststrike"
	elseif chance <= 75 then
		chosen_ability = "dagger"
	end
end

debug("Final selection: " .. chosen_ability)

wesnoth.set_variable("chosen_ability", chosen_ability)
