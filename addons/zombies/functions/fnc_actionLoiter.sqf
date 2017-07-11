/*
* Moves zombie around
*/
#include "script_component.hpp"
#define MOVE_WAIT_INCREASE CBA_missionTime + 20 + random 30
#define SOUND_WAIT_INCREASE CBA_missionTime + 20 + random 10 - random 8
params ["_zombie"];

if (CBA_missionTime > _zombie getVariable [QGVAR(idleSoundWait), 0]) then {
  _zombie setVariable [QGVAR(idleSoundWait), SOUND_WAIT_INCREASE];
  private _sound = ["idle"] call FUNC(getSound);
  [_zombie, _sound] remoteExecCall ["say3D"];
};
if (CBA_missionTime < _zombie getVariable [QGVAR(loiterTimeout), 0]) exitWith {};

private _moveFrom = _zombie getVariable [QGVAR(loiterBase), getPosATL _zombie];
private _moveTo = _moveFrom getPos [RANDOM_INTERVAL(8,50), random 360];

if (surfaceIsWater _moveTo) exitWith {};

nearestObjects [_moveTo, ["House"], 20] params [["_building", objNull]];
if (!isNull _building) then {
  private _positions = _building buildingPos -1;
  if (count _positions >= 2) then {
    private _newPos = selectRandom _positions;
    if (count (_newPos nearEntities ["zombie", 2]) == 0) then {
      _moveTo = _newPos;
    };
  };
};

_zombie setDestination [_moveTo, "LEADER PLANNED", true];
_zombie setVariable [QGVAR(loiterTimeout), MOVE_WAIT_INCREASE];

#ifdef DEBUG_MODE_FULL
  (_zombie getVariable [QGVAR(debugArrow), objNull]) setpos _moveTo;
#endif
