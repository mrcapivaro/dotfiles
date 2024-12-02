// retro-terminal.glsl
//
// USAGE
//     activate it in picom.conf. Example:
//     ```~/.config/picom/picom.conf
//     window-shader-fg-rule = [
//         "retro-terminal.glsl:class_g = 'kitty'",
//     ];
//     ```
//
// DESCRIPTION
//     CRT + Bloom for picom with terminal use in mind
//
// USEFUL LINKS
//     ShaderToy: https://www.shadertoy.com/view/MtSfRK
//     Ghostty shaders: https://gist.github.com/qwerasd205/c3da6c610c8ffe17d6d2d3cc7068f17f
//     Learn GLSL: https://learnopengl.com/Getting-started/Shaders
//     Picom art. shaders: https://github.com/ikz87/picom-shaders/blob/main/Artistic/OldCRT.glsl
//
// Specifications:
//     - Use CRT & Bloom shaders from picom-shaders repo as template;
//     - Remove the curved screen and vignette effects;
//     - Adjust the properties of scanlines;
//     - Apply BLOOM after/before CRT shaders;
//     - Simplify and improve code, if possible;
//     - Maybe remove the RGB decomposition shaders;
//         - Make it pleasant and effortless to see;
//     - Port it to shadertoy;

#version 430
#define PI 3.1415926538
uniform float opacity;
uniform float time;

// Works best with fullscreen windows
// Made this to play retro games the way god intended

uniform float sc_freq = 0.4; // Frequency for the scanlines

uniform float sc_intensity = 0.5; // Intensity of the scanline effect

uniform bool grid = false; // Whether to also apply scanlines to x axis or not

uniform int distortion_offset = 1; // Pixel offset for red/blue distortion

uniform int downscale_factor = 1; // How many pixels of the window
// make an actual "pixel" (or block)

uniform float sph_distance = 50000; // Distance from the theoretical sphere
// we use for our curvature transform

uniform float curvature = 0.1; // How much the window should "curve"

uniform float shadow_cutoff = 0; // How "early" the shadow starts affecting
// pixels close to the edges
// I'd keep this value very close to 1

uniform int shadow_intensity = 0; // Intensity level of the shadow effect (from 1 to 5)

vec4 outside_color = vec4(0, 0, 0, opacity); // Color for the outside of the window

float flash_speed = 0; // Speed of flashing effect, set to 0 to deactivate

float flash_intensity = 0.8; // Intensity of flashing effect

// You can play with different values for all the variables above

in vec2 texcoord; // texture coordinate of the fragment

uniform sampler2D tex; // texture of the window

ivec2 window_size = textureSize(tex, 0);
ivec2 window_center = ivec2(window_size.x / 2, window_size.y / 2);
float radius = (window_size.x / curvature);
int flash = int(round(flash_speed * time / (10000 / window_size.y))) % window_size.y;

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

// Darkens a pixels near the edges
vec4 darken_color(vec4 color, vec2 coords)
{
    // If shadow intensity is 0, change nothing
    if (shadow_intensity == 0)
    {
        return color;
    }

    // Get how far the coords are from the center
    vec2 distances_from_center = abs(window_center - coords);

    // Darken pixels close to the edges of the screen in a polynomial fashion
    float brightness = 1;
    brightness *= -pow((distances_from_center.y / window_center.y) * shadow_cutoff,
            (5 / shadow_intensity) * 2) + 1;
    brightness *= -pow((distances_from_center.x / window_center.x) * shadow_cutoff,
            (5 / shadow_intensity) * 2) + 1;
    color.xyz *= brightness;

    return color;
}

// Applies a transformation to our window pixels to simulate
// a curved screen
ivec2 curve_coords_spheric(vec2 coords)
{
    // Offset coords
    coords -= window_center;
    vec2 curved_coords;

    // For this transform imagine a sphere in a 3d space with the
    // window as a 2d plane tangent to that sphere
    // For simplicity, we center the sphere at 0,0,0
    // The coordinates of the projection share x and y with our window pixel
    // We find Z using the formula for a sphere
    vec3 projection_coords3d = vec3(coords.x, coords.y,
            sqrt(pow(radius + sph_distance, 2) -
                    pow(coords.x, 2) -
                    pow(coords.y, 2)));

    // That vector goes from the center of the sphere to the projection of a pixel
    // of our window onto the sphere's surface
    // Let's scale it until it hits our window plane
    projection_coords3d *= ((radius + sph_distance) / projection_coords3d.z);
    curved_coords = projection_coords3d.xy;

    // Compensate for starting coords offset
    curved_coords += window_center;

    return ivec2(curved_coords);
}

// Gets a color for a pixel with all the coordinate and
// downscale changes
vec4 get_pixel(vec2 coords)
{
    // If pixel is at the edge of the window, return a completely black color
    if (coords.x >= window_size.x - 1 || coords.y >= window_size.y - 1 ||
            coords.x <= 0 || coords.y <= 0)
    {
        return outside_color;
    }
    vec4 color = texelFetch(tex, ivec2(coords), 0);
    return default_post_processing(color);
}

// Gets the color from a downscaled block
vec4 get_block_color(vec2 coords)
{
    // If downscale is set to 1, just return a pixel
    if (downscale_factor < 2)
    {
        return get_pixel(coords);
    }

    // Relative position of pixel inside the block
    ivec2 relative_position;
    relative_position.xy = ivec2(coords).xy % downscale_factor;

    // Average all colors from pixels inside the block
    vec4 average = vec4(0, 0, 0, 0);
    for (int i = 0; i < downscale_factor; i++)
    {
        for (int j = 0; j < downscale_factor; j++)
        {
            average.xyzw += get_pixel(vec2(coords.x + i - relative_position.x,
                        coords.y + j - relative_position.y));
        }
    }
    average /= pow(downscale_factor, 2);

    return average;
}

// [ BLOOM START ] //
uniform float cutoff = 0.55; // Brightness value that should be considered as a "bright" pixel

uniform float light_brightness = 1; // Scaling value for the brightness of the bloom effect

uniform float base_brightness = 1.2; // Scaling value for the brightness of the bright pixels

// Here are some kerneles you can use for the gaussian blur
uniform float kernel1[5][5] = {
    { 0.003, 0.013, 0.022, 0.013, 0.003 },
    { 0.013, 0.059, 0.097, 0.059, 0.013 },
    { 0.022, 0.097, 0.159, 0.097, 0.022 },
    { 0.013, 0.059, 0.097, 0.059, 0.013 },
    { 0.003, 0.013, 0.022, 0.013, 0.003 }
};

uniform float kernel2[7][7] = {
    { 0.0051, 0.0094, 0.0135, 0.0153, 0.0135, 0.0094, 0.0051 },
    { 0.0094, 0.0173, 0.0250, 0.0282, 0.0250, 0.0173, 0.0094 },
    { 0.0135, 0.0250, 0.0361, 0.0407, 0.0361, 0.0250, 0.0135 },
    { 0.0153, 0.0282, 0.0407, 0.0461, 0.0407, 0.0282, 0.0153 },
    { 0.0135, 0.0250, 0.0361, 0.0407, 0.0361, 0.0250, 0.0135 },
    { 0.0094, 0.0173, 0.0250, 0.0282, 0.0250, 0.0173, 0.0094 },
    { 0.0051, 0.0094, 0.0135, 0.0153, 0.0135, 0.0094, 0.0051 },
};

float blur_kernel[7][7] = kernel2; // Kernel to use for the gaussian blur

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

// Returns the brightness of a pixel
float get_brightness(vec4 color)
{
    return (color.x + color.y + color.z) / 3;
}
// [  BLOOM END  ] //

// Main shader function
vec4 window_shader() {
    // Fetch the color
    vec4 c = get_block_color(texcoord);

    // Fetch colors from close pixels to apply color distortion
    vec4 c_right = get_block_color(vec2(texcoord.x + 2, texcoord.y));
    vec4 c_left = get_block_color(vec2(texcoord.x - 2, texcoord.y));

    // Mix red and blue colors
    c = vec4(c_left.x, c.y, c_right.z, c.w);

    // Apply scanlines
    c.xyz *= sin(2 * PI * sc_freq * (texcoord).y) / (2 / sc_intensity) +
            1 - sc_intensity / 2;

    // Also apply scanlines to x axis if grid is enabled
    if (grid == true)
    {
        c.xyz *= sin(2 * PI * sc_freq * (texcoord).x) / (2 / sc_intensity) +
                1 - sc_intensity / 2;
    }

    // Apply flash
    if (texcoord.y >= flash - (window_size.y / 10) && texcoord.y <= flash)
    {
        c.xyz *= flash_intensity * (pow(((flash - texcoord.y) / (window_size.y / 10)) - 1, 2)
                    + 1 / flash_intensity);
    }

    // Darken pixel
    c = darken_color(c, texcoord);

    // [ BLOOM START ] //
    vec4 total = vec4(0);
    // Radius of the kernel
    int radius = int(floor(blur_kernel[0].length() / 2));

    // Apply convolution
    // my mods: change vec4 c to vec4 sampleColor and use a continue;
    for (int y = -radius; y <= radius; y++)
    {
        for (int x = -radius; x <= radius; x++)
        {
            // Fetch pixel
            vec4 sampleColor = texelFetch(tex, ivec2(texcoord.x + x, texcoord.y + y), 0);
            sampleColor = default_post_processing(c);

            // If the brightness is below our cutoff, set the pixel
            // as an empty one
            if (get_brightness(sampleColor) < cutoff)
            {
                sampleColor = vec4(0);
                // continue; // simpler???
            }

            // Convolve and multiply by the light brightness
            sampleColor *= blur_kernel[x + radius][y + radius];
            sampleColor.xyz *= light_brightness;
            total.xyzw += sampleColor;
        }
    }

    // Scale the brightness of the pixel with clamping
    vec4 c = texelFetch(tex, ivec2(texcoord), 0);
    if (get_brightness(c) >= cutoff)
    {
        c.xyz = min(c.xyz * base_brightness, 1);
    }

    // Apply screen blending mode
    c.xyzw = 1 - (1 - total.xyzw) * (1 - c.xyzw);
    return default_post_processing(c);
    // [  BLOOM END  ] //

    // return c;
}
