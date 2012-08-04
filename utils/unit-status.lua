
local _ = wesnoth.textdomain "mydomain"
local old_unit_status = wesnoth.theme_items.unit_status
function wesnoth.theme_items.unit_status()
	local u = wesnoth.get_displayed_unit()
	if not u then return {} end
	local s = old_unit_status()
	if u.status.dominated then
		table.insert(s, { "element", {
			image = "status/dominated.png",
			tooltip = _"dominated: This unit is dominated. It will be under the control of the dominator's side until it either levels up or ends a turn not adjacent to the dominator."
		} })
	end
	if u.status.hasted then
		table.insert(s, { "element", {
			image = "status/hasted.png",
			tooltip = _"hasted: Hasted units get 8 more movement points than usual. It lasts until the end of the current scenario."
		} })
	end
	return s
end