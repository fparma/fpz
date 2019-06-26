#include "script_component.hpp"


if (!hasInterface || {RETDEF(GVAR(zen),false)} || {isNil "zen_custom_modules_fnc_register"}) exitWith {false};
GVAR(zen) = true;
private _cat = "FP Zombies";

[_cat, "Create zone", {
  params ["_pos"];

  private _opt1 = [-1, 10, 20, 30, fpz_defaultDensity];
  private _opt2 = [20, 50, 100, 200, 300, 500];
  private _opt3 = [-1, 5, 10, 20, 30, 50];

  ["Create zone settings", [
      ["COMBO", "Density", [_opt1, ["Infinite (respawning)"] + (_opt1 select [1, count _opt1] apply {str _x + " zombies"})]],
      ["COMBO", "Size of zone", [_opt2, _opt2 apply {str _x + "m"}, 2]],
      ["COMBO", "Max active zombies in zone", [_opt3, ["None (distance based)"] + (_opt3 select [1, count _opt3] apply {str _x})]]
    ], {
      params ["_dialog", "_args"];
      _dialog params ["_density", "_radius", "_maxActive"];
      _args params ["_pos"];

      ([_pos, "AREA:", [_radius, _radius, 0, true]] call CBA_fnc_createTrigger) params ["_trigger"];
      [_trigger, _density, -1, -1, _maxActive] remoteExecCall [QFUNC(registerZone), 2];
  }, {}, [_pos]] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

[_cat, "Spawn wandering", {
  params ["_pos"];

  private _opt1 = [1, 5, 10, 15, 20];
  private _opt2 = [5, 10, 20, 50, 100, 200];

  ["Spawn wandering zombies", [
      ["COMBO", "Amount", [_opt1, _opt1 apply {str _x + " zombies"}, 1]],
      ["COMBO", "Random radius", [_opt2, _opt2 apply {str _x + "m"}, 0]]
    ], {
      params ["_dialog", "_args"];
      _dialog params ["_amount", "_radius"];
      _args params ["_pos"];
      for "_i" from 1 to _amount do {
        private _z = [] call EFUNC(zombies,spawnZombie);
        if (!isNull _z) then {
          private _rpos = [_pos, _radius] call CBA_fnc_randPos;
          [_z, _rpos] call EFUNC(zombies,zombieInit);
        };
      };
  }, {}, [_pos]] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

[_cat, "Spawn horde", {
  params ["_pos"];

  private _opt1 = [5, 10, 15, 20];
  ["Spawn zombie horde", [
      ["COMBO", "Amount", [_opt1, _opt1 apply {str _x + " zombies"}, 0]],
      ["CHECKBOX", "Spawn yell"],
      ["CHECKBOX", "Force spawn (ignore max zed)"]
    ], {
      params ["_dialog", "_args"];
      _dialog params ["_amount", "_sound", "_ignoreMaxZombies"];
      _args params ["_pos"];

      [_pos, _amount, _sound, _ignoreMaxZombies] call FUNC(spawnHorde);
  }, {}, [_pos]] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

true
