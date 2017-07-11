/**
* Alert nearby zombies when firing
* Loudness code borrowed from ACE hearing
*/

#include "script_component.hpp"
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (_weapon in ["Throw", "Put"] || {_unit getVariable [QGVAR(ignore), false]}) exitWith {};

if (CBA_missionTime < _unit getVariable [QGVAR(firedTimeout), 0]) exitWith {};
_unit setVariable [QGVAR(firedTimeout), CBA_missionTime + 3];

private _silencer = switch (_weapon) do {
    case (primaryWeapon _unit) : {(primaryWeaponItems _unit) select 0};
    case (secondaryWeapon _unit) : {(secondaryWeaponItems _unit) select 0};
    case (handgunWeapon _unit) : {(handgunItems _unit) select 0};
    default {""};
};

private _audible = 1;
if (_silencer != "") then {
  _audible = getNumber (configFile >> "CfgWeapons" >> _silencer >> "ItemInfo" >> "AmmoCoef" >> "audibleFire");
};

private _initSpeed = getNumber(configFile >> "CfgMagazines" >> _magazine >> "initSpeed");
private _caliber = getNumber (configFile >> "CfgAmmo" >> _ammo >> "ACE_caliber");
_caliber = call {
  // If explicilty defined, use ACE_caliber
  if ((count configProperties [(configFile >> "CfgAmmo" >> _ammo), "configName _x == 'ACE_caliber'", false]) == 1) exitWith {_caliber};
  if (_ammo isKindOf ["ShellBase", (configFile >> "CfgAmmo")]) exitWith { 80 };
  if (_ammo isKindOf ["RocketBase", (configFile >> "CfgAmmo")]) exitWith { 200 };
  if (_ammo isKindOf ["MissileBase", (configFile >> "CfgAmmo")]) exitWith { 600 };
  if (_ammo isKindOf ["SubmunitionBase", (configFile >> "CfgAmmo")]) exitWith { 800 };
  if (_caliber <= 0) then { 6.5 } else { _caliber };
};

private _loudness = _audible * (_caliber ^ 1.25 / 10) * (_initSpeed / 1000);
private _distance = ((_loudness * (_initSpeed / 10) * _caliber) / 4);
private _list = _unit nearEntities ["zombie", _distance];

TRACE_3("Fired man", _weapon, _distance, count _list);
{
  if (local _x && {isNull (_x getVariable [QGVAR(victim), objNull])}) then {
    _x setVariable [QGVAR(victim), _unit];
    _x setVariable [QGVAR(victimChangeTimeout), CBA_missionTime + 6 + random 8];
  };
} forEach (_list select {random 1 > 0.2});
