#ifndef HUBRIS_BLEND_EXCLUSION
#define HUBRIS_BLEND_EXCLUSION

namespace Hubris
{
    inline half3 Exclusion(half4 backdrop, half4 source)
    {
	    return backdrop.rgb + source.rgb - 2.0 * backdrop.rgb * source.rgb;
    }
}


#endif // HUBRIS_BLEND_EXCLUSION