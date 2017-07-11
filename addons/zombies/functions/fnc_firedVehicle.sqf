/**
* Alert nearby zombies when firing
*/

#include "script_component.hpp"
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (CBA_missionTime < _unit getVariable [QGVAR(vehicleFiredTimeout), 0]) exitWith {};
_unit setVariable [QGVAR(vehicleFiredTimeout), CBA_missionTime + 3];

// TODO: calculate distance? is there a turret which can be silent
private _distance = 120 + random 30;
private _list = _unit nearEntities ["zombie", _distance];

TRACE_4("audible vehicle fire",_unit, _weapon, _distance, count _list);
{
  if (local _x && {isNull (_x getVariable [QGVAR(victim), objNull])}) then {
    _x setVariable [QGVAR(victim), effectiveCommander _unit];
    _x setVariable [QGVAR(victimChangeTimeout), CBA_missionTime + 6 + random 8];
  };
} forEach _list;
