/**
* Checks if target can be a victim
*/
#include "script_component.hpp"
params [["_t", objNull]];

(
  alive _t &&
  {!(_t isKindOf "zombie")} &&
  //TODO: should zombies be able to kill players when down?
  //{!(_t getVariable ["ACE_isUnconscious", false]) || !([_t] call ace_common_fnc_isPlayer)} &&
  {!(_t getVariable [QGVAR(ignore), false])} &&
  {simulationEnabled _t} &&
  {(getPosATL vehicle _t) select 2 < 50}
)
