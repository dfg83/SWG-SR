--Automatically generated by SWGEmu Spawn Tool v0.12 loot editor.

pistol_dh17 = {
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "",
	directObjectTemplate = "object/weapon/ranged/pistol/pistol_dh17.iff",
	craftingValues = {
		{"mindamage",23,54,0},
		{"maxdamage",55,89,0},
		{"attackspeed",4.8,3.3,0},
		{"woundchance",6.2,12.4,0},
		{"hitpoints",750,750,0},
		{"attackhealthcost",31,17,0},
		{"attackactioncost",53,25,0},
		{"attackmindcost",21,12,0},
		{"roundsused",10,40,0},
		{"zerorangemod",-5,-5,0},
		{"maxrangemod",-60,-60,0},
		{"midrange",15,15,0},
		{"midrangemod",7,13,0},
	},
	customizationStringNames = {},
	customizationValues = {},

	-- randomDotChance: The chance of this weapon object dropping with a random dot on it. Higher number means less chance. Set to 0 to always have a random dot.
	randomDotChance = 625,
	junkDealerTypeNeeded = JUNKARMS,
	junkMinValue = 25,
	junkMaxValue = 45

}

addLootItemTemplate("pistol_dh17", pistol_dh17)
