#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(targets) = [];
GVAR(zombies) = [];

if (isServer) then {
  GVAR(headlessClients) = [];
  publicVariable QGVAR(headlessClients);
  [QGVAR(headlessClientJoined), {
    params ["_headlessClient"];
    GVAR(headlessClients) = GVAR(headlessClients) - [objNull];
    if (_headlessClient in GVAR(headlessClients)) exitWith {};
    GVAR(headlessClients) pushBack _headlessClient;
    publicVariable QGVAR(headlessClients);
  }] call CBA_fnc_addEventHandler;
};

ADDON = true;
