/*
	ExileServer_DeployVehicle_network_deployVehicleRequest
	By Ghostrider[GRG]
	Copyright 2017
*/
waitUntil {deployableVehiclesOperationInProgress_server == 0};
deployableVehiclesOperationInProgress_server = 1;
params["_sessionID","_payload"];
_payload params ["_playerNedID"];
private["_player","_maxDeployables","_canDeploy","_msg","_allowedDeployables","_vehType","_dirPlayer","_spawnPos","_deployedVehicle"];	
_player = objectFromNetId _playerNedID;
_playerVehicles = _player getVariable["deployableVehicles",[]];
_maxDeployables = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "deployablesAllowed");
_canDeploy = count (_playerVehicles) < _maxDeployables;
if !(_canDeploy) exitWith 
{
	_msg = ["Duplicate",""];
	[_sessionID, "deployVehicleResponse", _msg] call ExileServer_system_network_send_to;
};
_allowedDeployables = getArray (missionConfigFile >> "deployableVehicles" >> "configs" >> "deployables");
_vehType = selectRandom _allowedDeployables;
_dirPlayer = direction _player;
_spawnPos = (getPos _player) getPos [1,_dirPlayer]; // 1.5 meters away in the direction the player is facing.
_deployedVehicle = _vehType createVehicle _spawnPos;

if (_deployedVehicle isEqualTo objNull) exitWith
{
	_msg = ["Error",""];
	[_sessionID, "deployVehicleResponse", _msg] call ExileServer_system_network_send_to;	
};
_deployedVehicleNetID = netID _deployedVehicle;
_playerVehicles pushBack _deployedVehicleNetID;
_player setVariable["deployableVehicles",_playerVehicles];
_deployedVehicle setVariable["playerOwner",_playerNedID];
_deployedVehicle setVariable["playerUID",getPlayerUID _player];
deployableVehiclesList pushBack _deployedVehicleNetID;

_msg = ["Success", _deployedVehicleNetID];
[_sessionID, "deployVehicleResponse", _msg] call ExileServer_system_network_send_to;
deployableVehiclesOperationInProgress_server = 0;
true