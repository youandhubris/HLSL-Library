#ifndef HUBRIS_BLEND_PINLIGHT
#define HUBRIS_BLEND_PINLIGHT

namespace Hubris
{
    inline half pL(half s, half d)
    {
	    return (2.0 * s - 1.0 > d) ? 2.0 * s - 1.0 : (s < 0.5 * d) ? 2.0 * s : d;
    }

    inline half3 PinLight(half4 backdrop, half4 source)
    {
	    return half3(pL(source.r, backdrop.r), pL(source.g, backdrop.g), pL(source.b, backdrop.b));
    }
}

#endif // HUBRIS_BLEND_PINLIGHT