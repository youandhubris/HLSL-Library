#ifndef HUBRIS_BLEND_HARDLIGHT
#define HUBRIS_BLEND_HARDLIGHT

namespace Hubris
{
    inline half3 HardLight(half4 backdrop, half4 source)
    {
	    half maxRGB = max(source.r, source.g);
	    maxRGB = max(maxRGB, source.b);

	    half blend = smoothstep(0.2, 0.8, maxRGB);

	    half3 multiply = backdrop.rgb * (2.0 * source.rgb);
	    half3 screen = backdrop.rgb - (1.0 - 2.0 * source.rgb) - (backdrop.rgb * (1.0 - 2.0 * source.rgb));

	    return lerp(multiply, screen, blend);
    }
}

#endif // HUBRIS_BLEND_HARDLIGHT