/*
* Play sound on zombie death
*/
#include "script_component.hpp"
params ["_zombie"];

#ifdef DEBUG_MODE_FULL
  deleteVehicle (_zombie getVariable [QGVAR(debugArrow), objNull]);
#endif

if (random 1 > 0.6) then {
  playSound3d [format ["rvg_zeds\sounds\die%1.ogg", 1 + floor random 2], _zombie];
};
