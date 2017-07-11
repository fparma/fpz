/**
* Returns a random hit from a zombie with its damage
*/
#include "script_component.hpp"
params [["_target", objNull]];

private _sel = [
  "head", 0.1,
  "body", 0.3,
  "hand_l", 0.15,
  "hand_r", 0.15,
  "leg_l", 0.15,
  "leg_r", 0.15
] call BIS_fnc_selectRandomWeighted;

private _isPlayer = [_target] call ace_common_fnc_isPlayer;
private _baseDamage =  [0.2, 0.1] select _isPlayer;

private _dam = _baseDamage + random (switch (_sel) do {
  case "head": {0.2};
  case "body": {0.4};
  case "leg_l";
  case "leg_r";
  case "hand_l";
  case "hand_r"; {0.5};
  default {0}
});

// less damage when down
if (_isPlayer && {_target getVariable ["ACE_isUnconscious", false]}) then {
  _dam = _dam min 0.15;
};

_dam = _dam * (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]);
[_sel, _dam]
