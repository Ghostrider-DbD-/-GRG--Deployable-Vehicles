/*
	ExileClient_DeployableVehicles_network_packVehicleResponse
	By Ghostrider[GRG]
	Copyright 2017
*/

private["_response"];
_response = _this select 0;
_deployablePlayer = player;
["SuccessTitleAndText", ["Success", format["Your deployable vehicle has been packed."]]] call ExileClient_gui_toaster_addTemplateToast;
_returnMaterials = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "returnItemsWhenPacked");
if (_returnMaterials == 1) then
{
	_materialsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "materialsRequired");
	{
		_isWeapon = false;
		_isMagazine = false;
		_isItem = false;		
		if (isclass (configFile >> "CfgWeapons" >> _x)) then
		{
			_deployablePlayer addWeapon _x;
			_isWeapon = true;
		};
		if (isClass (configFile >> "CfgMagazines" >> _x)) then
		{
			_deployablePlayer addMagazine _x;
			_isMagazine = true;
		};
		if ((!_isWeapon) && !(_isMagazine)) then
		{
			_deployablePlayer assignItem _x;
			_deployablePlayer addItem _x;
			_isItem = true;

		};
	}forEach _materialsRequired;		
	["SuccessTitleAndText", ["Success", format["Materials needed to build another deployable vehicle were returned."]]] call ExileClient_gui_toaster_addTemplateToast;
};



