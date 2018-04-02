#ifndef HUBRIS_BLEND_HARDMIX
#define HUBRIS_BLEND_HARDMIX

namespace Hubris
{
    inline half3 HardMix(half4 backdrop, half4 source)
    {
	    return floor(backdrop.rgb + source.rgb);
    }
}

#endif // HUBRIS_BLEND_HARDMIX