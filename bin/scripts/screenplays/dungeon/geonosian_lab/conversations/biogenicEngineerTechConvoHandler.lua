local ObjectManager = require("managers.object.object_manager")

BiogenicEngineerTechConvoHandler = conv_handler:new {}

function BiogenicEngineerTechConvoHandler:runScreenHandlers(pConvTemplate, pPlayer, pNpc, selectedOption, pConvScreen)
	local screen = LuaConversationScreen(pConvScreen)

	local pConvScreen = screen:cloneScreen()
	local clonedConversation = LuaConversationScreen(pConvScreen)

	local screenID = screen:getScreenID()

	if screenID == "init_talk" then
		if (GeonosianLab:hasGeoItem(pPlayer, "object/tangible/loot/dungeon/geonosian_mad_bunker/engineering_datapad.iff")) then
			clonedConversation:addOption("@conversation/biogenic_engineertech:s_a7b6a9c7", "oh_yes_codes")
		end
		clonedConversation:addOption("@conversation/biogenic_engineertech:s_56fde3ca", "could_use_help")
		clonedConversation:addOption("@conversation/biogenic_engineertech:s_428087e9", "knocked_out_power")
		clonedConversation:addOption("@conversation/biogenic_engineertech:s_99c2fa91", "wandered_bad_spot")
		clonedConversation:addOption("@conversation/biogenic_engineertech:s_9d6ccb86", "thanks_for_stopping")
	elseif screenID == "come_back_with_codes" or screenID == "come_back_when_find" then
		writeData(CreatureObject(pPlayer):getObjectID() .. ":geo_engineertech_talked", 1)
	elseif screenID == "return_init" then
		if (GeonosianLab:hasGeoItem(pPlayer, "object/tangible/loot/dungeon/geonosian_mad_bunker/engineering_datapad.iff")) then
			clonedConversation:addOption("@conversation/biogenic_engineertech:s_da5959ed", "yes_here_are_codes")
		end
		clonedConversation:addOption("@conversation/biogenic_engineertech:s_27707b65", "come_back_when_find")
	elseif (screenID == "yes_here_are_codes" or screenID == "oh_yes_codes") and GeonosianLab:hasGeoItem(pPlayer, "object/tangible/loot/dungeon/geonosian_mad_bunker/engineering_datapad.iff") then
		GeonosianLab:removeGeoItem(pPlayer, "object/tangible/loot/dungeon/geonosian_mad_bunker/engineering_datapad.iff")
		GeonosianLab:giveGeoItem(pPlayer, "object/tangible/loot/dungeon/geonosian_mad_bunker/engineering_key.iff")
		CreatureObject(pPlayer):setScreenPlayState(1, "geonosian_lab_datapad_delivered");
	end
	return pConvScreen
end

function BiogenicEngineerTechConvoHandler:getInitialScreen(pPlayer, pNpc, pConvTemplate)
	local convoTemplate = LuaConversationTemplate(pConvTemplate)
	local hasTalked = readData(CreatureObject(pPlayer):getObjectID() .. ":geo_engineertech_talked")
	if (CreatureObject(pPlayer):hasScreenPlayState(1, "geonosian_lab_datapad_delivered")) then
		return convoTemplate:getScreen("things_under_control")
	elseif (hasTalked ~= nil and hasTalked == 1) then
		return convoTemplate:getScreen("return_init")
	end
	return convoTemplate:getScreen("init_talk")
end
