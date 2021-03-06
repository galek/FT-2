_vehicle = _this;

_flares_last_time = _vehicle getVariable "flareslasttime";
_flares_left      = _vehicle getVariable "flaresleft";

if ((time > _flares_last_time) && (_flares_left > 0)) then
{
	_flares_left = _flares_left - 1;

	_vehicle setVariable ["flareslasttime", time + 3];
	_vehicle setVariable ["flaresleft",     _flares_left];

	_vehicle vehicleChat format [localize "STR_MES_FlaresLaunched", _flares_left];

	_vec = vectordir _vehicle;
	_flares=[];
	_emmiters=[];
	_launchercount=0;

	_muzzzlevel=GetNumber (configFile >> "CfgVehicles" >> typeof _vehicle >> "flareVelocity");

	_min = ((boundingbox _vehicle) select 0) select 2;

	//Count up memory points
	_manual=false;
	_launchercount=0;
	while {([0,0,0] distance (_vehicle selectionposition (format ["flare_launcher%1",_launchercount+1]))) != 0} do
	{
		_launchercount=_launchercount+1;
	};

	if (_launchercount==0) then {_launchercount=1;_manual=true};

	_l=4+(random 4);
	for [{_k=0}, {_k<=_l}, {_k=_k+1}] do
	{
		_vel=velocity _vehicle;
		for "_i" from 1 to (_launchercount) do
		{
			playSound3D ["A3\Sounds_F\weapons\HMG\HMG_grenade.wss", _vehicle];
		
			_relpos=if (_manual) then {_vehicle modelToWorld [0, -3, -2]} else {_vehicle modelToWorld (_vehicle selectionposition format["flare_launcher%1",_i])};
			_dirpos=if (_manual) then {_vehicle modelToWorld [0, -4, -2.5]} else {_vehicle modelToWorld (_vehicle selectionposition format["flare_launcher%1_dir",_i])};

			_flare="CMflare_Chaff_Ammo" createVehicle _relpos;

			_dirpos=[(_dirpos select 0) - (_relpos select 0),(_dirpos select 1) - (_relpos select 1),(_dirpos select 2) - (_relpos select 2)];

			//Calculate vehocity to launch flare at
			_div=abs(_dirpos select 0)+abs(_dirpos select 1)+abs(_dirpos select 2);
			_flarevel=[(_dirpos select 0)/_div*_muzzzlevel*(0.9+(random 0.1)),(_dirpos select 1)/_div*_muzzzlevel*(0.9+(random 0.1)),(_dirpos select 2)/_div*_muzzzlevel];
			_vvel=velocity _vehicle;


			_flare setvelocity [(_flarevel select 0) + (_vvel select 0),(_flarevel select 1) + (_vvel select 1),(_flarevel select 2) + (_vvel select 2)];
			_flares=_flares+[_flare];

			_sm = "#particlesource" createVehicleLocal getpos _flare;
			_sm setParticleRandom [0.5, [0.3, 0.3, 0.3], [0.5, 0.5, 0.5], 0, 0.3, [0, 0, 0, 0], 0, 0,360];
			/*_sm setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8,0],
					"", "Billboard", 1, 3, [0, 0, 0],
					[0,0,0], 1, 1, 0.80, 0.5, [1.3,4],
					[[0.9,0.9,0.9,0.6], [1,1,1,0.3], [1,1,1,0]],[1],0.1,0.1,"","",_flare];*/
			_sm setdropinterval 0.02;

			_sp = "#particlesource" createVehicleLocal getpos _flare;
			_sp setParticleRandom [0.03, [0.3, 0.3, 0.3], [1, 1, 1], 0, 0.2, [0, 0, 0, 0], 0, 0,360];
			/*_sp setParticleParams [["\ca\Data\ParticleEffects\Universal\Universal", 16, 13, 2,0],
					"", "Billboard", 1, 0.1, [0, 0, 0],
					[0,0,0], 1, 1, 0.80, 0.5, [1.5,0],
					[[1,1,1,-4], [1,1,1,-4], [1,1,1,-2],[1,1,1,0]],[1000],0.1,0.1,"","",_flare,360];*/
			_sp setdropinterval 0.001;

			_li = "#lightpoint" createVehicleLocal getpos _flare;
			_li setLightBrightness 0.1;
			_li setLightAmbient[0.8, 0.6, 0.2];
			_li setLightColor[1, 0.5, 0.2];
			_li lightAttachObject [_flare, [0,0,0]];

			_emmiters=_emmiters+[_sm,_sp,_li];
		};
		sleep 0.2;
	};

	[
	{
		sleep 4.5 + random 1;
		{deletevehicle _x} foreach _this;
	},
	(_emmiters + _flares)] call Func_Common_Spawn;
}
else
{
	if (0 == _flares_left) then
	{
		_vehicle vehicleChat localize "STR_MES_FlaresEmpty"; 
		playSound "error_sound";
	};
};

