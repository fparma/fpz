#include "script_component.hpp"

if (!hasInterface && {!isServer}) then {
  // headless client
  [QGVAR(headlessClientJoined), [player]] call CBA_fnc_serverEvent;
};

[QGVAR(spawnZombie), {
  params [
    ["_type", ""],
    ["_pos", []],
    ["_isHorde", false]
  ];
  private _zombie = [_type] call FUNC(spawnZombie);
  if (isNull _zombie) exitWith {};
  [_zombie, _pos, _isHorde] call FUNC(zombieInit);
}] call CBA_fnc_addEventHandler;

[QGVAR(spawnZombieBulk), {
  params [["_types", []], ["_posList", []], ["_isHorde", false]];
  if (_types isEqualTo []) then {
    _types = [""];
  };
  {
    [QGVAR(spawnZombie), [selectRandom _types, _x, _isHorde]] call CBA_fnc_localEvent;
  } forEach _posList;
}] call CBA_fnc_addEventHandler;

// Runs for everyone when a zombie is spawned
[QGVAR(onSpawn), {
  params ["_zombie", "_identity", "_pos"];
  _zombie setIdentity _identity;

  if (local _zombie) then {
    [_zombie, _pos] call FPZ_onZombieInit;
  };
}] call CBA_fnc_addEventHandler;

// On zombie attack (strike) target
[QGVAR(onAttack), {
  params ["_zombie", "_target", ["_check", true]];
  if (_check && {!([_zombie, _target] call FUNC(canAttack))}) exitWith {};
  _this call FUNC(onVictimHit);
}] call CBA_fnc_addEventHandler;

[QGVAR(onZombieDeath), {
  params ["_zombie"];

  #ifdef DEBUG_MODE_FULL
    deleteVehicle (_zombie getVariable [QGVAR(debugArrow), objNull]);
  #endif

  if (random 1 > 0.6) then {
    playSound3d [format ["rvg_zeds\sounds\die%1.ogg", 1 + floor random 2], _zombie];
  };
}] call CBA_fnc_addEventHandler;

// On vehicle hit
[QGVAR(onVehicleAttack), {_this call FUNC(onVictimVehicleHit)}] call CBA_fnc_addEventHandler;
