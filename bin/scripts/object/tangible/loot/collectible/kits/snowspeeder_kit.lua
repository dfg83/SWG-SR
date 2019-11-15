object_tangible_loot_collectible_kits_snowspeeder_kit = object_tangible_loot_collectible_kits_shared_snowspeeder_kit:new {

	templateType = LOOTKIT,

	gameObjectType = 8233,
	
	--These are used to determine which components are necessary in the loot kit to finish the item
	collectibleComponents = {
		"object/tangible/component/vehicle/snowspeeder_chassis.iff", 
		"object/tangible/component/vehicle/armor_panel_cold.iff", 
		"object/tangible/component/vehicle/weapon_link.iff", 
		"object/tangible/component/vehicle/vehicle_module.iff", 
		"object/tangible/component/vehicle/veh_power_plant_mk2.iff", 
		"object/tangible/component/vehicle/veh_shield_generator_mk2.iff", 
		"object/tangible/component/vehicle/fuel_c.iff", 
		"object/tangible/component/vehicle/fuel_cell_c.iff" 
	},
	
	collectibleReward = {"object/tangible/loot/loot_schematic/snowspeeder_loot_schem.iff"},

	deleteComponents = 1,

	--These are used to display to the player which components he already added. Same order as above is used
	attributes = {
		"snowspeeder_kit_chassis", -- chassis -- NEW OBJECT -- object/tangible/component/vehicle/shared_snowspeeder_chassis.iff
		"snowspeeder_kit_armour", -- armour plating -- object/tangible/component/vehicle/shared_armor_panel_cold.iff
		"snowspeeder_kit_weaponry", -- weaponry -- object/tangible/component/vehicle/shared_weapon_link.iff
		"snowspeeder_kit_module", -- control module  -- object/tangible/component/vehicle/shared_vehicle_module.iff 
		"snowspeeder_kit_power_plant", -- power plant mk2 -- object/tangible/component/vehicle/shared_veh_power_plant_mk2.iff
		"snowspeeder_kit_shields", -- shield generator mk2 -- object/tangible/component/vehicle/shared_veh_shield_generator_mk2.iff
		"snowspeeder_kit_fuel_cell", -- fuel cell -- object/tangible/component/vehicle/shared_fuel_cell_c.iff
		"snowspeeder_kit_fuel" -- fuel -- object/tangible/component/vehicle/shared_fuel_c.iff
	}
}

ObjectTemplates:addTemplate(object_tangible_loot_collectible_kits_snowspeeder_kit, "object/tangible/loot/collectible/kits/snowspeeder_kit.iff")
