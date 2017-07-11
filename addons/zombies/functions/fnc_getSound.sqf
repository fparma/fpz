#include "script_component.hpp"
#define CLY_IDLE ["fpz_idle%1", 1 + floor random 8]
#define RVG_IDLE ["rvg_idle_%1", floor random 25]

#define CLY_CHASE ["fpz_chase%1", 1 + floor random 8]
#define RVG_CHASE ["rvg_chase_%1", floor random 15]

#define CLY_ATTACK ["fpz_attack%1", 1 + floor random 4]
#define RVG_ATTACK ["rvg_attack_%1", floor random 10]


params [["_mode", ""]];

private _sound = switch (_mode) do {
  case "idle": {format ([CLY_IDLE, RVG_IDLE] select fpz_rvgSounds)};
  case "chase": {format ([CLY_CHASE, RVG_CHASE] select fpz_rvgSounds)};
  case "attack": {format ([CLY_ATTACK, RVG_ATTACK] select fpz_rvgSounds)};
  case "hit": {
    selectRandom([
      ["WoundedGuyB_05", "WoundedGuyB_06", "WoundedGuyB_07","WoundedGuyB_08","WoundedGuyA_08","WoundedGuyA_07","WoundedGuyA_06"], 0.8,
      ["fpz_scream1","fpz_scream2", "fpz_scream3", "fpz_scream4", "fpz_scream5"], 0.2
    ] call BIS_fnc_selectRandomWeighted);
  };
  default {
    ERROR_1("Unknown sound",_mode);
    ""
  };
};

_sound
