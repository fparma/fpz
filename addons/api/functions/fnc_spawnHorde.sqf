#include "script_component.hpp"

params [
  ["_pos", []],
  ["_amount", 6, [0]],
  ["_sound", true],
  ["_ignoreMaxZombies", false]
];

private _posList = [];
for "_i" from 1 to _amount do {
  private _rnd = if (_pos isEqualType objNull && {_pos isKindOf "EmptyDetector"}) then {
    [_pos] call CBA_fnc_randPosArea;
  } else {
    (_pos call CBA_fnc_getPos) getPos [random 10, random 360];
  };

  _posList pushBack _rnd;
};

if (_posList isEqualTo []) exitWith {};

private _hcs = EGVAR(zombies,headlessClients) select {!isNull _x};
if (_hcs isNotEqualTo []) then {
  [QEGVAR(zombies,spawnZombieBulk), [["zombie_bolter", "zombie_runner"], _posList, true], selectRandom _hcs] call CBA_fnc_targetEvent;
} else {
  [QEGVAR(zombies,spawnZombieBulk), [["zombie_bolter", "zombie_runner"], _posList, true]] call CBA_fnc_serverEvent;
};

if (_sound) then {
  playSound3D ["rvg_zeds\sounds\zombie_yell.ogg", objNull, false, AGLToASL (_posList select 0), 5, 1, 1200];
};
