
class RscVehicles {
	movingEnable = 1;
	idd = -1;
	onLoad = "[Func_Dialog_HandleVehiclesDialog, _this] call Func_Common_Spawn";
	onUnload = "";

	class controlsBackground {

		class Mainback: RscText {
			colorBackground[] = {0, 0, 0, 0.700000};
			idc = -1;
			x =-0.15;
			y =-0.20;
			w = 1.30;
			h = 1.40;
		};
	};
	class controls {
		//--- ArmA 2 WF Gear Menu Modified.
		class FilterButtonCars : RscClickableText_ext {
			idc = 3700;
			style = 48 + 0x800;
			x =-0.13;
			y =-0.12;
			w = 0.10;
			h = 0.09;
			color[] = {1, 1, 1, 1};
			colorActive[] = {0.7,1,0.7,1};
			text = "\A3\ui_f\data\map\vehicleicons\iconCar_ca.paa";
			action = "Dialog_VehicleFiller='car'";
		};
		class FilterButtonArmor : FilterButtonCars {
			idc = 3701;
			x =-0.04;
			text = "\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa";
			action = "Dialog_VehicleFiller='armor'";
		};
		class FilterButtonHeli : FilterButtonCars {
			idc = 3702;
			x = 0.05;
			text = "\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa";
			action = "Dialog_VehicleFiller='heli'";
		};
		class FilterButtonAir : FilterButtonCars {
			idc = 3703;
			x = 0.14;
			text = "\A3\ui_f\data\map\vehicleicons\iconPlane_ca.paa";
			action = "Dialog_VehicleFiller='air'";
		};
		class FilterButtonShip : FilterButtonCars {
			idc = 3711;
			x = 0.23;
			text = "\A3\ui_f\data\map\vehicleicons\iconShip_ca.paa";
			action = "Dialog_VehicleFiller='ship'";
		};
		class FilterButtonSupport : FilterButtonCars {
			idc = 3704;
			x = 0.32;
			text = "\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa";
			action = "Dialog_VehicleFiller='support'";
		};

		class BuyButton : RscShortcutButton {
			idc = 3710;
			x =-0.14;
			y = 1.12;
			w = 0.20;
			h = 0.06;
			text = $STR_WF_Purchase;
			action = "Dialog_VehicleActionSE='buy'";
		};
		class CloseButton : BuyButton {
			idc = 3705;
			x = 0.3;
			text = $STR_WF_Close;
			action = "closeDialog 0";
		};
		class CA_Money_Value : RscText_ext {
			idc = 3706;
			x =-0.13;
			y = 1.05;
			SizeEx = 0.04;
			text = "";
			colorText[] = {0.7,1,0.7,1};
		};
		class Gear_Title : CA_Money_Value {
			idc = 3707;
			x =-0.14;
			y =-0.20;
			text = $STR_WF_Vehicles_Label;
		};
		class MainList : RscListBoxA_ext {
			idc = 3708;
			columns[] = {0.01, 0.25};
			drawSideArrows = 0;
			idcRight = -1;
			idcLeft = -1;
			x =-0.15;
			y = 0.00;
			w = 0.65;
			h = 1.00;

			sizeEx = 0.035;

			onLBSelChanged = "Dialog_VehicleLbChange=true";
		};
		class SecondaryList: RscStructuredText_ext {
			idc = 3709;
			x = 0.50;
			y = 0.00;
			w = 0.65;
			h = 1.00;

			size = 0.06;
		};
	};
};
