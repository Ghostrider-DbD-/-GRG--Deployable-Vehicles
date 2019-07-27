# -GRG--Deployable-Vehicles

License
--------------------------
All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

http://creativecommons.org/licenses/by-nc-sa/4.0/

Description: A new deployable vehicles script for Exile V 1.0
Activation: currently double clicking the radio activates it but any item could be used, and it could be tied to XM8.
Features: cleans up vehicles that are abandoned.
          Reminds players vehicles will be deleted if not packed or used.
	  Allows vehicles to be packed.
	  
Credits: originally inspired by and based on Enigma Deployable Vehicles

Installation:

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
