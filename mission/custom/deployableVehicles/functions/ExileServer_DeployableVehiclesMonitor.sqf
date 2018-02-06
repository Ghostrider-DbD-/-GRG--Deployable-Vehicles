/*
	ExileClient_DeployableVehiclesMonitor
	By Ghostrider[GRG]
	Copywrite 2017
	
	Running this Client-side to reduce server loadStatus
*/

diag_log "ExileServer_DeployableVehiclesMonitor Started: -- >>";
private["_vehicle","_timeStamp","_deployedVehicles","_maxTimeOnRoad","_maxTimeAbandoned"];

/*
_fn_deleteVehicle = {
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
};
*/

_maxTimeOnRoad = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "maxTimeAbandonedOnRoads");
_maxTimeAbandoned = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "maxTimeAbandoned");

while {true} do
{
	uiSleep 10;
	//_msg = format["deployableVehiclesMonitor: deployableVehiclesList[] = %1",deployableVehiclesList];
	//diag_log _msg;
	if (count deployableVehiclesList > 0) then
	{
		_deployedVehicles = +deployableVehiclesList;
		{
			// _x here is the vehicle netID
			_vehicle = objectFromNetId _x;
			if ((count (crew _vehicle)) > 0) then
			{
				_vehicle setVariable["timeStamp",nil];
				//diag_log format["<>--<>  ExileServer_DeployableVehiclesMonitor:  vehicle %1 has crew",_vehicle];
			};
			if ((count (crew _vehicle)) == 0) then
			{
				_timeStamp = _vehicle getVariable["timeStamp",0];
				//diag_log format["<>--<>  ExileServer_DeployableVehiclesMonitor:  _timeStamp = %1 and diag_tickTime = %2",_timeStamp,diag_tickTime];
				if (_timeStamp == 0) then 
				{
					_timeStamp = diag_tickTime;
					_vehicle setVariable["timeStamp",_timeStamp];
				};
				if ( (isOnRoad _vehicle) && (diag_tickTime - _timeStamp) > _maxTimeOnRoad) then
				{
					//diag_log format["<>--<>  ExileServer_DeployableVehiclesMonitor:  deleting vehicle %1 located on a road after %2 seconds",_vehicle,diag_tickTime - _timeStamp];
					[_x] call ExileServer_DeployableVehicles_network_deleteVehicleRequest;
				};
				if ( !(isOnRoad _vehicle) && (diag_tickTime - _timeStamp) > _maxTimeAbandoned) then
				{
					//diag_log format["<>--<>  ExileServer_DeployableVehiclesMonitor:  deleting vehicle %1 located on located OFF-road after %2 seconds",_vehicle,diag_tickTime - _timeStamp];
					[_x] call ExileServer_DeployableVehicles_network_deleteVehicleRequest;
				};
			};
		} forEach _deployedVehicles;
	};
};


