#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(zones) = [];
GVAR(players) = [];
GVAR(zonePFH) = -1;

[QGVAR(registerLocalZone), {
  params [["_zone", objNull]];
  GVAR(zones) pushBack _zone;
}] call CBA_fnc_addEventHandler;
