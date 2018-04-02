#ifndef HUBRIS_BLEND_COLORBURN
#define HUBRIS_BLEND_COLORBURN

namespace Hubris
{
    inline half3 ColorBurn(half4 backdrop, half4 source)
    {
	    if (backdrop.r == 1.0 && backdrop.g == 1.0 && backdrop.b == 1.0) return 1.0;
	    else if (source.r == 0.0 && source.g == 0.0 && source.b == 0.0) return 0.0;
	    else return 1.0 - min(1.0, (1.0 - backdrop.rgb) / source.rgb);
    }
}

#endif // HUBRIS_BLEND_COLORBURN