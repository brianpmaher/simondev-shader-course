uniform float time;

varying vec2 vUv;

float inverseLerp(float v, float minValue, float maxValue) {
    return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
    float t = inverseLerp(v, inMin, inMax);
    return mix(outMin, outMax, t);
}

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 blue = vec3(0.0, 0.0, 1.0);

void main() {
    vec3 color = vec3(0.0);

    float t1 = sin(vUv.x * 100.0);
    float t2 = sin(vUv.y * 100.0);

    color = vec3(max(t1, t2));

    gl_FragColor = vec4(color, 1.0);
}
