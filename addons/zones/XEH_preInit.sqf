#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(zones) = [];

[QGVAR(registerLocalZone), {
  params [["_zone", objNull]];
  GVAR(zones) pushBack _zone;
}] call CBA_fnc_addEventHandler;

[QGVAR(lowerWeapons), "onPreloadFinished", {
  player switchmove (switch (currentWeapon player) do {
    case primaryWeapon player: {"amovpercmstpslowwrfldnon"};
    case handgunWeapon player: {"amovpercmstpslowwpstdnon"};
    default {""};
  });
  [QGVAR(lowerWeapons), "onPreloadFinished"] call BIS_fnc_removeStackedEventHandler;
}] call BIS_fnc_addStackedEventHandler;
