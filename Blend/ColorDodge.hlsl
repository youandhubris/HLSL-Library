#ifndef HUBRIS_BLEND_COLORDODGE
#define HUBRIS_BLEND_COLORDODGE

namespace Hubris
{
    inline half3 ColorDodge(half4 backdrop, half4 source)
    {
	    if (backdrop.r == 0.0 && backdrop.g == 0.0 && backdrop.b == 0.0) return 0.0;
	    else if (source.r == 1.0 && source.g == 1.0 && source.b == 1.0) return 1.0;
	    else return min(1.0, backdrop.rgb / (1.0 - source.rgb));
    }
}

#endif // HUBRIS_BLEND_COLORDODGE