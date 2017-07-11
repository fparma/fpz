/**
* Attacks a target
*/

#include "script_component.hpp"
params ["_zombie", "_target"];

private _veh = vehicle _target;
(getPosATL _zombie) params ["_zxPos", "_zyPos"];
(getPosATL _veh) params ["_vxPos", "_vyPos"];
_zombie setVectorDir [_vxPos - _zxPos, _vyPos - _zyPos, 0];

_zombie playActionNow selectRandom ["babe_rvg_zeds_att1", "babe_rvg_zeds_att2", "babe_rvg_zeds_att3", "babe_rvg_zeds_att4"];
_zombie setVariable [QGVAR(attackWait), CBA_missionTime + 2.4];
_zombie setVariable [QGVAR(chaseSoundWait), CBA_missionTime + 8];

private _sound = ["attack"] call FUNC(getSound);
[_zombie, _sound] remoteExecCall ["say3D"];

[{
  if ({alive _x} count _this < 3)  exitWith {};
  params ["_zombie", "_target", "_veh"];
  TRACE_1("Attack pveh", _victim);
  if (_veh isEqualTo _target) then {
    [QGVAR(onAttack), [_zombie, _target], _target] call CBA_fnc_targetEvent;
  } else {
    [QGVAR(onVehicleAttack), [_zombie, _target], _veh] call CBA_fnc_targetEvent;
  };
}, [_zombie, _target, _veh], 0.4] call CBA_fnc_waitAndExecute;
