/*
	ExileClient_DeployableVehicles_EH_getOut
	By Ghostrider[GRG]
	Copywrite 2017
	
	vehicle: Object - Vehicle the event handler is assigned to
    position: String - Can be either "driver", "gunner" or "cargo"
    unit: Object - Unit that left the vehicle
    turret: Array - turret path (since Arma 3 v1.36)
*/
if !(alive player) exitWith{};
if (deployableVehiclePacked == 1) exitWith {deployableVehiclePacked = 0};
params["_vehicle","_position","_unit"];
diag_log format["ExileClient_DeployableVehicles_EH_getOut :  _this = %1",_this];
_isOnRoad = isOnRoad _vehicle;

if (_isOnRoad) exitWith
{
	_maxTimeOnRoad = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "maxTimeAbandonedOnRoads");
	["ErrorTitleAndText", ["WARNING !", format["Please move your bike out of the road."]]] call ExileClient_gui_toaster_addTemplateToast;
	["ErrorTitleAndText", ["WARNING !", format["Bikes left in the road are deleted after %1 seconds.",_maxTimeOnRoad]]] call ExileClient_gui_toaster_addTemplateToast;
	playSound "Alarm";
};
_maxTimeAbandoned = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "maxTimeAbandoned");
["SuccessTitleAndText", ["Please Note", format["Remember to pack your vehicle."]]] call ExileClient_gui_toaster_addTemplateToast;
["SuccessTitleAndText", ["Please Note", format["Unattended deployable vehicles are deleted after %1 minutes.",(_maxTimeAbandoned/60)]]] call ExileClient_gui_toaster_addTemplateToast;



