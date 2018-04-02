#ifndef HUBRIS_BLEND_VIVIDLIGHT
#define HUBRIS_BLEND_VIVIDLIGHT

namespace Hubris
{
    inline half vL(half s, half d)
    {
	    return (s < 0.5) ? 1.0 - (1.0 - d) / (2.0 * s) : d / (2.0 * (1.0 - s));
    }

    inline half3 VividLight(half4 backdrop, half4 source)
    {
	    return half3(vL(source.r, backdrop.r), vL(source.g, backdrop.g), vL(source.b, backdrop.b));
    }
}

#endif // HUBRIS_BLEND_VIVIDLIGHT