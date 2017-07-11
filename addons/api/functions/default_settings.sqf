#define SETTING(X,DEF) missionNamespace setVariable [QUOTE(X), missionNamespace getVariable [QUOTE(X), DEF]]

SETTING(fpz_maxAliveZombies,120);
SETTING(fpz_spawnDistanceMin,150);
SETTING(fpz_spawnDistanceMax,300);
SETTING(fpz_despawnDistance,400);
SETTING(fpz_maxChaseDistance,250);

SETTING(fpz_defaultDensity,40);
SETTING(fpz_aggroRangeInterval,[ARR_2(30,70)]);

SETTING(fpz_vehicleAggroMultiplier,2);
SETTING(fpz_showLootSparkle,true);
SETTING(fpz_rvgSounds,true);

if (isNil "fpz_zombieTypes") then {
  fpz_zombieTypes = [
    "zombie_walker", 0.5,
    "zombie_bolter", 0.25,
    "zombie_runner", 0.25
  ];
};

if (isNil "fpz_onZombieInit") then {
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
};
