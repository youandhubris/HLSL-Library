#ifndef HUBRIS_COLOR_SHIFTHSV
#define HUBRIS_COLOR_SHIFTHSV
// REQUIRES
#include "ConvertHSV.hlsl"
#include "Desaturate.hlsl"

/*
-------------------------------------------------------
CHANGE HSV OF A RGBA
-------------------------------------------------------
_Hue ("Hue", Range(-0.4995, 0.4995)) = 0.0
_Saturation ("Saturation", Range(0.0, 1.0)) = 1.0
_Brightness ("Brightness", Range(-1.0, 1.0)) = 0.0
-------------------------------------------------------
*/

namespace Hubris
{
	
	inline half4 ShiftHSV(half4 color, half hue, half saturation, half value)
	{
		half4 output = RGB2HSV(color);

		// HUE
		output.r += hue;
		if (output.r > 0.999) output.r -= 0.999;
		if (output.r < 0.0 - output.r) output.r += 0.999;

		// VALUE
		output.b = clamp(output.b + value, 0.0, 1.0);

		// SATURATION
		output = HSV2RGB(output);
		output = lerp(Desaturate(output), output, saturation);

		output.a = color.a;
		return output;
	}
}

#endif // HUBRIS_COLOR_SHIFTHSV