#ifndef HUBRIS_BLEND_DARKERCOLOR
#define HUBRIS_BLEND_DARKERCOLOR

namespace Hubris
{
    inline half3 DarkerColor(half4 backdrop, half4 source)
    {
	    if (source.r + source.g + source.b > backdrop.r + backdrop.g + backdrop.b) return backdrop.rgb / source.rgb;
	    else return 0.0;
    }
}

#endif // HUBRIS_BLEND_DARKERCOLOR