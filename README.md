# FP Zombies

Zombie addon for FPARMA missions

This is not working without not-included dependencies, sorry

### For mission makers
Use the template provided in releases. Edit config.sqf

Check out the mission and look at the comments to see how things work

### Zones

Put down a zone and enter "true" as the condition (nothing else required)
and put the following into activation field

[thisTrigger, AMOUNT] call fpz_api_fnc_registerZone;

Zombies will spawn within the trigger area once players are near, maximum the amount provided
Once a zombie is killed, the amount gets decremented and can not respawn (don't delete them with zeus)

There's two more parameters, if needed
[thisTrigger, AMOUNT, ACTIVATE DISTANCE, RADIUS] call fpz_api_fnc_registerZone;
ACTIVATE DISTANCE = when the object should activate and start trying to spawn
RADIUS = how large of an area. useful when using other objects than a trigger
Is default the max of X/ size

### How to spawn hordes
Same thing, put down a trigger but this time you can choose the activation type, either when some variable is set or some more complex condition.
Any player present works aswell ofc.

In the activation you enter

`[thisTrigger, <AMOUNT>] call fpz_api_fnc_spawnHorde;`

Horde will spawn randomly throughout the trigger. It doesn't have to be a trigger but it's recommended for that reason

Additionally, there's two more parameters:
`[thisTrigger, <AMOUNT>, <PLAY SOUND>, <IGNORE MAX ZOMBIES>] call fpz_api_fnc_spawnHorde;`

### Using in other mission
If you're not using the template, fpz can be initialized using

In debug console local exec:
`[] remoteExecCall ["fpz_api_fnc_init", 0, "fpz_init"];`
