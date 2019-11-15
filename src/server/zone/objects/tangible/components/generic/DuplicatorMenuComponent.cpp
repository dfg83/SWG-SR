/*
 * DuplicatorMenuComponent
 *
 *  Created on: 14/03/2019
 *      Author: Tyclo
 */

#include "server/zone/objects/creature/CreatureObject.h"
#include "DuplicatorMenuComponent.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/managers/director/DirectorManager.h"
#include "server/zone/managers/loot/LootManager.h"
#include "server/zone/packets/player/PlayMusicMessage.h"
#include "server/zone/Zone.h"
#include "server/zone/ZoneServer.h"

void DuplicatorMenuComponent::fillObjectMenuResponse(SceneObject* sceneObject, ObjectMenuResponse* menuResponse, CreatureObject* player) const {
	if (sceneObject->isASubChildOf(player) && sceneObject->getContainerObjectsSize() > 0)
		menuResponse->addRadialMenuItem(20, 3, "Synthesize");

	TangibleObjectMenuComponent::fillObjectMenuResponse(sceneObject, menuResponse, player);
}

int DuplicatorMenuComponent::handleObjectMenuSelect(SceneObject* sceneObject, CreatureObject* player, byte selectedID) const {
	if (!sceneObject->isTangibleObject())
		return 0;

	if (!player->isPlayerCreature())
		return 0;

	if (selectedID == 20) {
		ManagedReference<SceneObject*> inventory = player->getSlottedObject("inventory");

		if (!sceneObject->isASubChildOf(inventory)) {
			player->sendSystemMessage("You can only use a Duplicator Prototype while it is in your inventory.");
			return 0;
		}

		if (inventory == NULL || inventory->isContainerFullRecursive()) {
			player->sendSystemMessage("Your inventory is full. You must have one free inventory slot to use the Duplicator Prototype.");
			return 0;
		}

		if (inventory == NULL || sceneObject->getContainerObjectsSize() < 3) {
			player->sendSystemMessage("Please add 3 data modules to the Duplicator Prototype to attempt a synthesization.");
			return 0;
		}

		if (sceneObject->getContainerObjectsSize() > 3) {
			player->sendSystemMessage("Duplicator Prototype can only function with 3 data modules.");
			return 0;
		}

		std::array<String, 3> containerItems;

		for (int i = 0; i < sceneObject->getContainerObjectsSize(); ++i) { // Get list of components in duplicator
			ManagedReference<SceneObject*> object = sceneObject->getContainerObject(i);
			if (object != NULL) {
				containerItems[i] = object->getObjectTemplate()->getFullTemplateString();
			} else {
				player->sendSystemMessage("The Duplicator Prototype encountered a problem with a data module. Please report this message.");
				return 0;
			}
		}

		std::sort(containerItems.begin(), containerItems.end()); // Sort alphabetically

		Lua* lua = new Lua();
		lua->init();

		if (!lua->runFile("scripts/managers/duplicator_manager.lua")) { // Get file containing combinations list
			delete lua;
			return 0;
		}

		LuaObject duplicatorComboList = lua->getGlobalObject("duplicatorCombinationsList"); // Get combinations list

		String rewardTemplate = "";
		bool match = false;

		if (duplicatorComboList.isValidTable() && duplicatorComboList.getTableSize() > 0) {
			for (int i = 1; i <= duplicatorComboList.getTableSize(); ++i) { // Loop through conbinations list
				LuaObject combination = duplicatorComboList.getObjectAt(i);

				if (combination.isValidTable()) {
					std::array<String, 3> duplicatorList;

					LuaObject combo = combination.getObjectField("combo");
					for (int x = 1; x <= combo.getTableSize(); ++x) {
						duplicatorList[x-1] = combo.getStringAt(x);
					}
					combo.pop();

					std::sort(duplicatorList.begin(), duplicatorList.end()); // Sort

					if (duplicatorList == containerItems) { // Check match
						match = true;
						rewardTemplate = combination.getStringField("reward");
						break;
					}
				} else {
					player->sendSystemMessage("The Duplicator Prototype attempts to synthesize the data modules but fails spectacularly. Please report this message.");
					delete lua;
					return 0;
				}
				combination.pop();
			}
			duplicatorComboList.pop();
		}

		if (match == true) { // Correct Combination
			if (rewardTemplate != "") {
				ManagedReference<TangibleObject*> reward = player->getZoneServer()->createObject(rewardTemplate.hashCode(), 1).castTo<TangibleObject*>();

				if (reward == NULL) {
					player->sendSystemMessage("The Duplicator Prototype failed to synthetize your reward " + rewardTemplate + " - Please report this message.");
					delete lua;
					return 0;
				}

				while (sceneObject->getContainerObjectsSize() > 0) { // Delete components
					ManagedReference<SceneObject*> object = sceneObject->getContainerObject(0);
					if (object != NULL) {
						Locker duplicatorContainerObjectLocker(object);
						object->destroyObjectFromWorld(true);
						if (object->isPersistent())
							object->destroyObjectFromDatabase(true);
					} else {
						player->sendSystemMessage("The Duplicator Prototype encountered a problem. Could not decontruct a data module. Please report this message.");
						delete lua;
						return 0;
					}
				}

				Locker duplicatorRewardLocker(reward);

				inventory->transferObject(reward, -1, true);

				reward->sendTo(player, true); // Give reward

				player->sendSystemMessage("The Duplicator Prototype reconstitutes the data modules provided into a new synthetic and places the item in your inventory.");
				PlayMusicMessage* pmmSuccess = new PlayMusicMessage("sound/ui_duplicator_synthesize_success.snd");
				player->sendMessage(pmmSuccess);
			} else {
				player->sendSystemMessage("The Duplicator Prototype failed to properly synthetize your reward. Please report this message.");
			}
		} else { // No match
			player->sendSystemMessage("The Duplicator Prototype could not reconstitute these particular data modules into a new synthetic.");
			PlayMusicMessage* pmmFail = new PlayMusicMessage("sound/ui_som_analysis_fail.snd");
			player->sendMessage(pmmFail);
		}

		delete lua;

		return 0;
	}

	return TangibleObjectMenuComponent::handleObjectMenuSelect(sceneObject, player, selectedID);
}
