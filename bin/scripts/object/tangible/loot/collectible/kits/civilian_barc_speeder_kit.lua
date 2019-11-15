object_tangible_loot_collectible_kits_civilian_barc_speeder_kit = object_tangible_loot_collectible_kits_shared_civilian_barc_speeder_kit:new {

	templateType = LOOTKIT,

	gameObjectType = 8233,
	
	--These are used to determine which components are necessary in the loot kit to finish the item
	collectibleComponents = {
		"object/tangible/component/vehicle/barc_customisation_kit.iff", 
		"object/tangible/component/vehicle/barc_repair_tool.iff", 
		"object/tangible/component/vehicle/barc_chassis.iff", 
		"object/tangible/component/vehicle/fuel_cell_a.iff", 
		"object/tangible/component/vehicle/fuel_a.iff", 
		"object/tangible/component/vehicle/barc_armour_plating.iff"
	},
	
	collectibleReward = {"object/tangible/loot/loot_schematic/vehicles/barc_speeder_neutral_schematic.iff"},

	deleteComponents = 1,

	--These are used to display to the player which components he already added. Same order as above is used
	attributes = {
		"barc_customisation_kit",
		"barc_repair_tool",
		"barc_chassis",
		"barc_fuel_cell",
		"barc_fuel",
		"barc_armour_plating"
	}
}

ObjectTemplates:addTemplate(object_tangible_loot_collectible_kits_civilian_barc_speeder_kit, "object/tangible/loot/collectible/kits/civilian_barc_speeder_kit.iff")
