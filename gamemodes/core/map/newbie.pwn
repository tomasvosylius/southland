#include <YSI\y_hooks>

hook OnGameModeInit()
{
	new obj = CreateObject(19548, -5608.59766, 1553.84509, -3.68236,   0.00000, 0.00000, -169.49994, 600.0);
	SetObjectMaterial(obj, 0, 6281, "santamonicalaw2", "sandnew_law", 0xFFFFFFFF); // arba 0, 16102, "des_cen", "sandgrnd128", 0xFFFFFFFF);
	CreateObject(16115, -5599.72900, 1546.59290, 7.58939,   -2.10000, -11.40000, 59.64001, 600.0);
	CreateDynamicObject(622, -5583.91357, 1529.52417, 5.12383,   0.00000, 0.00000, -40.08003, -1, -1, -1, 600.0, 600.0);
	CreateDynamicObject(622, -5585.39502, 1527.65759, 5.12383,   0.00000, 0.00000, -375.00006, -1, -1, -1, 600.0, 600.0);
	CreateDynamicObject(620, -5582.92871, 1526.78711, 2.06576,   0.00000, 0.00000, 0.00000, -1, -1, -1, 600.0, 600.0);
}