#ifndef HUBRIS_BLEND_DIFFERENCE
#define HUBRIS_BLEND_DIFFERENCE

namespace Hubris
{
    inline half3 Difference(half4 backdrop, half4 source)
    {
	    return abs(backdrop.rgb - source.rgb);
    }
}

#endif // HUBRIS_BLEND_DIFFERENCE