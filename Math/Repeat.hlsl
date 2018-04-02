#ifndef HUBRIS_MATH_REPEAT
#define HUBRIS_MATH_REPEAT

namespace Hubris
{
	inline float repeat(float value, float length)
	{
		return clamp(value - floor(value / length) * length, 0.0, length);
	}

    inline float2 repeat(float2 value, float2 length)
	{
		return clamp(value - floor(value / length) * length, 0.0, length);
	}

    inline float3 repeat(float3 value, float3 length)
	{
		return clamp(value - floor(value / length) * length, 0.0, length);
	}

    inline float4 repeat(float4 value, float4 length)
	{
		return clamp(value - floor(value / length) * length, 0.0, length);
	}
}

#endif // HUBRIS_MATH_REPEAT