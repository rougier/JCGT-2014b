// -----------------------------------------------------------------------------
// Copyright (c) 2014, Nicolas P. Rougier. All Rights Reserved.
// Distributed under the (new) BSD License.
// -----------------------------------------------------------------------------
#version 120

/* ---------------------------------------------------------
   Compute antialiased fragment color for a stroke line.

   Parameters:
   -----------

   distance : signed distance to border (in pixels)
   linewidth: Stroke line width (in pixels)
   antialias: Stroke antialiased area (in pixels)
   stroke:    Stroke color

   Return:
   -------
   Fragment color (vec4)

   --------------------------------------------------------- */
vec4 stroke(float distance, float linewidth, float antialias, vec4 stroke)
{
    vec4 frag_color;
    float t = linewidth/2.0 - antialias;
    float signed_distance = distance;
    float border_distance = abs(signed_distance) - t;
    float alpha = border_distance/antialias;
    alpha = exp(-alpha*alpha);

    if( border_distance < 0.0 )
        frag_color = stroke;
    else
        frag_color = vec4(stroke.rgb, stroke.a * alpha);

    return frag_color;
}

/* ---------------------------------------------------------
   Compute antialiased fragment color for a filled shape.

   Parameters:
   -----------

   distance : signed distance to border (in pixels)
   linewidth: Stroke line width (in pixels)
   antialias: Stroke antialiased area (in pixels)
   fill:      Fill color

   Return:
   -------
   Fragment color (vec4)

   --------------------------------------------------------- */
vec4 filled(float distance, float linewidth, float antialias, vec4 fill)
{
    vec4 frag_color;
    float t = linewidth/2.0 - antialias;
    float signed_distance = distance;
    float border_distance = abs(signed_distance) - t;
    float alpha = border_distance/antialias;
    alpha = exp(-alpha*alpha);

    if( border_distance < 0.0 )
        frag_color = fill;
    else if( signed_distance < 0.0 )
        frag_color = fill;
    else
        frag_color = vec4(fill.rgb, alpha * fill.a);

    return frag_color;
}

/* ---------------------------------------------------------
   Compute antialiased fragment color for an outlined shape.

   Parameters:
   -----------

   distance : signed distance to border (in pixels)
   linewidth: Stroke line width (in pixels)
   antialias: Stroke antialiased area (in pixels)
   stroke:    Stroke color
   fill:      Fill color

   Return:
   -------
   Fragment color (vec4)

   --------------------------------------------------------- */
vec4 outline(float distance, float linewidth, float antialias, vec4 stroke, vec4 fill)
{
    vec4 frag_color;
    float t = linewidth/2.0 - antialias;
    float signed_distance = distance;
    float border_distance = abs(signed_distance) - t;
    float alpha = border_distance/antialias;
    alpha = exp(-alpha*alpha);

    if( border_distance < 0.0 )
        frag_color = stroke;
    else if( signed_distance < 0.0 )
        frag_color = mix(fill, stroke, sqrt(alpha));
    else
        frag_color = vec4(stroke.rgb, stroke.a * alpha);
    return frag_color;
}
