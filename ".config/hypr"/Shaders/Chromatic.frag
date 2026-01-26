// vim: set ft=glsl:

precision highp float;
varying highp vec2 v_texcoord;
uniform highp sampler2D tex;

#define STRENGTH 0.035

void main() {
    vec2 center = vec2(0.5);
    vec2 offset = (v_texcoord - center) * STRENGTH;

    float r2 = dot(offset, offset);
    vec2 distortion = offset * (0.05 + r2);

    // Separate only R and B
    vec4 base = texture2D(tex, v_texcoord);
    float r = texture2D(tex, v_texcoord + distortion).r;
    float b = texture2D(tex, v_texcoord - distortion).b;

    // Keep green untouched
    gl_FragColor = vec4(r, base.g, b, base.a);
}

