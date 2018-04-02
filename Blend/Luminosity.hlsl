#ifndef HUBRIS_BLEND_LUMINOSITY
#define HUBRIS_BLEND_LUMINOSITY

namespace Hubris
{
    inline half3 Luminosity(half4 backdrop, half4 source)
    {
	    half dLum = dot(backdrop.rgb, half3(0.3, 0.59, 0.11));
	    half sLum = dot(source.rgb, half3(0.3, 0.59, 0.11));
	    half lum = sLum - dLum;
	    half3 c = backdrop.rgb + lum;
	    half minC = min(min(c.x, c.y), c.z);
	    half maxC = max(max(c.x, c.y), c.z);
	    if (minC < 0.0) return sLum + ((c - sLum) * sLum) / (sLum - minC);
	    else if (maxC > 1.0) return sLum + ((c - sLum) * (1.0 - sLum)) / (maxC - sLum);
	    else return c;
    }
}

#endif // HUBRIS_BLEND_LUMINOSITY