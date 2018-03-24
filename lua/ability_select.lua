
local H = wesnoth.require "lua/helper.lua"

local x, y = wesnoth.current.event_context.x1, wesnoth.current.event_context.y1
local initiate = wesnoth.get_unit(x, y)

local function debug(msg)
	if wesnoth.game_config.debug then
		wesnoth.message('Initiates', tostring(msg))
	end
end

local initiate_traits = {}
do
	local mods = wml.get_child(initiate.__cfg, "modifications")
	for trait in wml.child_range(mods, "trait") do
		initiate_traits[trait.id] = true
	end
end

local possible_abils = {}

if initiate_traits.intelligent then -- Chance: 0.4
	-- Abilities enabled by intelligence
	possible_abils.fire = 25
	possible_abils.ice = 25
	possible_abils.arcane = 25
	possible_abils.glow = 25
	-- Abilities disabled by intelligence
	possible_abils.thorny = 0
	possible_abils.slimy = 0
end

if initiate_traits.quick then -- Chance: 0.4
	-- Abilities enabled by quickness
	if initiate_traits.dextrous then -- Chance: 0.25
		possible_abils.treewalk = 50
		possible_abils.skirmisher = 12.5
	end
	if initiate_traits.intelligent then -- Chance: 0.25
		possible_abils.skirmisher = 12.5
	end
	-- Abilities disabled by quickness
	possible_abils.speedy = 0
end

if initiate_traits.resilient then -- Chance: 0.4
	-- Abilities enabled by resilience
	possible_abils.cure = 62.5
	possible_abils.nature = 75
	-- Abilities disabled by resilience
	possible_abils.hardy = 0
end

if initiate_traits.dextrous then -- Chance: 0.4
	-- Abilities enabled by dexterity
	possible_abils.agile = 50
	if initiate_traits.resilient or initiate_traits.strong then -- Chance: 0.5
		possible_abils.frenzy = 25
		possible_abils.skirmisher = 12.5
	end
end

if initiate_traits.strong then -- Chance: 0.4
	-- Abilities enabled by strength
	possible_abils.dagger = 62.5
	possible_abils.firststrike = 75
end

-- Abilities not enabled by any specific trait
if not possible_abils.hardy then
	possible_abils.hardy = 25
end
if not possible_abils.speedy then
	possible_abils.speedy = 25
end
if not possible_abils.thorny then
	possible_abils.thorny = 33.3
end
if not possible_abils.slimy then
	possible_abils.slimy = 33.3
end

chance = H.rand "1..325"

debug("She is at " .. x .. ',' .. y .. "; the chance was " .. chance .. "/325")

local chosen_ability = "none"
local current_score = 0

for abil, weight in pairs(possible_abils) do
	if weight > 0 then
		current_score = current_score + weight
		if chance <= current_score then
			chosen_ability = abil
			break
		end
	end
end

debug("Final selection: " .. chosen_ability)

wesnoth.set_variable("chosen_ability", chosen_ability)

--[[ The distribution table:

Context chances:
- Has two specific traits:
0.2*0.25 + 0.2*0.25 = 0.1
- Has one specific trait, other trait is anything:
0.2*1 + 0.8*0.25 = 0.4
- Has any traits except one specific trait:
0.8*0.75 = 0.6

The desired final chances, out of 325:
 5. treewalk, frenzy, skirmisher
10. fire, ice, arcane, glow
15. hardy, speedy
20. thorny, slimy, agile
25. cure, dagger
30. nature, firststrike
70. none
This chance forms the RHS of the chance equations.
The weight column is the value to be assigned in the chance table.

Ability		Context				Chance Equation			Weight
------------------------------------------------------------------------------
frenzy		dextrous, resilient	0.1 * w/325 = x			w = 25
			dextrous, strong	0.1 * w/325 = x			.
			TOTAL				2 * x = 1/65			x = 1/130
------------------------------------------------------------------------------
skirmisher	quick, intelligent	0.1 * w/325 = y			w = 12.5
			quick, dextrous		0.1 * w/325 = y			.
			dextrous, resilient	0.1 * w/325 = y			.
			dextrous, strong	0.1 * w/325 = y			.
			TOTAL				4 * y = 1/65			y = 1/260
------------------------------------------------------------------------------
treewalk	quick, dextrous		0.1 * w/325 = 1/65		w = 50
------------------------------------------------------------------------------
fire		intelligent			0.4 * w/325 = 2/65		w = 25
ice			intelligent			0.4 * w/325 = 2/65		.
arcane		intelligent			0.4 * w/325 = 2/65		.
glow		intelligent			0.4 * w/325 = 2/65		.
------------------------------------------------------------------------------
hardy		!resilient			0.6 * w/325 = 3/65		w = 25
speedy		!quick				0.6 * w/325 = 3/65		.
------------------------------------------------------------------------------
thorny		!intelligent		0.6 * w/325 = 4/65		w = 33.333333333333333
slimy		!intelligent		0.6 * w/325 = 4/65		.
------------------------------------------------------------------------------
agile		dextrous			0.4 * w/325 = 4/65		w = 50
------------------------------------------------------------------------------
cure		resilient			0.4 * w/325 = 1/13		w = 62.5
dagger		strong				0.4 * w/325 = 1/13		.
------------------------------------------------------------------------------
nature		resilient			0.4 * w/325 = 6/65		w = 75
firststrike	strong				0.4 * w/325 = 6/65		.

Required traits for each ability:
Ability     | INT | QUK | RES | DEX | STR |
------------+-----+-----+-----+-----+-----+
treewalk    |     |  X  |     |  X  |     |
frenzy      |     |     |  ?  |  X  |  ?  |
skirmisher  |  ?  |  X  |     |  ?  |     |
    OR      |     |     |  ?  |  X  |  ?  |
fire        |  X  |     |     |     |     |
ice         |  X  |     |     |     |     |
arcane      |  X  |     |     |     |     |
glow        |  X  |     |     |     |     |
hardy       |     |     |  !  |     |     |
speedy      |     |  !  |     |     |     |
thorny      |  !  |     |     |     |     |
slimy       |  !  |     |     |     |     |
agile       |     |     |     |  X  |     |
cure        |     |     |  X  |     |     |
dagger      |     |     |     |     |  X  |
nature      |     |     |  X  |     |     |
firststrike |     |     |     |     |  X  |

X - This trait is required for the ability
? - One of these traits is required for the ability
! - This trait is mutually exclusive with the ability

]]
