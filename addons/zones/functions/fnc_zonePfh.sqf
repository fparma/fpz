#include "script_component.hpp"

params ["", ["_pfhId", -1]];
if (GVAR(zones) isEqualTo []) exitWith {
  //[_pfhId] call CBA_fnc_removePerFrameHandler;
};

private _zone = GVAR(zones) deleteAt 0;
if (isNull _zone) exitWith {};

if (_zone getVariable [QGVAR(active), false]) then {
  [_zone] call FUNC(prepareZonePositions);
  #ifdef DEBUG_MODE_FULL
    {format ["%1%2", QGVAR(debugMrkPos), _x] setMarkerAlphaLocal 1} forEach (_zone getVariable QGVAR(positions));
  #endif

  private _depleted = [_zone] call FUNC(activeZoneCheck);
  if (_depleted isEqualTo true) then {
    #ifdef DEBUG_MODE_FULL
      {deleteMarkerLocal (format ["%1%2", QGVAR(debugMrkPos), _x])} forEach (_zone getVariable QGVAR(positions));
    #endif
    deleteVehicle _zone;
  } else {
    GVAR(zones) pushBack _zone;
  };
} else {
  private _playerNear = [getPosWorld _zone, _zone getVariable [QGVAR(activateDistance), fpz_maxChaseDistance]] call FUNC(nearPlayer);
  if (_playerNear) then {_zone setVariable [QGVAR(active), true]};
  GVAR(zones) pushBack _zone;
};
