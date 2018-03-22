/*
* Handle zombie damage. Legs never go above .49 to make them not limp
*/
#include "script_component.hpp"
params ["_zombie", "_selection", "_dmg", "_source", "_proj", "_hitPartIdx", "_instigator", "_hitPoint"];

if (_instigator in GVAR(targets) && {isNull (_zombie getVariable [QGVAR(victim), objNull])}) then {
  _zombie setVariable [QGVAR(victim), _instigator];
  _zombie setVariable [QGVAR(victimChangeTimeout), CBA_missionTime + 6 + random 8];
};

if (_hitPoint == "HitLegs" && {(_zombie getHitPointDamage "HitLegs") + _dmg > 0.49}) exitWith {
  TRACE_1("prevent walking",_dmg);
  _zombie setHitPointDamage ["HitLegs", 0.49];
  0
};

private _oldDamage = if (_selection == "") then {damage _zombie} else {_zombie getHit _selection};
private _ret = _oldDamage + (_dmg - _oldDamage) * (_zombie getVariable ["fpz_zombieDamageMultiplier", fpz_zombieDamageMultiplier]);
_ret
