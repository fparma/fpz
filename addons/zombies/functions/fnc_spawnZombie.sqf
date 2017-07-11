#include "script_component.hpp"

params [
  ["_type", "", [""]],
  ["_ignoreMax", false, [false]]
];

if (!_ignoreMax &&
  {count (entities "CAManBase" select {alive _x && {_x isKindOf "zombie"}}) > FPZ_maxAliveZombies}
) exitWith {objNull};

if (_type == "") then {
  _type = fpz_zombieTypes call BIS_fnc_selectRandomWeighted;
};

// Zombie will always spawn on [0,0], seems to be MUCH faster
(createAgent [_type, [0,0], [], 0, "NONE"]) // return
