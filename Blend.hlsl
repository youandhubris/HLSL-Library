/*
---------------------------------------------------------------------------------------
REFERENCES
http://www.w3.org/TR/compositing-1
https://www.shadertoy.com/view/XdS3RW
http://stackoverflow.com/questions/5919663/how-does-photoshop-blend-two-images-together
---------------------------------------------------------------------------------------

----------------------
BLEND MODES
----------------------
None                 0
                DARKEN
Darken               1
Multiply		     2
Color Burn           3
Linear Burn          4
Darker Color         5
               LIGHTEN
Lighten              6
Screen               7
Color Dodge          8
Linear Dodge (Add)   9
Lighter Color       10
              CONTRAST
Overlay             11
Soft Light          12
Hard Light          13
Vivid Light         14
Linear Light        15
Pin Light           16
Hard Mix            17
             INVERSION
Difference          16
Exclusion           19
           CANCELATION
Subtract            20
Divide              21
             COMPONENT
Hue                 22
Saturation          23
Color               24
Luminosity          25
______________________

----------------------
PORTER DUFF COMPOSITES
----------------------
Clear                0
Copy                 1
Destination          2
Source Over          3
Destination Over     4
Source In            5
Destination In       6
Source Out           7
Destination In       8
Source Atop          9
Destination Atop    10
XOR                 11
Lighter             12
______________________

----------------------
COVERAGE MODES
----------------------
None                 0
Both                 1
Source only          2
Destination only     3
______________________
*/

#ifndef HUBRIS_BLEND
#define HUBRIS_BLEND
// REQUIRES
#include "Blend/Darken.hlsl"
#include "Blend/Multiply.hlsl"
#include "Blend/ColorBurn.hlsl"
#include "Blend/LinearBurn.hlsl"
#include "Blend/DarkerColor.hlsl"
#include "Blend/Lighten.hlsl"
#include "Blend/Screen.hlsl"
#include "Blend/ColorDodge.hlsl"
#include "Blend/LinearDodge.hlsl"
#include "Blend/LighterColor.hlsl"
#include "Blend/Overlay.hlsl"
#include "Blend/SoftLight.hlsl"
#include "Blend/HardLight.hlsl"
#include "Blend/VividLight.hlsl"
#include "Blend/LinearLight.hlsl"
#include "Blend/PinLight.hlsl"
#include "Blend/HardMix.hlsl"
#include "Blend/Difference.hlsl"
#include "Blend/Exclusion.hlsl"
#include "Blend/Subtract.hlsl"
#include "Blend/Divide.hlsl"
#include "Blend/Hue.hlsl"
#include "Blend/Saturation.hlsl"
#include "Blend/Color.hlsl"
#include "Blend/Luminosity.hlsl"

namespace Hubris
{
    inline float4 Blend(float4 backdrop, float4 source, int blendMode, int composite, int coverage)
    {
        // ---> Mix
        float3 mixed = 0.0;


        // ---> Blend
        if (blendMode == 0) mixed = source.rgb;

        else if (blendMode == 1) mixed = Darken(backdrop, source);
        else if (blendMode == 2) mixed = Multiply(backdrop, source);

        else if (blendMode == 3) mixed = ColorBurn(backdrop, source);
        else if (blendMode == 4) mixed = LinearBurn(backdrop, source);
        else if (blendMode == 5) mixed = DarkerColor(backdrop, source);

        else if (blendMode == 6) mixed = Lighten(backdrop, source);
        else if (blendMode == 7) mixed = Screen(backdrop, source);
        else if (blendMode == 8) mixed = ColorDodge(backdrop, source);
        else if (blendMode == 9) mixed = LinearDodge(backdrop, source);
        else if (blendMode == 10) mixed = LighterColor(backdrop, source);

        else if (blendMode == 11) mixed = Overlay(backdrop, source);
        else if (blendMode == 12) mixed = SoftLight(backdrop, source);
        else if (blendMode == 13) mixed = HardLight(backdrop, source);
        else if (blendMode == 14) mixed = VividLight(backdrop, source);
        else if (blendMode == 15) mixed = LinearLight(backdrop, source);
        else if (blendMode == 16) mixed = PinLight(backdrop, source);
        else if (blendMode == 17) mixed = HardMix(backdrop, source);

        else if (blendMode == 18) mixed = Difference(backdrop, source);
        else if (blendMode == 19) mixed = Exclusion(backdrop, source);

        else if (blendMode == 20) mixed = Subtract(backdrop, source);
        else if (blendMode == 21) mixed = Divide(backdrop, source);

        else if (blendMode == 22) mixed = Hue(backdrop, source);
        else if (blendMode == 23) mixed = Saturation(backdrop, source);
        else if (blendMode == 24) mixed = Color(backdrop, source);
        else if (blendMode == 25) mixed = Luminosity(backdrop, source);

        float3 blend = (1.0 - backdrop.a) * source.rgb + backdrop.a * mixed.rgb;


        // ---> Composite
        float2 porterDuff = 0.0;
    
        // Clear
        if (composite == 0) porterDuff = 0.0;
        // Copy
        else if (composite == 1) porterDuff.x = 1.0, porterDuff.y = 0.0;
        // Destination
        else if (composite == 2) porterDuff.x = 0.0, porterDuff.y = 1.0;
        // Source Over
        else if (composite == 3) porterDuff.x = 1.0, porterDuff.y = 1.0 - source.a;
        // Destination Over
        else if (composite == 4) porterDuff.x = 1.0 - backdrop.a, porterDuff.y = 1.0;
        // Source In
        else if (composite == 5) porterDuff.x = backdrop.a, porterDuff.y = 0.0;
        // Destination In
        else if (composite == 6) porterDuff.x = 0.0, porterDuff.y = source.a;
        // Source Out
        else if (composite == 7) porterDuff.x = 1.0 - backdrop.a, porterDuff.y = 0.0;
        // Destination Out
        else if (composite == 8) porterDuff.x = 0.0, porterDuff.y = 1.0 - source.a;
        // Source Atop
        else if (composite == 9) porterDuff.x = backdrop.a, porterDuff.y = 1.0 - source.a;
        // Destination Atop
        else if (composite == 10) porterDuff.x = 1.0 - backdrop.a, porterDuff.y = source.a;
        // XOR
        else if (composite == 11) porterDuff.x = 1.0 - backdrop.a, porterDuff.y = 1.0 - source.a;
        // Lighter
        else if (composite == 12) porterDuff = 1.0;
    
        float3 porterDuffComp = source.a * porterDuff.x * blend + backdrop.a * porterDuff.y * backdrop.rgb;
    
    
        // ---> Coverage
        float cover = 0.0;
    
        // None
        if (coverage == 0) cover = (1.0 - source.a) * (1.0 - backdrop.a);
        // Both
        else if (coverage == 1) cover = source.a * backdrop.a;
        // Source only
        else if (coverage == 2) cover = source.a * (1.0 - backdrop.a);
        // Destination only
        else if (coverage == 3) cover = backdrop.a * (1.0 - source.a);


        // ---> Final
        return float4(clamp(porterDuffComp, 0.0, 1.0), clamp(cover, 0.0, 1.0));
    }
}

#endif // HUBRIS_BLEND