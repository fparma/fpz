/**
* Reset animations
* Author: Haleks
*/

#include "script_component.hpp"
params ["_zed", "_anim"];

if ((getPosASL _zed) select 2 < -0.4) exitWith {
  if (_anim find "rvg_zed" > -1) then {
    _zed playMove "AmovPercMevaSnonWnonDf";
  };
};

if (_anim find "rvg_zed" isEqualTo -1) then {
  _zed playMove ("babe_rvg_zed_stand_" + typeOf _zed);
};
