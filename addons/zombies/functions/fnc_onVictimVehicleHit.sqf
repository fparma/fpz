/**
* Runs when a vehicle is hit
* Based on ACE3 repair setHitPointDamage, all creds to commy2/ace team
* TODO: maybe move all the code here since not public functions and skip some of the loops
*/

#include "script_component.hpp"
params ["_zombie", "_target"];
private _veh = vehicle _target;
if (!alive _veh) exitWith {};

private _getAllHp = getAllHitPointsDamage _veh;
if (!(_getAllHp isEqualTo [])) then {
  _getAllHp params [["_allHitPoints", []], ["_allHitPointsSelections", []], ["_allHitPointDamages", []]];
  private _prefer = [];
  private _rest = [];

  {
    private _sel = tolower (_allHitPointsSelections select _forEachIndex);
    if ((!isNil {_veh getHit _sel}) && {_x != ""}) then {
      if (!(isText (configFile >> "CfgVehicles" >> typeOf _veh >> "HitPoints" >> _x >> "depends"))) then {
        if (_x find "wheel" > -1 || {_x find "glass" > -1} || {_x find "track" > -1}) then {
          _prefer pushBack _forEachIndex;
        } else {
          _rest pushBack _forEachIndex;
        };
      };
    };
  } forEach _allHitPoints;

  private _idx = if (count _prefer > 0 && {count _rest > 0}) then {
    [_prefer, 0.65, _rest, 0.35] call BIS_fnc_selectRandomWeighted;
  } else {
    selectRandom (_prefer + _rest);
  };

  private _hitpoint = _allHitPoints select _idx;
  private _currDmg = _veh getHitIndex _idx;
  private _dmg =  _currDmg + 0.1 + random .2;
  if (_hitpoint isEqualTo "hitengine" || {_veh isKindOf "Tank"}) then {_dmg = _currDmg + 0.04};
  if (_hitpoint find "glass" > -1) then {_dmg = 1};
  private _max = [1, 0.89] select (_hitpoint in ["hithull", "hitfuel"]);
  if (_dmg > _max) then {_dmg = _max};

  TRACE_2("Vehicle hit", _hitpoint, _dmg);
  [_veh, _idx, _dmg] call ace_repair_fnc_setHitPointDamage;
} else {
  _veh setDamage (damage _veh + (0.05 + random 0.1));
};

// shake vehicle. stronk zombie
private _vel = velocity _veh;
private _dir = _zombie getDir _veh;
private _speed = 0.5 + (random ([0.5, 1] select (_veh isKindOf "Car")));

_veh setVelocity [
 (_vel select 0) + (sin _dir * _speed),
 (_vel select 1) + (cos _dir * _speed),
 (_vel select 2) + 0.5 + random 1
];

// hit unit if open vehicle
if (speed _veh < 18 &&
  {toLower (getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "attenuationEffectType")) find "open" > -1} &&
  {random 1 > 0.4}) then
{
  private _dist = 100;
  private _closest = objNull;
  {
    private _d = _x distance _zombie;
    if (_x distance _zombie < _dist) then {
      _closest = _x;
      _dist = _d;
    };
  } forEach crew _veh;

  if (!isNull _closest) then {
    [QGVAR(onAttack), [_zombie, _closest], _closest] call CBA_fnc_targetEvent;
  };
};
