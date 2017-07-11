/*
	Runs for everyone
  !!! This script does not guarantee that 'player' is defined, initPlayerLocal does
	See: https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Initialization_Order
		for details about when the script is exactly executed.
*/

enableSaving [false,false];


// These are the recommended settings for view distance based on zombie distance spawning. 
// You can change them but remember to edit config.sqf if zombies are spawning within visible range
// The reason fog is set here is because then it won't take into account height
0 setFog 0.73;
setViewDistance 800;
setObjectViewDistance 600;

if (isServer) then {
  forceWeatherChange;
};

// Config should be set first
[] call compile preprocessFileLineNumbers "config.sqf";
// Start FPZ
[] call fpz_api_fnc_init;