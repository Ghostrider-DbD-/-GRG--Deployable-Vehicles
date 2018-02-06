/*
	ExileServer_DeployableVehicles_network_deleteVehicleRequest
	By Ghostrider[GRG]
	Copyright 2017
*/
diag_log "<>--<>  Function:: ExileServer_DeployableVehicles_network_deleteVehicleRequest called.";
waitUntil {deployableVehiclesOperationInProgress_server == 0};
deployableVehiclesOperationInProgress_server = 1;
private["_vehicle","_vehicleNetID"];
_vehicleNetID = _this select 0;
deployableVehiclesList = deployableVehiclesList - [_this select 0];
_vehicle = objectFromNetId _vehicleNetID;
_vehicleOwnerNetID = _vehicle getVariable["playerOwner",""];
_vehicleOwner = objectFromNetId _vehicleOwnerNetID;
_deployedVehiclesOwner = _vehicleOwner getVariable["deployableVehicles",[]];
_vehicleOwner setVariable["deployableVehicles", _deployedVehiclesOwner - [_vehicleNetID]];
removeAllActions _vehicle;
_vehicle removeAllEventHandlers "getout";
deleteVehicle _vehicle;
deployableVehiclesOperationInProgress_server = 0;	
true