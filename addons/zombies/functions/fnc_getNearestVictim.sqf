/**
* Gets nearest victim within range
*/

#include "script_component.hpp"
params ["_fromPos", ["_minRange", 1500]];
private _ret = objNull;
if (GVAR(targets) isEqualTo []) exitWith {_ret};

private _targets = (GVAR(targets) apply {[_x distance _fromPos, _x]});
_targets sort true;
(_targets select 0) params ["_distance", "_unit"];

private _veh = vehicle _unit;
if (!(_veh isEqualTo _unit) && {isEngineOn _veh}) then {_distance = _distance * FPZ_vehicleAggroMultiplier};
if (_distance < _minRange) then {_ret = _unit};

_ret
