#include "script_component.hpp"

if (GVAR(zombies) isEqualTo []) exitWith {};

#ifdef DEBUG_MODE_FULL
  private _start = diag_tickTime;
#endif

private _z = GVAR(zombies) deleteAt 0;
if (!alive _z) exitWith {};

[_z] call FUNC(action);
GVAR(zombies) pushBack _z;

#ifdef DEBUG_MODE_FULL
  private _diff = diag_tickTime - _start;
  if (_diff > 0.1) then {
    TRACE_2("Long check", _z, _diff);
  };
#endif

nil
