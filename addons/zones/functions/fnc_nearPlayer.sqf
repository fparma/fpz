#include "script_component.hpp"
params ["_pos", "_range"];

private _ret = false;

{
  if (_x distance _pos < _range) exitWith {_ret = true};
} forEach GVAR(players);

_ret
