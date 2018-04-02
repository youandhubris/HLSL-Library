#ifndef HUBRIS_BLEND_SCREEN
#define HUBRIS_BLEND_SCREEN

namespace Hubris
{
    inline half3 Screen(half4 backdrop, half4 source)
    {
	    return backdrop.rgb + source.rgb - (backdrop.rgb * source.rgb);
    }
}

#endif // HUBRIS_BLEND_SCREEN