#include "script_component.hpp"

if (RETDEF(GVAR(initialized),false)) exitWith {false};
GVAR(initialized) = true;

#include "default_settings.sqf"

[] call FUNC(attachAresFunctions);

[EFUNC(zombies,zombiePfh), 0] call CBA_fnc_addPerFrameHandler;
[{
  EGVAR(zombies,targets) = allUnits select {_x call EFUNC(zombies,isValidVictim)};
}, 1] call CBA_fnc_addPerFrameHandler;

if (hasInterface) then {
  if (fpz_showLootSparkle) then {
    [EFUNC(zombies,lootSparklePfh), 0.5] call CBA_fnc_addPerFrameHandler;
  };
  ["ace_firedPlayer", {_this call EFUNC(zombies,fired)}] call CBA_fnc_addEventHandler;
  ["ace_firedPlayerVehicle", {_this call EFUNC(zombies,firedVehicle)}] call CBA_fnc_addEventHandler;
};

["ace_firedPlayerNonLocal", {_this call EFUNC(zombies,fired)}] call CBA_fnc_addEventHandler;
["ace_firedNonPlayer", {_this call EFUNC(zombies,fired)}] call CBA_fnc_addEventHandler;
["ace_firedPlayerVehicleNonLocal", {_this call EFUNC(zombies,firedVehicle)}] call CBA_fnc_addEventHandler;
["ace_firedNonPlayerVehicle", {_this call EFUNC(zombies,firedVehicle)}] call CBA_fnc_addEventHandler;

// TODO: HC support
if (isServer) then {
    [{
      EGVAR(zones,players) = allPlayers select {
        alive _x &&
        {!(_x isKindOf "VirtualMan_F")} &&
        {!(_x getVariable [QEGVAR(zombies,ignore), false])} &&
        {simulationEnabled _x}
      };
    }, 2] call CBA_fnc_addPerFrameHandler;

    [EFUNC(zones,zonePfh), 0.03] call CBA_fnc_addPerFrameHandler;
};

true


