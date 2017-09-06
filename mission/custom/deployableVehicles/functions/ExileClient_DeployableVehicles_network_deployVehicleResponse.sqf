/*
	ExileClient_DeployableVehicles_network_deployVehicleResponse
	By Ghostrider[GRG]
	Copyright 2017
*/

private["_response"];
_response = _this select 0;
//_msg = format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _response= %1", _response];
//systemChat _msg;
//diag_log _msg;

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

		//diag_log format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _vehNetID= %1", _vehNetID];
		//diag_log format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _veh= %1", _veh];
		//diag_log format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _vehName= %1", _vehName];
		//diag_log format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _materialsRequired= %1", _response];
		//diag_log format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _response= %1", _materialsRequired];
		//diag_log format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: _response= %1", _response];		
		{
				_isWeapon = false;
				_isMagazine = false;
				_isItem = false;		
				if (isclass (configFile >> "CfgWeapons" >> _x)) then
				{
					_deployablePlayer removeWeapon _x;
					_isWeapon = true;
					//_msg = format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: weapon %1 removed", _x];
					//diag_log _msg;
					//systemChat _msg;
				};
				if (isClass (configFile >> "CfgMagazines" >> _x)) then
				{
					_deployablePlayer removeMagazine _x;
					_isMagazine = true;
					//_msg = format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: magazine %1 removed", _x];
					//diag_log _msg;
					//systemChat _msg;
				};
				if ((!_isWeapon) && !(_isMagazine)) then
				{
					_deployablePlayer unassignItem _x;
					_deployablePlayer removeItem _x;
					_isItem = true;
					//_msg = format["--<><> ExileClient_DeployableVehicles_network_deployVehicleResponse: item %1 removed", _x];
					//diag_log _msg;
					//systemChat _msg;					
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