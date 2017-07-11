/**
* Runs when units on foot are hit by a zombie
*/
#include "script_component.hpp"

params ["", "_target"];
if (CBA_missionTime < _target getVariable [QGVAR(hitTimeout), 0]) exitWith {};
_target setVariable [QGVAR(hitTimeout), CBA_missionTime + 1];

[{
  params ["_zombie", "_target"];
  if (!alive _target) exitWith {};

  ([_target] call FUNC(getRandomHitpointSelectionAndDamage)) params ["_selection", "_damage"];
  [_target, _damage, _selection, "punch"] call ace_medical_fnc_addDamageToUnit;

  [{
    params ["_target"];
    [_target, ["hit"] call FUNC(getSound)] remoteExecCall ["say3D"];
  }, [_target], 0.2] call CBA_fnc_waitAndExecute;

  if (!(ACE_PLAYER isEqualTo _target)) exitWith {};

  if (random 1 > .2) then {
    [41] call ace_medical_fnc_showBloodEffect;
  };

  if (!isNil "ace_hitreactions_fnc_fallDown" && {isNull objectParent _target} && {speed _target > 1} && {random 1 > 0.7}) then {
    [_target, objNull, 1] call ace_hitreactions_fnc_fallDown;
  } else {
    addCamShake [10, 1, 25];
  };
}, _this, 0.4] call CBA_fnc_waitAndExecute;
