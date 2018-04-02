#ifndef HUBRIS_COLOR_DESATURATE
#define HUBRIS_COLOR_DESATURATE
// REQUIRES
#include "Luminance.hlsl"

namespace Hubris
{
	inline half4 Desaturate(half4 color)
	{
		half luma = Luminance(color.rgb);
		return half4(half3(luma.xxx), color.a);
	}
}

#endif // HUBRIS_COLOR_DESATURATE