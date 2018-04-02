#ifndef HUBRIS_BLEND_OVERLAY
#define HUBRIS_BLEND_OVERLAY

namespace Hubris
{
    inline half3 Overlay(half4 backdrop, half4 source)
    {
	    if (backdrop.r <= 0.5 && backdrop.g <= 0.5 && backdrop.b <= 0.5) return source.rgb * 2 * backdrop.rgb;
	    else return source.rgb + (2.0 * backdrop.rgb - 1.0) - (source.rgb * (2.0 * backdrop.rgb - 1.0));
    }
}

#endif // HUBRIS_BLEND_OVERLAY