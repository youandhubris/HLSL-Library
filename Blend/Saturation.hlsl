#ifndef HUBRIS_BLEND_SATURATION
#define HUBRIS_BLEND_SATURATION
// REQUIRES
#include "../Color/ConvertHSV.hlsl"

namespace Hubris
{
    inline half3 Saturation(half4 backdrop, half4 source)
    {
	    half3 mix = RGB2HSV(backdrop).rgb;
	    mix.g = RGB2HSV(source).g;
	    return HSV2RGB(half4(mix, 1.0));
    }
}

#endif // HUBRIS_BLEND_SATURATION