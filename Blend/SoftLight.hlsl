#ifndef HUBRIS_BLEND_SOFTLIGHT
#define HUBRIS_BLEND_SOFTLIGHT

namespace Hubris
{
    inline half3 SoftLight(half4 backdrop, half4 source)
    {
	    half3 dependency;
	    if (backdrop.r <= 0.25 && backdrop.g <= 0.25 && backdrop.b <= 0.25) dependency = ((16.0 * backdrop.rgb - 12.0) * backdrop.rgb + 4.0) * backdrop.rgb;
	    else dependency = sqrt(backdrop.rgb);

	    if (backdrop.r <= 0.5 && backdrop.g <= 0.5 && backdrop.b <= 0.5) return backdrop.rgb - (1.0 - 2.0 * source.rgb) * backdrop.rgb * (1.0 - backdrop.rgb);
	    else return backdrop.rgb + (2.0 * source.rgb - 1.0) * (dependency - backdrop.rgb);
    }
}

#endif // HUBRIS_BLEND_SOFTLIGHT