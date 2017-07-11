#include "script_component.hpp"
params [
  ["_zone", objNull, [objNull]],
  ["_amount", fpz_defaultDensity, [0]],
  ["_activateDistance", -1, [0]],
  ["_radius", -1, [0]]
];

if (_radius isEqualTo -1) then {
  private _tr = triggerArea _zone;
  _radius = (_tr select 0) max (_tr select 1);
};

if (_activateDistance isEqualTo -1) then {
  _activateDistance = sqrt(_radius ^ 2 * 2);
};
_activateDistance = _activateDistance max fpz_spawnDistanceMax;

_zone setVariable [QEGVAR(zones,amount), abs round _amount];
_zone setVariable [QEGVAR(zones,radius), abs round _radius];
_zone setVariable [QEGVAR(zones,activateDistance), abs round _activateDistance];
_zone setVariable [QEGVAR(zones,zombies), []];

TRACE_4("Registering zone",_zone, abs round _amount, abs round _radius, abs round _activateDistance);
EGVAR(zones,zones) pushBackUnique _zone;
