#include "script_component.hpp"
params ["_pos", "_range"];

{
  if (_x distance _pos < _range) exitWith {true};
  false
} forEach GVAR(players);
