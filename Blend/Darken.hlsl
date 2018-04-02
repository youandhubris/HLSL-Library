#ifndef HUBRIS_BLEND_DARKEN
#define HUBRIS_BLEND_DARKEN

namespace Hubris
{
    inline half3 Darken(half4 backdrop, half4 source)
    {
	    return min(backdrop.rgb, source.rgb);
    }
}

#endif // HUBRIS_BLEND_DARKEN