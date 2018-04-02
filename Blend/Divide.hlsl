#ifndef HUBRIS_BLEND_DIVIDE
#define HUBRIS_BLEND_DIVIDE

namespace Hubris
{
    inline half3 Divide(half4 backdrop, half4 source)
    {
	    return backdrop.rgb / source.rgb;
    }
}


#endif // HUBRIS_BLEND_DIVIDE