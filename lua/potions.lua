
local _ = wesnoth.textdomain "wesnoth-celmin-bcoa"

local haste_total = wml.variables.haste_potion
local healing_total = wml.variables.healing_potion
local haste_new = haste_total - (wml.variables.haste_potion_old or haste_total)
local healing_new = healing_total - (wml.variables.healing_potion_old or healing_total)

local haste_detail = wesnoth.format( _("another haste potion","$potions more haste potions",haste_new), {potions = haste_new})
local healing_detail = wesnoth.format( _("another healing potion","$potions more healing potions",healing_new), {potions = healing_new})

local haste_total = wesnoth.format( _("just one haste potion", "$potions haste potions", haste_total), {potions = haste_total})
local healing_total = wesnoth.format( _("just one healing potion", "$potions healing potions", healing_total), {potions = healing_total})

local open_green = "<span color='darkgreen' font_weight='bold'>"
local open_orange = "<span color='orange' font_weight='bold'>"
local close = "</span>"

haste_detail = open_orange .. haste_detail .. close
haste_total = open_orange .. haste_total .. close
healing_detail = open_green .. healing_detail .. close
healing_total = open_green .. healing_total .. close

local new_list = {}
if haste_new > 0 then table.insert(new_list, haste_detail) end
if healing_new > 0 then table.insert(new_list, healing_detail) end

wml.variables.potion_details = wesnoth.format_conjunct_list(_'no more potions', new_list)
wml.variables.potion_totals = wesnoth.format_conjunct_list('', {haste_total, healing_total})
