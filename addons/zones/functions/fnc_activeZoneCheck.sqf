#include "script_component.hpp"
#define NEARBY_PLAYER(X,Y) ([X,Y] call FUNC(nearPlayer))
#define DEACTIVATE_MODIFIER 100

params ["_zone"];
private _positions = _zone getVariable [QGVAR(positions), []];
private _zombies = _zone getVariable [QGVAR(zombies), []];
TRACE_2("Check zone", count _positions, count _zombies);

for "_i" from (count _zombies) to 0 step -1 do {
  private _idx = _i - 1;
  private _zombie = _zombies param [_idx, objNull];
  if (!alive _zombie) then {
    _zombies deleteAt _idx;
    #ifdef DEBUG_MODE_FULL
      if !(_zone getVariable [QGVAR(infinite), false]) then {
        deleteMarkerLocal format ["%1%2",QGVAR(debugMrkPos), _zombie getVariable [QGVAR(zonePos), []]];
      };
    #endif
  } else {
    if (!NEARBY_PLAYER(_zombie,fpz_despawnDistance)) then {
      private _pos = _zombie getVariable [QGVAR(zonePos), []];
      if !(_pos isEqualTo []) then {
        _positions pushBack _pos;
        #ifdef DEBUG_MODE_FULL
          format ["%1%2",QGVAR(debugMrkPos), _pos] setMarkerColorLocal "ColorRed";
        #endif
      };
      #ifdef DEBUG_MODE_FULL
        deleteVehicle (_zombie getVariable [QEGVAR(zombies,debugArrow), objNull]);
      #endif
      deleteVehicle _zombie;
      _zombies deleteAt _idx;
    };
  };
};

private _empty = _zombies isEqualTo [];
if (_empty && {_positions isEqualTo []}) exitWith {true};

private _deactivateDistance = (_zone getVariable [QGVAR(activateDistance), fpz_maxChaseDistance]) + DEACTIVATE_MODIFIER;
if (_empty && {!([_zone, _deactivateDistance] call FUNC(nearPlayer))}) exitWith {
  _zone setVariable [QGVAR(active), false];
  #ifdef DEBUG_MODE_FULL
    {format ["%1%2", QGVAR(debugMrkPos), _x] setMarkerAlphaLocal 0} forEach _positions;
  #endif
  TRACE_3("Deactivating zone", _zone, count _zombies, count _positions);
  false
};

// Check max active in zone
private _max = _zone getVariable [QGVAR(maxActiveInZone), -1];
if (_max > -1 && {count _zombies >= _max}) exitWith {false};

private _idx = -1;
{
  if (!([_x,fpz_spawnDistanceMin] call FUNC(nearPlayer)) && {([_x,fpz_spawnDistanceMax] call FUNC(nearPlayer))}) exitWith {
    private _zombie = [] call EFUNC(zombies,spawnZombie);
    if (!isNull _zombie) then {
      _zombie setVariable [QGVAR(zonePos), _x];
      [_zombie, _x] call EFUNC(zombies,zombieInit);
      _zombies pushBack _zombie;
      _idx = _forEachIndex;

      if (_zone getVariable [QGVAR(infinite), false]) then {
        _zombie setVariable [QGVAR(addBack), _zone];
      };

      #ifdef DEBUG_MODE_FULL
        format ["%1%2",QGVAR(debugMrkPos), _positions select _idx] setMarkerColorLocal "ColorBlack";
      #endif
    };
  };
} forEach _positions;

if (_idx > -1) then {_positions deleteAt _idx};

false
