/**
* Chases a victim
* Return: if still chasing
*/
#include "script_component.hpp"
#define VICTIM_CHANGE_TIMEOUT CBA_missionTime + 4 + random 3
#define SOUND_WAIT_INCREASE CBA_missionTime + 7 + random 8
params ["_zombie", ["_victim", objNull]];

if (CBA_missionTime > _zombie getVariable [QGVAR(victimChangeTimeout), 0]) then {
  _zombie setVariable [QGVAR(victimChangeTimeout), VICTIM_CHANGE_TIMEOUT];
  private _newVictim = [_zombie, 20] call FUNC(getNearestVictim);
  if (!isNull _newVictim && {_newVictim != _victim}) then {
    _victim = _newVictim;
    _zombie setVariable [QGVAR(victim), _victim];
  };
};

if (!(_victim in GVAR(targets)) || {
  !(_zombie getVariable [QGVAR(aggroRange), 0] isEqualTo 1E4) &&
  {_zombie distance _victim > FPZ_maxChaseDistance}
}) exitWith {false};

_zombie lookAt _victim;
if (CBA_missionTime > _zombie getVariable [QGVAR(attackWait), 0] && {[_zombie, _victim] call FUNC(canAttack)}) then {
  TRACE_1("Attack", _victim);
  [_zombie, _victim] call FUNC(actionAttack);
} else {
  if (CBA_missionTime > _zombie getVariable [QGVAR(chaseSoundWait), 0]) then {
    _zombie setVariable [QGVAR(chaseSoundWait), SOUND_WAIT_INCREASE];
    private _sound = ["chase"] call FUNC(getSound);
    [_zombie, _sound] remoteExecCall ["say3D"];
  };

  if (CBA_missionTime > _zombie getVariable [QGVAR(chaseMoveWait), 0]) then {

    [_zombie, _victim] call FUNC(getPosChase) params ["_pos", "_planningMode"];
    _zombie forceSpeed 18;
    _zombie setDestination [_pos, _planningMode, true];
    _zombie setVariable [QGVAR(chaseMoveWait), CBA_missionTime + 1.2];

    #ifdef DEBUG_MODE_FULL
      (_zombie getVariable [QGVAR(debugArrow), objNull]) setPosATL _pos;
    #endif
  };
};

true
