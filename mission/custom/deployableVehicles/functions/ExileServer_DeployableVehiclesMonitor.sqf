/*
	ExileClient_DeployableVehiclesMonitor
	By Ghostrider[GRG]
	Copywrite 2017
	
	Running this Client-side to reduce server loadStatus
*/

diag_log "ExileServer_DeployableVehiclesMonitor Started: -- >>";
private["_vehicle","_timeStamp","_deployedVehicles","_maxTimeOnRoad","_maxTimeAbandoned"];

_maxTimeOnRoad = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "maxTimeAbandonedOnRoads");
_maxTimeAbandoned = getNumber (missionConfigFile >> "deployableVehicles" >> "configs" >> "maxTimeAbandoned");

while {true} do
{
	uiSleep 10;
	if (count deployableVehiclesList > 0) then
	{
		_deployedVehicles = +deployableVehiclesList;
		{
			// _x here is the vehicle netID
			_vehicle = objectFromNetId _x;
			if ((count (crew _vehicle)) > 0) then
			{
				_vehicle setVariable["timeStamp",nil];
			};
			if ((count (crew _vehicle)) == 0) then
			{
				_timeStamp = _vehicle getVariable["timeStamp",0];
				if (_timeStamp == 0) then 
				{
					_timeStamp = diag_tickTime;
					_vehicle setVariable["timeStamp",_timeStamp];
				};
				if ( (isOnRoad _vehicle) && (diag_tickTime - _timeStamp) > _maxTimeOnRoad) then
				{
					[_x] call ExileServer_DeployableVehicles_network_deleteVehicleRequest;
				};
				if ( !(isOnRoad _vehicle) && (diag_tickTime - _timeStamp) > _maxTimeAbandoned) then
				{
					[_x] call ExileServer_DeployableVehicles_network_deleteVehicleRequest;
				};
			};
		} forEach _deployedVehicles;
	};
};


