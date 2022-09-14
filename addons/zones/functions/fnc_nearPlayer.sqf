#include "script_component.hpp"
params ["_pos", "_range"];

(GVAR(players) inAreaArray [_pos, _range, _range, 0, false, -1]) isNotEqualTo []
