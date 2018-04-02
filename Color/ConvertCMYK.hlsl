#ifndef HUBRIS_COLOR_CONVERT_CMYK
#define HUBRIS_COLOR_CONVERT_CMYK
// REFERENCE
// https://www.easyrgb.com/en/math.php

namespace Hubris
{
	inline half3 RGB2CMY(half3 rgb)
	{
		return 1.0 - rgb;
	}

	inline half3 CMY2RGB(half3 cmy)
	{
		return 1.0 - cmy;
	}

	inline half4 CMY2CMYK(half3 cmy)
	{
		half4 cmyk;

		cmyk.w = min(min(cmy.x, cmy.y), cmy.z);
        cmyk.xyz = cmyk.w == 1.0 ? 0.0 : (cmy - cmyk.w) / (1.0 - cmyk.w);

		return cmyk;
	}

	inline half4 RGB2CMYK(half3 rgb)
	{
		half3 cmy = RGB2CMY(rgb);
		return CMY2CMYK(cmy);
	}

	inline half3 CMYK2RGB(half4 cmyk)
	{
		half3 cmy = cmyk.xyz * (1.0 - cmyk.w) + cmyk.w;
		return CMY2RGB(cmy);
	}
}

#endif // HUBRIS_COLOR_CONVERT_CMYK