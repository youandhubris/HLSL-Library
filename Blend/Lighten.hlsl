#ifndef HUBRIS_BLEND_LIGHTEN
#define HUBRIS_BLEND_LIGHTEN

namespace Hubris
{
    inline half3 Lighten(half4 backdrop, half4 source)
    {
	    return max(backdrop.rgb, source.rgb);
    }
}

#endif // HUBRIS_BLEND_LIGHTEN