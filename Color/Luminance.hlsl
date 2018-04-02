#ifndef HUBRIS_COLOR_LUMINANCE
#define HUBRIS_COLOR_LUMINANCE

namespace Hubris
{
    inline half Luminance(half3 color)
	{
        // Values from "Graphics Shaders: Theory and Practice" by Bailey and Cunningham
        const half3 lumaWeight = half3(0.2125, 0.7154, 0.0721);
        return dot(color, lumaWeight);
    }
}

#endif // HUBRIS_COLOR_LUMINANCE