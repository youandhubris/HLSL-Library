#ifndef HUBRIS_BLEND_LINEARBURN
#define HUBRIS_BLEND_LINEARBURN

namespace Hubris
{
    inline half3 LinearBurn(half4 backdrop, half4 source)
    {
	    return source.rgb + backdrop.rgb - 1.0;
    }
}

#endif // HUBRIS_BLEND_LINEARBURN