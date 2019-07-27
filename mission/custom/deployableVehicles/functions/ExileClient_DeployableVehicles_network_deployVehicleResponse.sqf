/*
	ExileClient_DeployableVehicles_network_deployVehicleResponse
	By Ghostrider[GRG]
	Copyright 2017
*/

private["_response"];
_response = _this select 0;
_deployablePlayer = player;
switch(_response) do
{
	case "Success": {

		_vehNetID = _this select 1;
		_veh = objectFromNetId _vehNetID;
		_veh addEventHandler ["getout",{_this call ExileClient_DeployableVehicles_EH_getOut}];
		_veh addAction["<t color = '#32CD32'>Pack Vehicle</t>",{call ExileClient_DeployableVehicles_network_packVehicleRequest},[],-1];
		_vehName = gettext (configfile >> "CfgVehicles" >> _vehType >> "displayName");
		["SuccessTitleAndText", ["Success", format["Your deployable %1 has been is readied for you.",_vehName]]] call ExileClient_gui_toaster_addTemplateToast;		
		_materialsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "materialsRequired");
	
		{
				_isWeapon = false;
				_isMagazine = false;
				_isItem = false;		
				if (isclass (configFile >> "CfgWeapons" >> _x)) then
				{
					_deployablePlayer removeWeapon _x;
					_isWeapon = true;
				};
				if (isClass (configFile >> "CfgMagazines" >> _x)) then
				{
					_deployablePlayer removeMagazine _x;
					_isMagazine = true;
				};
				if ((!_isWeapon) && !(_isMagazine)) then
				{
					_deployablePlayer unassignItem _x;
					_deployablePlayer removeItem _x;
					_isItem = true;
			
				};
		}forEach _materialsRequired;
	};
	case "Duplicate": {
			["ErrorTitleAndText", ["Woops", format["You have already spawned the maximum allowed number of vehicles. Please pack it before attempting to spawn another or wait for it to be deleted."]]] call ExileClient_gui_toaster_addTemplateToast;
	};
	case "Error": {
			["ErrorTitleAndText", ["Woops", format["Null Vehicle Spawned, please notify a server administrator"]]] call ExileClient_gui_toaster_addTemplateToast;
	};
};