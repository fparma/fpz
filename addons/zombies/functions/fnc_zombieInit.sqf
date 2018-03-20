/**
* Init a zombie with default values
*/

#include "script_component.hpp"

params [
  ["_zombie", objNull, [objNull]],
  ["_pos", []],
  ["_isHorde", false]
];
if (!alive _zombie) exitWith {};

{_zombie disableAI _x} forEach ["TARGET", "AUTOTARGET", "FSM", "AUTOCOMBAT", "COVER", "SUPPRESSION", "CHECKVISIBLE"];
_zombie setVariable ["BIS_fnc_animalBehaviour_disable", true];
_zombie setVariable ["BIS_enableRandomization", false];

removeAllAssignedItems _zombie;
removeAllItems _zombie;
removeAllWeapons _zombie;

_zombie setSkill 0;
_zombie addRating -1E4;
_zombie allowSprint true;
_zombie enableFatigue false;
_zombie enableStamina false;
_zombie setCombatMode "BLUE";
_zombie setBehaviour "CARELESS";
_zombie setDir random 360;
_zombie allowFleeing 0;
_zombie setDamage 0.45;
_zombie forceSpeed 2;

if (!(_pos isEqualTo [])) then {
  _zombie setVariable [QGVAR(loiterBase), _pos];
  _zombie setPosATL _pos;
};

if (_isHorde) then {
  _zombie setVariable [QGVAR(aggroRange), 1E4];
  _zombie setVariable [QGVAR(victim), [_zombie, 1E4] call FUNC(getNearestVictim)];
} else {
  fpz_aggroRangeInterval params ["_agMin", "_agMax"];
  _zombie setVariable [QGVAR(aggroRange), RANDOM_INTERVAL(_agMin,_agMax)];
};

_zombie setVariable [QGVAR(idleSoundWait), CBA_missionTime + 5 + random 20];
_zombie setVariable [QGVAR(loiterTimeout), CBA_missionTime + 5 + random 15];

private _identity = format ["zombie%1", round (1 + random 11)];
[QGVAR(onSpawn), [_zombie, _identity, _pos]] call CBA_fnc_globalEvent;

_zombie playMove format ["babe_rvg_zed_stand_%1", typeOf _zombie];
_zombie addEventHandler ["AnimDone", {_this call FUNC(onAnimDone)}];

[{
  params ["_zombie"];
  {_zombie removeAllEventHandlers _x} forEach ["HandleDamage", "Killed", "Hit", "FiredNear"];
  _zombie addEventHandler ["HandleDamage", {_this call FUNC(handleDamage)}];
  _zombie addEventHandler ["Killed", {[QGVAR(onZombieDeath), _this] call CBA_fnc_localEvent}];

  GVAR(zombies) pushBackUnique _zombie;
}, _zombie] call CBA_fnc_execNextFrame;


#ifdef DEBUG_MODE_FULL
  _zombie setVariable [QGVAR(debugArrow),
    (selectRandom ["Sign_Arrow_F","Sign_Arrow_Green_F","Sign_Arrow_Blue_F","Sign_Arrow_Pink_F","Sign_Arrow_Yellow_F","Sign_Arrow_Cyan_F"])
    createVehicle [0,0]];
#endif
