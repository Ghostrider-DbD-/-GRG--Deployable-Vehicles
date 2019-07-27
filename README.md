# -GRG--Deployable-Vehicles
Description: A new deployable vehicles script for Exile V 1.0
Credits: originally inspired by and based on Enigma Deployable Vehicles
License
--------------------------
All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

http://creativecommons.org/licenses/by-nc-sa/4.0/

Add this to init.sqf:

[] execVM "Custom\deployableVehicles\init.sqf";

Modify config.cpp to add the code as shown below.

class CfgExileCustomCode 
{
	//[GRG] Deploybike
	ExileClient_gui_inventory_event_onSlotDoubleClick = "Custom\deployableVehicles\functions\ExileClient_gui_inventory_event_onSlotDoubleClick.sqf"; 
 };
 
class CfgNetworkMessages {
	#include "custom\deployableVehicles\configs\network.hpp"
};
#include "custom\deployableVehicles\configs\configs.hpp"
