krayt_dragon_grand = Creature:new {
	objectName = "@mob/creature_names:krayt_dragon_grand",
	socialGroup = "krayt",
	faction = "",
	level = 336,
	chanceHit = 30,
	damageMin = 2270,
	damageMax = 4250,
	baseXp = 28549,
	baseHAM = 410000,
	baseHAMmax = 501000,
	armor = 3,
	resists = {195,195,195,195,165,195,195,195,105},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_bristley",
	hideAmount = 950,
	boneType = "bone_mammal",
	boneAmount = 905,
	milk = 0,
	tamingChance = 0,
	ferocity = 30,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/krayt_dragon_hue.iff"},
	hues = { 16, 17, 18, 19, 20, 21, 22, 23 },
	scale = 1.1;
	lootGroups = {
		{
	    groups = {
				{group = "krayt_tissue_common", chance = 2000000},
				{group = "krayt_tissue_uncommon", chance = 2000000},
				{group = "krayt_tissue_rare", chance = 1500000},
				{group = "krayt_pearls", chance = 1500000},
				{group = "armor_attachments", chance = 1500000},
				{group = "clothing_attachments", chance = 1500000},
			},
			lootChance = 10000000,
		},
		{
	    groups = {
				{group = "krayt_tissue_common", chance = 750000},
				{group = "krayt_tissue_uncommon", chance = 1250000},
				{group = "krayt_tissue_rare", chance = 2500000},
				{group = "improved_skill_buffs", chance = 3000000},
				{group = "advanced_skill_buffs", chance = 2000000},
				{group = "experimental_skill_buffs", chance = 500000},
			},
			lootChance = 6500000,
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareacombo","stateAccuracyBonus=100"},
		{"creatureareaknockdown","stateAccuracyBonus=100"},
	}
}

CreatureTemplates:addCreatureTemplate(krayt_dragon_grand, "krayt_dragon_grand")
