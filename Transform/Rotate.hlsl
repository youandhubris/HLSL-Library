#ifndef HUBRIS_TRANSFORM_ROTATE
#define HUBRIS_TRANSFORM_ROTATE

namespace Hubris
{
	inline float2 Rotate(float2 coordinates, float angle)
	{
		float2x2 rotationMatrix = float2x2(cos(angle), -sin(angle), sin(angle), cos(angle));
		return mul(rotationMatrix, coordinates);
	}

}

#endif // HUBRIS_TRANSFORM_ROTATE