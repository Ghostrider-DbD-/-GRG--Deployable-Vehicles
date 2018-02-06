/*
	ExileServer_DeployableVehicles_network_packVehicleRequest
	By Ghostrider[GRG]
	Copyright 2017
*/

params["_sessionID","_data"];
//diag_log format["--<> ExileServer_DeployableVehicles_network_packVehicleRequest:  _data = %1",_data];
_data params ["_vehicleNetID"];	
[_vehicleNetID] call ExileServer_DeployableVehicles_network_deleteVehicleRequest;
/*
//diag_log format["--<> ExileServer_DeployableVehicles_network_packVehicleRequest:  _data = %1",_data];
private["_msg","_vehicle","_playerNetID","_playerVehicles"];
_vehicle = objectFromNetID _vehicleNetID;
deployableVehicles = deployableVehicles - [_vehicleNetID];
//diag_log format["--<> ExileServer_DeployableVehicles_network_packVehicleRequest:  deployableVehicles = %1",deployableVehicles];
removeAllActions _vehicle;
_vehicle removeAllEventHandlers "getout";
_playerNetID = _vehicle getVariable["playerOwner",objNull];
_player = objectFromNetID _playerNetID;
_playerVehicles = _player getVariable["deployableVehicles"];
_playerVehicles = _playerVehicles - [_vehicleNetID];
diag_log format["--<> ExileServer_DeployableVehicles_network_packVehicleRequest:  _playerVehicles = %1",_playerVehicles];
_player setVariable["deployableVehicles",_playerVehicles];
deleteVehicle _vehicle;
*/
_msg = ["Success"];
[_sessionID, "packVehicleResponse", _msg] call ExileServer_system_network_send_to;

true