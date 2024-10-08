// CRT + Bloom for picom
//
// USEFUL LINKS
//   ShaderToy: https://www.shadertoy.com/view/MtSfRK
//   Ghostty shaders: https://gist.github.com/qwerasd205/c3da6c610c8ffe17d6d2d3cc7068f17f
//   Learn GLSL: https://learnopengl.com/Getting-started/Shaders
//   Picom art. shaders: https://github.com/ikz87/picom-shaders/blob/main/Artistic/OldCRT.glsl

#version 430

void main() {
    vec4 color = default_post_processing(gl_fragColor);
    gl_FragColor = color;
}
