#ifndef HUBRIS_SHAPE_CIRCLE
#define HUBRIS_SHAPE_CIRCLE

namespace Hubris
{
	inline float Circle(float2 coordinates, float2 center)
	{
		float2 dist = coordinates - center;
		return smoothstep(0, 1, dot(dist, dist) * 4);
	}
}

#endif // HUBRIS_SHAPE_CIRCLE