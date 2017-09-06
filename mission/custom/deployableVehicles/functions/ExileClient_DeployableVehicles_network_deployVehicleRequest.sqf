/*
	ExileClient_DeployVehicle_network_deployVehicleRequest
	By Ghostrider[GRG]
	Copyright 2017
*/
private["_playerNetID","_msg","_toolsRequired","_materialsRequired","_hasTools","_hasMaterials","_missingTool","_missingMaterial"];
//private _msg = "-->> ExileClient_DeployVehicle_network_deployVehicleRequest called";
//systemChat _msg;
//diag_log _msg;

_toolsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "toolsRequired");
_materialsRequired = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "materialsRequired");
//diag_log format["-->> ExileClient_DeployVehicle_network_deployVehicleRequest:  _toolsRequired = %1",_toolsRequired];
//diag_log format["-->>ExileClient_DeployVehicle_network_deployVehicleRequest:  _materialsRequired = %1",_materialsRequired];
//diag_log format["-->>ExileClient_DeployVehicle_network_deployVehicleRequest:  players postion = %1",getPos player];
//diag_log format["-->>ExileClient_DeployVehicle_network_deployVehicleRequest:  player = %1",player];
_hasTools = true;
{
	//diag_log format["-->>>>ExileClient_DeployVehicle_network_deployVehicleRequest:  _toolsRequired _x = %1", _x];
	//diag_log format["-->>>>ExileClient_DeployVehicle_network_deployVehicleRequest:  _toolsRequired itemRadio in assignedItems player = %1", _x in assignedItems player];
	if !( (_x in items player) || (_x in assignedItems player) || (_x in magazines player) || (_x in weapons player) ) then
	{
		_hasTools = false;
		//  _deployedVehicleName = gettext (configfile >> "CfgVehicles" >> _vehType >> "displayName")
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
		//["Woops",[format["You are missing a %1",_missingTool]]] call ExileClient_gui_notification_event_addNotification;	
	};
}forEach _toolsRequired;

_hasMaterials = true;

_missingMaterial = "Unknown";
{
	//diag_log format["-->>>>ExileClient_DeployVehicle_network_deployVehicleRequest:  _materialsRequired _x = %1", _x];
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
		//["Woops",[format["You are missing a %1",_missingMaterial]]] call ExileClient_gui_notification_event_addNotification;
	};
}forEach _materialsRequired;

if (_hasTools && _hasMaterials) then
{	
	_playerNetID = netID player;
	//diag_log format["-->>>>>  ExileClient_DeployVehicle_network_deployVehicleRequest _playerNetID = %1",_playerNetID];
	//diag_log format["-->>>>>  ExileClient_DeployVehicle_network_deployVehicleRequest typeName _playerNetID = %1",typeName _playerNetID];	
	["deployVehicleRequest",[_playerNetID]] call ExileClient_system_network_send;
};