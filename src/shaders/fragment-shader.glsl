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

    float t1 = remap(sin(vUv.y * 400.0 + time * 10.0), -1.0, 1.0, 0.9, 1.0);
    float t2 = remap(sin(vUv.y * 50.0 - time * 2.0), -1.0, 1.0, 0.9, 1.0);

    color = texture2D(diffuse, vUv) * t1 * t2;

    gl_FragColor = color;
}
