# HLSL-Library

## Noise TOOD (float+)
-	**float4 Noise**
	-	float NoiseSimplex1D
	-	float NoiseSimplex2D
	-	float NoiseSimplex3D
	-	float NoiseSimplex4D
	-	float RidgedNoise1D
	-	float RidgedNoise2D
	-	float RidgedNoise3D
	-	float RidgedNoise4D
	-	float2 DerivateNoise1D
	-	float3 DerivateNoise2D
	-	float4 DerivateNoise3D
	-	float4 DerivateNoise4D
	-	float WorleyNoise2D
	-	float WorleyNoise3D
	-	float WorleyNoise2DF
	-	float WorleyNoise3DF
	-	float FlowNoise2D
	-	float FlowNoise3D
	-	float3 DerivativeFlowNoise2D
	-	float4 DerivativeFlowNoise3D
	-	float2 CurlNoise2D
	-	float2 CurlNoise2DT
	-	float2 CurlNoise2DO
	-	float3 CurlNoise3D
	-	float3 CurlNoise3DT
	-	float3 CurlNoise3DO
	-	float FBM1D
	-	float FBM2D
	-	float FBM3D
	-	float FBM4D
	-	float WorleyFBM2DO
	-	float WorleyFBM3DO
	-	float WorleyFBM2DF
	-	float WorleyFBM3DF
	-	float2 DerivativeFBM1D
	-	float3 DerivativeFBM2D
	-	float4 DerivativeFBM3D
	-	float4 DerivativeFBM4D
	-	float RidgedMF1D
	-	float RidgedMF2D
	-	float RidgedMF3D
	-	float RidgedMF4D
	-	float iqFBM2D
	-	float iqFBM3D
	-	float iqMatFBM2D

## NoiseAshima TODO
-	**Classic Perlin**
-	**Classic Perlin Periodic**
-	**Noise Simplex**

## AA
-	**float AAStep**

## Blend
-	**half4 Blend**
	-	half3 Darken
	-	half3 Multiply
	-	half3 ColorBurn
	-	half3 LinearBurn
	-	half3 DarkerColor
	-	half3 Lighten
	-	half3 Screen
	-	half3 ColorDodge
	-	half3 LinearDodge
	-	half3 LighterColor
	-	half3 Overlay
	-	half3 SoftLight
	-	half3 HardLight
	-	half3 VividLight
	-	half3 LinearLight
	-	half3 PinLight
	-	half3 HardMix
	-	half3 Difference
	-	half3 Exclusion
	-	half3 Subtract
	-	half3 Divide
	-	half3 Hue
	-	half3 Saturation
	-	half3 Color
	-	half3 Luminosity

## Blur
-	**half4 GaussianBlur**

## Color
### Conversions
-	**half3 RGB2CMY**
-	**half3 CMY2RGB**
-	**half4 CMY2CMYK**
-	**half4 RGB2CMYK**
-	**half3 CMYK2RGB**
-	**half4 RGB2HSV**
-	**half4 HSV2RGB**

-	**half4 Desaturate**
-	**half Luminance**
-	**half4 ShiftHSV**

## Ease
-	**float Ease**
	-	float BackIn
	-	float BackInOut
	-	float BackOut
	-	float BounceIn
	-	float BounceInOut
	-	float BounceOut
	-	float CircularIn
	-	float CircularInOut
	-	float CircularOut
	-	float CubicIn
	-	float CubicInOut
	-	float CubicOut
	-	float ElasticIn
	-	float ElasticInOut
	-	float ElasticOut
	-	float ExponentialIn
	-	float ExponentialInOut
	-	float ExponentialOut
	-	float QuadraticIn
	-	float QuadraticInOut
	-	float QuadraticOut
	-	float QuarticIn
	-	float QuarticInOut
	-	float QuarticOut
	-	float QuinticIn
	-	float QuinticInOut
	-	float QuinticOut
	-	float SineIn
	-	float SineInOut
	-	float SineOut

## Math
### PingPong
-	**float pingPong**
-	**float2 pingPong**
-	**float3 pingPong**
-	**float4 pingPong**

### Remap
-	**float remap**
-	**float2 remap**
-	**float3 remap**
-	**float4 remap**

### Repeat
-	**float repeat**
-	**float2 repeat**
-	**float3 repeat**
-	**float4 repeat**

## Shape
-	**float Circle**
-	**float Polygon**

## Transform TODO (Spherical naming)
-	**float Polar**
-	**float2 Rotate**
-	**Spherical toSpherical**
-	**float3 polarToCartesian**
-	**float2 Tile**

___

## License

The contents of this repository are licensed under the MIT License (see the LICENSE.md root file for details), unless specified otherwise. When so, the license itself is contained within the code, or next to the file(s) in case of compiled code or multimedia assets.