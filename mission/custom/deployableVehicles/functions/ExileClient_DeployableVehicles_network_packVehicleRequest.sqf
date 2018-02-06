/*
	ExileClient_DeployableVehicles_network_packVehicleResquest
	By Ghostrider[GRG]
	Copyright 2017
	Called upon selecting the Pack Vehicle Action for the Vehicle
	
    Parameters array passed to the script upon activation in _this variable is: [target, caller, ID, arguments]
    target (_this select 0): Object - the object which the action is assigned to
    caller (_this select 1): Object - the unit that activated the action
    ID (_this select 2): Number - ID of the activated action (same as ID returned by addAction)
    arguments (_this select 3): Anything - arguments given to the script if you are using the extended syntax

*/
deployableVehiclePacked = 1;
//_msg = "-->> function ExileClient_DeployableVehicles_network_packVehicleResquest called";
//diag_log _msg;
//_msg = format["-->> function ExileClient_DeployableVehicles_network_packVehicleResquest:  _this = %1",_this];
//diag_log _msg;

params["_target","_caller"];
_vehicleNetID = netID _target;
["packVehicleRequest",[_vehicleNetID]] call ExileClient_system_network_send;




