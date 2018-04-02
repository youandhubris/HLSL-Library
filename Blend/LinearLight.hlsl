#ifndef HUBRIS_BLEND_LINEARLIGHT
#define HUBRIS_BLEND_LINEARLIGHT

namespace Hubris
{
    inline half3 LinearLight(half4 backdrop, half4 source)
    {
	    return 2.0 * source.rgb + backdrop.rgb - 1.0;
    }
}

#endif // HUBRIS_BLEND_LINEARLIGHT