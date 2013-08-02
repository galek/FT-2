
_air       = _this select 0;
_ammotype  = _this select 1;
_antiair   = _this select 2;
_aawarning = _this select 3;

if ((_aawarning) && (local _air)) then
{
	_ammo = nearestObject [_antiair, _ammotype];

	_attacker_distance = _ammo distance _air;
	_activate_distance = 300;

	_flares_left = _air getVariable "flaresleft";
	
	//--send _air crew a warning message
	["message_incoming_missile", "air", crew _air] call Func_Common_SendRemoteCommand;
	//--end

	_auto_flares = !(_air getVariable 'manualflare');

	//--find missile class and some missile data
	_aa_vehicle_chance = 1;
	{
		_aa_vehicle_desc = _x;
			_aa_vehicle_name = _aa_vehicle_desc select 0;

		if (_antiair isKindOf _aa_vehicle_name) exitWith
		{
			_aa_vehicle_chance = _aa_vehicle_desc select 1;
		};
	} forEach System_AntiAirVehicleTypes;

	_allow_hit = System_AntiAirMissileChances select (System_AntiAirMissileTypes find _ammotype);

	if (_allow_hit) then
	{
		if (_attacker_distance < _activate_distance) then
		{
			_aa_vehicle_chance = 1;
		};
	}
	else
	{
		_aa_vehicle_chance = 0;
	};

	//--end

	waitUntil{((_ammo distance _air) < _activate_distance) || (isNull _ammo)};
	if !(isNull _ammo) then
	{
		if (_auto_flares) then
		{
			if (_flares_left > 0) then
			{
				_air vehicleChat format [localize "STR_MES_FlaresLaunched", _flares_left - 1];
				_air spawn Func_System_DropFlares;
				_air setVariable ["flaresleft", _flares_left - 1, true];
			};
		};

		waitUntil{((_ammo distance _air) < (_activate_distance / 2)) || (isNull _ammo)};
		if !(isNull _ammo) then
		{
			_sparks_count = count ((getPos _air) nearObjects["CMflare_Chaff_Ammo", 100]);

			if (_sparks_count != 0) then
			{
				_missile_missed = ((random 1) > _aa_vehicle_chance);
				if (_missile_missed) then
				{
					deleteVehicle _ammo;
				};
			};
		};
	};
};
