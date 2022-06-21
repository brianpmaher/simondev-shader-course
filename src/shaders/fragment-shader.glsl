uniform float time;
uniform sampler2D diffuse;

varying vec2 vUv;

float inverseLerp(float v, float minValue, float maxValue) {
    return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
    float t = inverseLerp(v, inMin, inMax);
    return mix(outMin, outMax, t);
}

void main() {
    vec4 color = vec4(0.0);
    vec4 diffuse = texture2D(diffuse, vUv);

    float t = sin((vUv.y + time) * 400.0);

    vec4 scanLines = vec4(remap(t, -1.0, 1.0, 0.75, 1.0));

    color = diffuse * scanLines;

    gl_FragColor = color;
}
