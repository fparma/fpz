/*
* Handle zombie damage. Legs never go above .49 to make them not limp
*/
#include "script_component.hpp"
params ["_zombie", "_selection", "_dmg", "_source", "_proj", "_hitPartIdx", "_instigator", "_hitPoint"];

if (_instigator in GVAR(targets) && {isNull (_zombie getVariable [QGVAR(victim), objNull])}) then {
  _zombie setVariable [QGVAR(victim), _instigator];
  _zombie setVariable [QGVAR(victimChangeTimeout), CBA_missionTime + 6 + random 8];
};

private _ret = _dmg;
if (!(toLower _hitPoint in ["hitface", "hitneck", "hithead"])) then {
  private _curDamage = damage _zombie;
  if (_selection != "") then {_curDamage = _zombie getHitPointDamage _hitPoint};
  private _newDamage = _dmg - _curDamage;
  _ret = _dmg - _newDamage * (1 - fpz_zombieDamageNonHeadMultiplier);
};

if (_hitPoint == "HitLegs" && {(_zombie getHitPointDamage "HitLegs") + _dmg > 0.49}) then {
    _zombie setHitPointDamage ["HitLegs", 0.49];
    _ret = 0;
};

_ret
