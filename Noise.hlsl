#ifndef HUBRIS_NOISE
#define HUBRIS_NOISE
// REQUIRES
#include "Noise/Simplex.hlsl"

namespace Hubris
{
    inline float4 Noise(int noise, float4 xyzw, float fallOff, float angle, float t, float ridgeOffset, int octaves, float lacunarity, float gain)
    {
        float4 value = 0;

        if (noise == 0) value = 0.0;
        else if (noise == 1) value.x = NoiseSimplex(xyzw.x);
        else if (noise == 2) value.x = NoiseSimplex(xyzw.xy);
        else if (noise == 3) value.x = NoiseSimplex(xyzw.xyz);
        else if (noise == 4) value.x = NoiseSimplex(xyzw);
        else if (noise == 5) value.x = RidgedNoise(xyzw.x);
        else if (noise == 6) value.x = RidgedNoise(xyzw.xy);
        else if (noise == 7) value.x = RidgedNoise(xyzw.xyz);
        else if (noise == 8) value.x = RidgedNoise(xyzw);
        else if (noise == 9) value.xy = DerivateNoise(xyzw.x);
        else if (noise == 10) value.xyz = DerivateNoise(xyzw.xy);
        else if (noise == 11) value = DerivateNoise(xyzw.xyz);
        else if (noise == 12) value = DerivateNoise(xyzw);
        else if (noise == 13) value.x = WorleyNoise(xyzw.xy);
        else if (noise == 14) value.x = WorleyNoise(xyzw.xyz);
        else if (noise == 15) value.x = WorleyNoise(xyzw.xy, fallOff);
        else if (noise == 16) value.x = WorleyNoise(xyzw.xyz, fallOff);
        else if (noise == 17) value.x = FlowNoise(xyzw.xy, angle);
        else if (noise == 18) value.x = FlowNoise(xyzw.xyz, angle);
        else if (noise == 19) value.x = DerivativeFlowNoise(xyzw.xy, angle);
        else if (noise == 20) value.x = DerivativeFlowNoise(xyzw.xyz, angle);
        else if (noise == 21) value.xy = CurlNoise(xyzw.xy);
        else if (noise == 22) value.xy = CurlNoise(xyzw.xy, t);
        else if (noise == 23) value.xy = CurlNoise(xyzw.xy, octaves, lacunarity, gain);
        else if (noise == 24) value.xyz = CurlNoise(xyzw.xyz);
        else if (noise == 25) value.xyz = CurlNoise(xyzw.xyz, t);
        else if (noise == 26) value.xyz = CurlNoise(xyzw.xyz, octaves, lacunarity, gain);
        else if (noise == 27) value.x = FBM(xyzw.x, octaves, lacunarity, gain);
        else if (noise == 28) value.x = FBM(xyzw.xy, octaves, lacunarity, gain);
        else if (noise == 29) value.x = FBM(xyzw.xyz, octaves, lacunarity, gain);
        else if (noise == 30) value.x = FBM(xyzw, octaves, lacunarity, gain);
        else if (noise == 31) value.x = WorleyFBM(xyzw.xy, octaves, lacunarity, gain);
        else if (noise == 32) value.x = WorleyFBM(xyzw.xyz, octaves, lacunarity, gain);
        else if (noise == 33) value.x = WorleyFBM(xyzw.xy, fallOff, octaves, lacunarity, gain);
        else if (noise == 34) value.x = WorleyFBM(xyzw.xyz, fallOff, octaves, lacunarity, gain);
        else if (noise == 35) value.xy = DerivativeFBM(xyzw.x, octaves, lacunarity, gain);
        else if (noise == 36) value.xyz = DerivativeFBM(xyzw.xy, octaves, lacunarity, gain);
        else if (noise == 37) value = DerivativeFBM(xyzw.xyz, octaves, lacunarity, gain);
        else if (noise == 38) value = DerivativeFBM(xyzw, octaves, lacunarity, gain);
        else if (noise == 39) value.x = RidgedMF(xyzw.x, ridgeOffset, octaves, lacunarity, gain);
        else if (noise == 40) value.x = RidgedMF(xyzw.xy, ridgeOffset, octaves, lacunarity, gain);
        else if (noise == 41) value.x = RidgedMF(xyzw.xyz, ridgeOffset, octaves, lacunarity, gain);
        else if (noise == 42) value.x = RidgedMF(xyzw, ridgeOffset, octaves, lacunarity, gain);
        else if (noise == 43) value.x = iqFBM(xyzw.xy, octaves, lacunarity, gain);
        else if (noise == 44) value.x = iqFBM(xyzw.xyz, octaves, lacunarity, gain);
        else if (noise == 45) value.x = iqMatFBM(xyzw.xy, octaves, float2x2(1.6, -1.2, 1.2, 1.6), gain);

        return value;
    }
}


////! Returns a XD simplex noise
//inline float NoiseSimplex(float x);
//inline float NoiseSimplex(float2 xy);
//inline float NoiseSimplex(float3 xyz);
//inline float NoiseSimplex(float4 xyzw);

////! Returns a XD simplex ridged noise
//inline float RidgedNoise(float x);
//inline float RidgedNoise(float2 xy);
//inline float RidgedNoise(float3 xyz);
//inline float RidgedNoise(float4 xyzw);

////! Returns a XD simplex noise with analytical derivative.
//inline float2 DerivateNoise(float x);
//inline float3 DerivateNoise(float2 xy);
//inline float4 DerivateNoise(float3 xyz);
//inline float4 DerivateNoise(float4 xyzw);
	
////! Returns a XD simplex cellular/worley noise
//inline float WorleyNoise(float2 xy);
//inline float WorleyNoise(float3 xyz);
//inline float WorleyNoise(float2 xy, float fallOff);
//inline float WorleyNoise(float3 xyz, float fallOff);

////! Returns a XD simplex noise with rotating gradients
//inline float FlowNoise(float2 xy, float angle);
//inline float FlowNoise(float3 xyz, float angle);

////! Returns a XD simplex noise with rotating gradients and analytical derivatives
//inline float3 DerivativeFlowNoise(float2 xy, float angle);
//inline float4 DerivativeFlowNoise(float3 xyz, float angle);

////! Returns the curl of a XD simplex noise
//inline float2 CurlNoise(float2 xy);
//inline float2 CurlNoise(float2 xy, float t);
//inline float2 CurlNoise(float2 xy, int octaves, float lacunarity, float gain);
//inline float3 CurlNoise(float3 xyz);
//inline float3 CurlNoise(float3 xyz, float t);
//inline float3 CurlNoise(float3 xyz, int octaves, float lacunarity, float gain);

//// //! Returns the curl of a custom 2D potential using finite difference approximation
//// inline float2 curl(float2 xy, float2 potential, float delta = 1e-4f);
//// //! Returns the curl of a custom 3D potential using finite difference approximation
//// inline float3 curl(float3 xyz, float3 potential, float delta = 1e-4f);

////! Returns a XD simplex noise fractal brownian motion sum
//inline float FBM(float x, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float FBM(float2 xy, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float FBM(float3 xyz, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float FBM(float4 xyzw, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
	
////! Returns a XD simplex cellular/worley noise fractal brownian motion sum
//inline float WorleyFBM(float2 xy, int octaves, float lacunarity, float gain);
//inline float WorleyFBM(float3 xyz, int octaves, float lacunarity, float gain);
//inline float WorleyFBM(float2 xy, float fallOff, int octaves, float lacunarity, float gain);
//inline float WorleyFBM(float3 xyz, float fallOff, int octaves, float lacunarity, float gain);

////! Returns a XD simplex noise fractal brownian motion sum with analytical derivatives
//inline float2 DerivativeFBM(float x, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float3 DerivativeFBM(float2 xy, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float4 DerivativeFBM(float3 xyz, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float4 DerivativeFBM(float4 xyzw, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
	
////! Returns a XD simplex ridged multi-fractal noise sum
//inline float RidgedMF(float x, float ridgeOffset = 1.0f, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float RidgedMF(float2 xy, float ridgeOffset = 1.0f, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float RidgedMF(float3 xyz, float ridgeOffset = 1.0f, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float RidgedMF(float4 xyzw, float ridgeOffset = 1.0f, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);

////! Returns the XD simplex noise fractal brownian motion sum variation by Iñigo Quilez
//inline float iqFBM(float2 xy, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);
//inline float iqFBM(float3 xyz, int octaves = 4, float lacunarity = 2.0f, float gain = 0.5f);

////! Returns the 2D simplex noise fractal brownian motion sum variation by Iñigo Quilez that use a mat2 to transform each octave
//inline float iqMatFBM(float2 xy, int octaves = 4, float2x2 mat = float2x2(1.6, -1.2, 1.2, 1.6), float gain = 0.5f);


#endif // HUBRIS_NOISE