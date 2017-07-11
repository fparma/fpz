/*
* Handle zombie damage. Legs never go above .49 to make them not limp
*/
#include "script_component.hpp"
params ["_zombie", "_selection", "_dmg", "_source", "_proj", "_hitPartIdx", "_instigator", "_hitPoint"];

if (_instigator in GVAR(targets) && {isNull (_zombie getVariable [QGVAR(victim), objNull])}) then {
  _zombie setVariable [QGVAR(victim), _instigator];
  _zombie setVariable [QGVAR(victimChangeTimeout), CBA_missionTime + 6 + random 8];
};

if (_hitPoint == "HitLegs") exitWith {
  if ((_zombie getHitPointDamage "HitLegs") + _dmg > 0.49) then {
    _zombie setHitPointDamage ["HitLegs", 0.49];
    _dmg = 0;
  };
  _dmg
};
