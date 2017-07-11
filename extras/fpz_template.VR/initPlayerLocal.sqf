/*
	Executed locally when player joins mission (includes both mission start and JIP).
  This script guarantees that player object exists. Init.sqf does not
	See: https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Initialization_Order
		for details about when the script is exactly executed.
*/


if (hasInterface) then {
	
	// Cloud based fog settings near player
	[
	  player, // unit to follow
	  100, // max dist
	  11, // min dist
	  10, // cloud count
	  3, // min size of cloud
	  7, // max size of cloud
	  -0.3, // height of clouds atl
	  0.1, // respawn time of cloud
	  0.4, // transparency
	  0.9,0.9,1, // color 
	  13, //  remove speed of cloud
	  12, // min life time
	  15, //  max life time
	  false, //  ENABLE clouds affected by wind
	  0.3, //  wind: strength (requires ENABLE)
	  2.1, // wind: random dir period (requires ENABLE)
	  0.1, // wind: random dir intensity (requires ENABLE)
	  0,0.2,0.1, // wind: XYZ movement. ENABLE have to be false
	  0, // start clouds day time
	  24 // end clouds daytime
	] call fpz_api_fnc_fog;
};