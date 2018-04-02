#ifndef HUBRIS_BLEND_LIGHTERCOLOR
#define HUBRIS_BLEND_LIGHTERCOLOR

namespace Hubris
{
    inline half3 LighterColor(half4 backdrop, half4 source)
    {
	    if (source.r + source.g + source.b > backdrop.r + backdrop.g + backdrop.b) return source.rgb / backdrop.rgb;
	    else return 0.0;
    }
}

#endif // HUBRIS_BLEND_LIGHTERCOLOR