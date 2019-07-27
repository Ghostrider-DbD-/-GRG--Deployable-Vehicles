/*
	ExileClient_DeployVehicle_network_deployVehicleRequest
	By Ghostrider[GRG]
	Copyright 2017
*/
private["_playerNetID","_msg","_toolsRequired","_materialsRequired","_hasTools","_hasMaterials","_missingTool","_missingMaterial"];

_toolsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "toolsRequired");
_materialsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "materialsRequired");
_hasTools = true;
{
	if !( (_x in items player) || (_x in assignedItems player) || (_x in magazines player) || (_x in weapons player) ) then
	{
		_hasTools = false;
		if (isclass (configFile >> "CfgWeapons" >> _x)) then
		{
			_missingTool = gettext (configfile >> "CfgWeapons" >> _x >> "displayName");
		};
		if (isClass (configFile >> "CfgVehicles" >> _x)) then
		{
			_missingTool = gettext (configfile >> "CfgVehicles" >> _x >> "displayName");
		};
		if (isClass (configFile >> "CfgMagazines" >> _x)) then
		{
			_missingTool = gettext (configfile >> "CfgMagazines" >> _x >> "displayName");
		};
		["ErrorTitleAndText", ["Woops", format["You are missing a %1",_missingTool]]] call ExileClient_gui_toaster_addTemplateToast;
	};
}forEach _toolsRequired;

_hasMaterials = true;

_missingMaterial = "Unknown";
{
	if !( (_x in items player) || (_x in assignedItems player) || (_x in magazines player) || (_x in weapons player) )then
	{
		_missingMaterial = _x;
		_hasMaterials = false;
		if (isclass (configFile >> "CfgWeapons" >> _x)) then
		{
			_missingMaterial = gettext (configfile >> "CfgWeapons" >> _x >> "displayName");
		};
		if (isClass (configFile >> "CfgVehicles" >> _x)) then
		{
			_missingMaterial = gettext (configfile >> "CfgVehicles" >> _x >> "displayName");
		};
		if (isClass (configFile >> "CfgMagazines" >> _x)) then
		{
			_missingMaterial = gettext (configfile >> "CfgMagazines" >> _x >> "displayName");
		};	
		["ErrorTitleAndText", ["Woops", format["You are missing a %1",_missingMaterial]]] call ExileClient_gui_toaster_addTemplateToast;
	};
}forEach _materialsRequired;

if (_hasTools && _hasMaterials) then
{	
	_playerNetID = netID player;
	["deployVehicleRequest",[_playerNetID]] call ExileClient_system_network_send;
};