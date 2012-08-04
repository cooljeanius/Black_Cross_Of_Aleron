
helper = wesnoth.require "lua/helper.lua"

function assign_good_cave_scout()
	-- Find the best cave scout in the recall list and place it on the map
	local recallable = wesnoth.get_recall_units{side=1}
	local best_unit
	local move_costs
	local cave_moves, best_cave_moves = 0, 0
	for i,unit in ipairs(recallable) do
		move_costs = helper.get_child(unit.__cfg, 'movement_costs')
		cave_moves = unit.max_moves / move_costs.cave
		--wesnoth.message("Unit of type " .. unit.type .. " has " .. cave_moves .. " moves on cave.")
		if (cave_moves > 4) and (cave_moves > best_cave_moves) then
			best_cave_moves = cave_moves
			best_unit = unit
		elseif cave_moves == best_cave_moves and best_unit.upkeep ~= "loyal" and unit.upkeep == "loyal" then
			best_unit = unit
		end
	end
	if best_unit == nil then
		best_unit = wesnoth.get_unit "chiefguard"
	end
	best_unit.role = 'cave_scouter'
end


