/*
	ExileClient_DeployableVehicles_network_packVehicleResponse
	By Ghostrider[GRG]
	Copyright 2017
*/

private["_response"];
_response = _this select 0;
//diag_log format["--->>>  ExileClient_DeployableVehicles_network_packVehicleResponse:  _response = %1",_response];
_deployablePlayer = player;
["SuccessTitleAndText", ["Success", format["Your deployable vehicle has been packed."]]] call ExileClient_gui_toaster_addTemplateToast;
_returnMaterials = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "returnItemsWhenPacked");
//diag_log format["--->>>  ExileClient_DeployableVehicles_network_packVehicleResponse:  _returnMaterials = %1",_returnMaterials];
if (_returnMaterials == 1) then
{
	_materialsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "materialsRequired");
	{
		//_msg = format["--->>>  ExileClient_DeployableVehicles_network_packVehicleResponse:  evaluating component %1",_x];
		//diag_log _msg;
		//systemchat _msg;
		_isWeapon = false;
		_isMagazine = false;
		_isItem = false;		
		if (isclass (configFile >> "CfgWeapons" >> _x)) then
		{
			_deployablePlayer addWeapon _x;
			_isWeapon = true;
			//_msg = log format["--->>>  ExileClient_DeployableVehicles_network_packVehicleResponse:  adding weapon %1",_x];
			//diag_log _msg;
			//systemchat _msg;
		};
		if (isClass (configFile >> "CfgMagazines" >> _x)) then
		{
			_deployablePlayer addMagazine _x;
			_isMagazine = true;
			//_msg = format["--->>>  ExileClient_DeployableVehicles_network_packVehicleResponse:  adding magazine %1",_x];
			//diag_log _msg;
			//systemchat _msg;			
		};
		if ((!_isWeapon) && !(_isMagazine)) then
		{
			_deployablePlayer assignItem _x;
			_deployablePlayer addItem _x;
			_isItem = true;
			//_msg = format["--->>>  ExileClient_DeployableVehicles_network_packVehicleResponse:  adding item %1",_x];
			//diag_log _msg;
			//systemchat _msg;			
		};
	}forEach _materialsRequired;		
	["SuccessTitleAndText", ["Success", format["Materials needed to build another deployable vehicle were returned."]]] call ExileClient_gui_toaster_addTemplateToast;
};



