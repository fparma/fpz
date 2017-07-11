/*
* Checks what the zombie is doing currently and next action
*/

#include "script_component.hpp"

params [["_zombie", objNull]];

private _currentVictim = _zombie getVariable [QGVAR(victim), objNull];

if (_currentVictim isEqualTo objNull) then {
  // Loiter, search targets
  private _aggroRange = _zombie getVariable QGVAR(aggroRange);
  private _nearestVictim = [_zombie, _aggroRange] call FUNC(getNearestVictim);
  if (!isNull _nearestVictim && {[_zombie, _nearestVictim, _aggroRange] call FUNC(canSee)}) then {
    _zombie setVariable [QGVAR(victim), _nearestVictim];
    _zombie setVariable [QGVAR(victimChangeTimeout), CBA_missionTime + 10];
  } else {
    [_zombie] call FUNC(actionLoiter);
  };

} else {
  // Chase
  private _isChasing = [_zombie, _currentVictim] call FUNC(actionChase);
  if (_isChasing isEqualTo false) then {
    _zombie forceSpeed 2;
    _zombie lookAt objNull;
    _zombie setVariable [QGVAR(victim), objNull];
    _zombie setVariable [QGVAR(loiterTimeout), CBA_missionTime + random 5];
  };
};
