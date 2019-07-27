/*
	ExileServer_DeployableVehicles_network_packVehicleRequest
	By Ghostrider[GRG]
	Copyright 2017
*/

params["_sessionID","_data"];
_data params ["_vehicleNetID"];	
[_vehicleNetID] call ExileServer_DeployableVehicles_network_deleteVehicleRequest;
_msg = ["Success"];
[_sessionID, "packVehicleResponse", _msg] call ExileServer_system_network_send_to;

true