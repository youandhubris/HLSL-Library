#ifndef HUBRIS_SHAPE_POLYGON
#define HUBRIS_SHAPE_POLYGON
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
	inline float Polygon(float2 coords, float sides, float angle, float2 center)
	{
		float2 uv = coords - center;
		float a = atan2(uv.x, uv.y) + angle;
		float r = HUBRIS_TWO_PI / sides;
		return cos(floor(0.5 + a / r) * r - a) * length(uv);
	}
}

#endif // HUBRIS_SHAPE_POLYGON