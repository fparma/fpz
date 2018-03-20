#include "script_component.hpp"

[QEGVAR(zombies,onZombieDeath), {
  params ["_zombie"];
  private _zone = _zombie getVariable [QGVAR(addBack), objNull];
  private _pos = _zombie getVariable [QGVAR(zonePos), []];

  if (!isNull _zone && {!(_pos isEqualTo [])}) then {
    (_zone getVariable [QGVAR(positions), []]) pushBack _pos;
    #ifdef DEBUG_MODE_FULL
      format ["%1%2",QGVAR(debugMrkPos), _pos] setMarkerColorLocal "ColorRed";
    #endif
  };
}] call CBA_fnc_addEventHandler;
