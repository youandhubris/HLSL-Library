#ifndef HUBRIS_COLOR_CONVERT_HSV
#define HUBRIS_COLOR_CONVERT_HSV

namespace Hubris
{
	inline half4 RGB2HSV(half4 rgba)
	{
		half4 hsv = 0.0;
		half minVal = min(min(rgba.r, rgba.g), rgba.b);
		half maxVal = max(max(rgba.r, rgba.g), rgba.b);
		half delta = maxVal - minVal;             //Delta RGB value 
		hsv.z = maxVal;

		if (delta != 0) {                    // If gray, leave H & S at zero
			hsv.y = delta / maxVal;
			half3 delRGB;
			delRGB = (((maxVal.xxx - rgba) / 6.0) + (delta / 2.0)) / delta;
			if (rgba.x == maxVal) hsv.x = delRGB.z - delRGB.y;
			else if (rgba.y == maxVal) hsv.x = (1.0 / 3.0) + delRGB.x - delRGB.z;
			else if (rgba.z == maxVal) hsv.x = (2.0 / 3.0) + delRGB.y - delRGB.x;
			if (hsv.x < 0.0) { hsv.x += 1.0; }
			if (hsv.x > 1.0) { hsv.x -= 1.0; }
		}

		hsv.a = rgba.a;
		return hsv;
	}

	inline half4 HSV2RGB(half4 hsv)
	{
		half4 rgba = hsv.z;

		if (hsv.y != 0) {
			half var_h = hsv.x * 6;
			half var_i = floor(var_h);   // Or ... var_i = floor( var_h )
			half var_1 = hsv.z * (1.0 - hsv.y);
			half var_2 = hsv.z * (1.0 - hsv.y * (var_h - var_i));
			half var_3 = hsv.z * (1.0 - hsv.y * (1 - (var_h - var_i)));
			if (var_i == 0) { rgba.rgb = half3(hsv.z, var_3, var_1); }
			else if (var_i == 1) { rgba.rgb = half3(var_2, hsv.z, var_1); }
			else if (var_i == 2) { rgba.rgb = half3(var_1, hsv.z, var_3); }
			else if (var_i == 3) { rgba.rgb = half3(var_1, var_2, hsv.z); }
			else if (var_i == 4) { rgba.rgb = half3(var_3, var_1, hsv.z); }
			else { rgba.rgb = half3(hsv.z, var_1, var_2); }
		}

		rgba.a = hsv.a;
		return rgba;
	}
}

#endif // HUBRIS_COLOR_CONVERT_HSV