#include "script_component.hpp"


if (!hasInterface || {RETDEF(GVAR(ares),false)} || {isNil "Ares_fnc_RegisterCustomModule"}) exitWith {false};
GVAR(ares) = true;
private _cat = "FP Zombies";

[_cat, "Create zone", {
  params ["_pos"];

  private _opt1 = [10, 20, 30, fpz_defaultDensity];
  private _opt2 = [20, 50, 100, 200, 300, 500];

  private _args = ["Create zone settings", [
      ["Density", _opt1 apply {str _x + " zombies"}, 0, true],
      ["Max radius for positions", _opt2 apply {str _x + "m"}, 2, true]
  ]] call Ares_fnc_ShowChooseDialog;
  if (count _args == 0) exitWith {};

  _args params ["_c1", "_c2"];
  private _density = _opt1 select _c1;
  private _radius = _opt2 select _c2;

  ([_pos, "AREA:", [_radius, _radius, 0, true]] call CBA_fnc_createTrigger) params ["_trigger"];
  [_trigger, _density] remoteExecCall [QFUNC(registerZone), 2];
}] call Ares_fnc_RegisterCustomModule;

[_cat, "Spawn wandering", {
  params ["_pos"];

  private _opt1 = [1, 5, 10, 15, 20];
  private _opt2 = [5, 10, 20, 50, 100, 200];

  private _args = ["Spawn wandering zombies", [
      ["Amount", _opt1 apply {str _x + " zombies"}, 1, true],
      ["Random radius", _opt2 apply {str _x + "m"}, 0, true]
  ]] call Ares_fnc_ShowChooseDialog;
  if (count _args == 0) exitWith {};

  _args params ["_c1", "_c2"];
  private _amount = _opt1 select _c1;
  private _radius = _opt2 select _c2;

  for "_i" from 1 to _amount do {
    private _z = [] call EFUNC(zombies,spawnZombie);
    if (!isNull _z) then {
      private _rpos = [_pos, _radius] call CBA_fnc_randPos;
      [_z, _rpos] call EFUNC(zombies,zombieInit);
    };
  };
}] call Ares_fnc_RegisterCustomModule;

[_cat, "Spawn horde", {
  params ["_pos"];

  private _opt1 = [5, 10, 15, 20];
  private _args = ["Spawn zombie horde", [
      ["Amount", _opt1 apply {str _x + " zombies"}, 0, true],
      ["Spawn yell", ["No", "Yes"], 0, true],
      ["Force spawn (ignore max zed)", ["No", "Yes"], 0, true]
  ]] call Ares_fnc_ShowChooseDialog;
  if (count _args == 0) exitWith {};

  _args params ["_c1", "_c2", "_c3"];
  private _amount = _opt1 select _c1;
  private _sound = [false, true] select _c2;
  private _ignoreMaxZombies = [false, true] select _c3;

  [_pos, _amount, _sound, _ignoreMaxZombies] call FUNC(spawnHorde);
}] call Ares_fnc_RegisterCustomModule;

true
