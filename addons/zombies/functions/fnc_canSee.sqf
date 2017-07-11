/**
* Check if zombie can see target
*/

#include "script_component.hpp"
params ["_zombie", "_target", "_range"];

if (isNull objectParent _target) exitWith {
  private _dist = _zombie distance _target;

  if ([_zombie, _target] call BIS_fnc_isInFrontOf) then {
    _target isFlashlightOn (currentWeapon _target) ||
    {
      private _targetEyepos = eyepos _target;
      private _visibleRange = switch (stance _target) do {
         case "CROUCH": {_range * 0.75};
         case "PRONE": {_range * 0.4};
         default {_range};
      };

      _dist < _visibleRange &&
      {_targetEyepos select 2 > -0.2} &&
      {[_zombie, "IFIRE", _target] checkVisibility [eyepos _zombie, _targetEyepos] > 0.2};
    };
  } else {
    (abs (speed _target) > 6 && _dist < 6);
  };
};

isEngineOn (vehicle _target) || {[_zombie, vehicle _target] call BIS_fnc_isInFrontOf}
