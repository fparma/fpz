#include "script_component.hpp"
#define MIN_DIST 8

params ["_zone"];
if (_zone getVariable QGVAR(positions) isEqualType []) exitWith {};

private _amount = _zone getVariable [QGVAR(amount), 1];
private _radius = _zone getVariable [QGVAR(radius), 500];
private _positions = [];

private _fnc_noNearbyPosition = {
  {if (_this distance2D _x < MIN_DIST) exitWith {1}} count _positions isEqualTo 0
};

for "_i" from 1 to _amount do {
  private "_pos";
  private _success = false;

  for "_i" from 0 to 10 do {
    _pos = [_zone] call CBA_fnc_randPosArea;
    if (!surfaceIsWater _pos && {_pos call _fnc_noNearbyPosition}) exitWith {
      _success = true;
    };
  };

  if (_success) then {
    _positions pushBack _pos;
  };
};

_zone setVariable [QGVAR(positions), _positions];

#ifdef DEBUG_MODE_FULL
{
  private "_m";
  _m = createMarkerLocal [format ["%1%2",QGVAR(debugMrkPos), _x], _x];
  _m setMarkerSizeLocal [0.3, 0.3];
  _m setMarkerShapeLocal "ICON";
  _m setMarkerTypeLocal "mil_dot";
  _m setMarkerColorLocal "ColorRed";
  _m setMarkerTextLocal format ["%1", _forEachIndex + 1];
} forEach _positions;
#endif
