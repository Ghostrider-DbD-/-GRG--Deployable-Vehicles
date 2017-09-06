/**
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

if (isServer) then
{
	diag_log "Compiling deployableVehicles system Server Routines --->>>";	
	deployableVehiclesList = [];
	deployableVehiclesOperationInProgress_server = 0;

	private ['_code', '_function', '_file'];

	{
		_code = '';
		_function = _x select 0;
		_file = _x select 1;

		_code = compileFinal (preprocessFileLineNumbers _file);

		missionNamespace setVariable [_function, _code];
		diag_log format["deployableVehicle Server: attempted to compile file %1",_file];
	}
	forEach
	[
	    ['ExileServer_DeployableVehiclesMonitor', 'custom\deployableVehicles\functions\ExileServer_DeployableVehiclesMonitor.sqf'],	
		['ExileServer_DeployableVehicles_network_deleteVehicleRequest', 'custom\deployableVehicles\functions\ExileServer_DeployableVehicles_network_deleteVehicleRequest.sqf'],
		['ExileServer_DeployableVehicles_network_deployVehicleRequest', 'custom\deployableVehicles\functions\ExileServer_DeployableVehicles_network_deployVehicleRequest.sqf'],
	    ['ExileServer_DeployableVehicles_network_packVehicleRequest', 'custom\deployableVehicles\functions\ExileServer_DeployableVehicles_network_packVehicleRequest.sqf']
	];
	diag_log "deployableVehicles system Server Routines initialized --->>>";	
	[] call ExileServer_DeployableVehiclesMonitor;

};

if (hasInterface) then
{
	private ['_code', '_function', '_file'];
	deployableVehiclePacked = 0;
	{
		_code = '';
		_function = _x select 0;
		_file = _x select 1;

		_code = compileFinal (preprocessFileLineNumbers _file);

		missionNamespace setVariable [_function, _code];
		diag_log format["deployableVehicle Client: attempted to compile file %1",_file];
	}
	forEach
	[
		['ExileClient_DeployableVehicles_EH_getOut', 'custom\deployableVehicles\functions\ExileClient_DeployableVehicles_EH_getOut.sqf'],
		['ExileClient_DeployableVehicles_network_deployVehicleRequest', 'custom\deployableVehicles\functions\ExileClient_DeployableVehicles_network_deployVehicleRequest.sqf'],
	    ['ExileClient_DeployableVehicles_network_deployVehicleResponse', 'custom\deployableVehicles\functions\ExileClient_DeployableVehicles_network_deployVehicleResponse.sqf'],
	    ['ExileClient_DeployableVehicles_network_packVehicleResponse', 'custom\deployableVehicles\functions\ExileClient_DeployableVehicles_network_packVehicleResponse.sqf'],	
		['ExileClient_DeployableVehicles_network_packVehicleRequest', 'custom\deployableVehicles\functions\ExileClient_DeployableVehicles_network_packVehicleRequest.sqf']
	];

	diag_log "deployableVehicles system Client Routines initialized --->>>";
};






