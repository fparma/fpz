#include "script_component.hpp"

params [
  ["_pos", []],
  ["_amount", 6, [0]],
  ["_sound", true],
  ["_ignoreMaxZombies", false]
];

private _zombies = [];
for "_i" from 1 to _amount do {
  private _rnd = if (_pos isEqualType objNull && {_pos isKindOf "EmptyDetector"}) then {
    [_pos] call CBA_fnc_randPosArea;
  } else {
    (_pos call CBA_fnc_getPos) getPos [random 10, random 360];
  };

  private _zombie = [selectRandom ["zombie_bolter", "zombie_runner"], _ignoreMaxZombies] call EFUNC(zombies,spawnZombie);
  if (!isNull _zombie) then {
    _zombies pushBack _zombie;
    [_zombie, _rnd, true] call EFUNC(zombies,zombieInit);
    if (_sound && {_i >= _amount} && {!isNull _zombie}) then {
      [_zombie, ["fpz_yell", 1200, 1]] remoteExecCall ["say", 0];
    };
  };
};

_zombies
