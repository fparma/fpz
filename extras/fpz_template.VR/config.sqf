// This file can be used to change any configuration for FPZ
// The below settings are the default ones
// Do note that changing spawn distance might require changes to zombie zones, with a custom activation distance

/*
fpz_maxAliveZombies = 120; // the maxium allowed amount of alive zombies
fpz_spawnDistanceMin = 150; // Zombies can not spawn closer than this
fpz_spawnDistanceMax = 300; // Zombies can not spawn further away than this
fpz_despawnDistance = fpz_spawnDistanceMax + 150; // Range when zombies are deleted
fpz_defaultDensity = 40; // the default amount of zombies for any registered zone

fpz_maxChaseDistance = 250; // chase distance before giving up. horde ignores this. never lower than max aggro range
fpz_aggroRangeInterval = [30, 70]; // min, max. stance will further affect this aggro range (lower = less)
fpz_vehicleAggroMultiplier = 2; // Vehicles with their engine on will multiply above random aggro
fpz_zombieDamageMultiplier = 1; // zombie damage multiplier. 0 = cannot be killed. 0.5 makes them almost impossible to kill with bodyshots from a pistol
fpz_showLootSparkle = true; // show sparkle on zombie corpses that have weapons, magazines, items
fpz_rvgSounds = true; // use ravage sounds. set to false to use celery's

// Ambient zombie types to spawn for registrered zones. [type, percentage]
fpz_zombieTypes = [
	"zombie_walker", 0.5,
	"zombie_bolter", 0.25,
	"zombie_runner", 0.25
];

// This can be used to give zombies random items, uniforms etc
fpz_onZombieInit = {
	params ["_zombie", "_pos"];

	_zombie forceAddUniform selectRandom [
	  "U_I_G_Story_Protagonist_F",
	  "U_C_Poor_1",
	  "U_C_Poor_2",
	  "U_C_WorkerCoveralls",
	  "U_Rangemaster",
	  "U_OrestesBody",
	  "U_C_HunterBody_grn",
	  "U_BG_leader",
	  "U_BG_Guerilla3_1",
	  "U_BG_Guerilla2_3",
	  "U_BG_Guerilla2_1",
	  "U_BG_Guerilla2_2",
	  "U_BG_Guerilla1_1",
	  "U_C_Poloshirt_salmon",
	  "U_C_Poloshirt_blue",
	  "U_BG_Guerrilla_6_1",

	  // apex
	  "U_I_C_Soldier_Bandit_4_F",
	  "U_I_C_Soldier_Bandit_1_F",
	  "U_I_C_Soldier_Bandit_2_F",
	  "U_I_C_Soldier_Bandit_5_F",
	  "U_I_C_Soldier_Bandit_3_F",
	  "U_I_C_Soldier_Para_5_F",
	  "U_I_C_Soldier_Para_4_F",
	  "U_I_C_Soldier_Para_1_F",
	  "U_C_Man_casual_4_F",
	  "U_C_Man_casual_5_F"
	];
};
*/
