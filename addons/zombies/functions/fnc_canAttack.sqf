/**
* Determines if a zombie can attack target
* Based on code in rvg
*/

#include "script_component.hpp"

#define ATTACK_DIST 2.2

params ["_zombie", "_target"];
if !([_target] call FUNC(isValidVictim)) exitWith {false};
private _veh = vehicle _target;

private _bb = boundingBox _veh;
private _p1 = _bb select 0;
private _p2 = _bb select 1;
private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));

private _center = getPosASL _veh;
_center set [2, (_center select 2) + .5];
private _res = getPosASL _zombie inArea [_center, _maxWidth * 1.5, _maxHeight * 1.5, _veh getRelDir _zombie, false, 2];

if (_res && {_target == _veh}) then {
  private _eyePos = eyePos _target;
  _eyePos set [2, (_eyePos select 2) + 0.1]; // eyepos is underground if unconscious
  _res = lineIntersectsSurfaces [eyePos _zombie, _eyePos, _zombie, _target, true, 1, "GEOM", "VIEW"] isEqualTo [];
};

_res
