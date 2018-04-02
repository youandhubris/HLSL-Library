#ifndef HUBRIS_BLEND_COLOR
#define HUBRIS_BLEND_COLOR
// REQUIRES
#include "../Color/ConvertHSV.hlsl"

namespace Hubris
{
    inline half3 Color(half4 backdrop, half4 source)
    {
	    half3 mix = RGB2HSV(source).rgb;
	    mix.b = RGB2HSV(backdrop).b;
	    return HSV2RGB(half4(mix, 1.0));
    }
}

#endif // HUBRIS_BLEND_COLOR