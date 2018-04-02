#ifndef HUBRIS_BLEND_HUE
#define HUBRIS_BLEND_HUE
// REQUIRES
#include "../Color/ConvertHSV.hlsl"

namespace Hubris
{
    inline half3 Hue(half4 backdrop, half4 source)
    {
	    half3 mix = RGB2HSV(backdrop).rgb;
	    mix.r = RGB2HSV(source).r;
	    return HSV2RGB(half4(mix, 1.0));
    }
}

#endif // HUBRIS_BLEND_HUE