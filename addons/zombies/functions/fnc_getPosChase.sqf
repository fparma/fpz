/**
* Get a proper position for "chasing" with planning mode
*
* If position is water, zombie won't move with LEADER PLANNED (going up from water is fine?)
* If it is water, zombie is forced to walk when LEADER DIRECT is the planning mode.
* Zombie also ignores collision with LEADER DIRECT (or it's very rough)
* What we're doing is to try and move the zombie closer to the target a few meters and when "maybe" at the shore,
* put them into LEADER DIRECT so that they can swim.
*
* TODO: if attacking vehicle (mostly helicopters), move closer without going through
* They seem unable to move within the boundingbox, which includes rotors
*/

#include "script_component.hpp"
params ["_zombie", "_victim"];

private _planningMode = "LEADER PLANNED";
private _pos = getPosATL vehicle _victim;
private _zPos = _pos param [2, 0];

if (surfaceIsWater _pos) then {
  private _posCloser = _zombie getPos [8, _zombie getDir _victim];
  if (surfaceIsWater _posCloser) then {_planningMode = "LEADER DIRECT"} else {_pos = _posCloser};
} else {
  // if not "above" ground (building) try to move position in moving direction
  if (_zPos < 1) then {
    if (abs speed _victim > 4) then {
      velocity _victim params ["_velX", "_velD"];
      private _dir = (_velX atan2 _velD) - getDir _victim;
      _pos = _victim getRelPos [3 + random 2, _dir];
    };
  };
  // randomize position to not have zombie stuck attacking vehicles
  private _randPos = _pos getPos [[1 + random 2, 0.8] select (isNull objectParent _victim), random 360];
  _pos = [_randPos select 0, _randPos select 1, _zPos];
};

[_pos, _planningMode]
