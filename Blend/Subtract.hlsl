#ifndef HUBRIS_BLEND_SUBTRACT
#define HUBRIS_BLEND_SUBTRACT

namespace Hubris
{
    inline half3 Subtract(half4 backdrop, half4 source)
    {
	    return backdrop.rgb - source.rgb;
    }
}

#endif // HUBRIS_BLEND_SUBTRACT