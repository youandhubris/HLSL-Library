#ifndef HUBRIS_MATH_REMAP
#define HUBRIS_MATH_REMAP

namespace Hubris
{
	inline float remap(float value, float from1, float to1, float from2, float to2)
	{
		return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
	}

	inline float2 remap(float2 value, float2 from1, float2 to1, float2 from2, float2 to2)
	{
		return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
	}

    inline float3 remap(float3 value, float3 from1, float3 to1, float3 from2, float3 to2)
	{
		return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
	}

	inline float4 remap(float4 value, float4 from1, float4 to1, float4 from2, float4 to2)
	{
		return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
	}
}

#endif // HUBRIS_MATH_REMAP