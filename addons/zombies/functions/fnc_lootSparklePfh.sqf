/**
* Show sparkles on nearby corpses with items/ammo/weps
* Credits to Celery for original code
*/
#include "script_component.hpp"
#define RED [[1, 0, 0, 1]]
#define GREEN [[0, 1, 0, 1]]
#define BLUE [[0, 0.8, 1, 1]]
#define PURPLE [[1, 0,.5, 1]]
#define WHITE [[1, 1, 1, 1]]

if (!alive player || {!(simulationEnabled player)}) exitWith {};

{
  if (!(weapons _x + magazines _x + items _x isEqualTo [])) then {
    for "_i" from 0 to 3 do {
      drop [
      "\A3\data_f\kouleSvetlo",
      "",
      "Billboard",
      3,
      5,
      [-0.25 + random 0.5, -0.25 + random 0.5, 0.15], // pos
      [0, 0, 0],
      0,
      1.26,
      1,
      0,
      [0, 0.015, 0.01, 0.005, 0],
      selectRandom [RED, GREEN, BLUE, PURPLE, WHITE],
      [0],
      0,
      0,
      "",
      "",
      _x];
    };
  };
} forEach (allDeadMen select {_x distance2d player < 50 && {_x isKindOf "zombie"}});
