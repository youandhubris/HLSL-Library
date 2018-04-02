#ifndef HUBRIS_TRANSFORM_POLAR
#define HUBRIS_TRANSFORM_POLAR

namespace Hubris
{
	inline float Polar(float2 coordinates, float2 center, bool doCheap = true)
	{
		if (doCheap)
		{
			float2 dist = coordinates - 0.5;
			return smoothstep(0, 1, dot(dist, dist) * 4);
		}
		else return distance(center, coordinates);
	}
}

#endif // HUBRIS_TRANSFORM_POLAR