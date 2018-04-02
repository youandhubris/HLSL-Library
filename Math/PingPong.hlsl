#ifndef HUBRIS_MATH_PINGPONG
#define HUBRIS_MATH_PINGPONG
// REQUIRES
#include "Repeat.hlsl"

namespace Hubris
{
	inline float pingPong(float value, float length)
	{
		float r = repeat(value, length * 2.0);
		return length - abs(r - length);
	}

    inline float2 pingPong(float2 value, float2 length)
	{
		float2 r = repeat(value, length * 2.0);
		return length - abs(r - length);
	}

    inline float3 pingPong(float3 value, float3 length)
	{
		float3 r = repeat(value, length * 2.0);
		return length - abs(r - length);
	}

    inline float4 pingPong(float4 value, float4 length)
	{
		float4 r = repeat(value, length * 2.0);
		return length - abs(r - length);
	}
}

#endif // HUBRIS_MATH_PINGPONG