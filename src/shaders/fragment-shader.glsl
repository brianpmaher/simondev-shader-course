varying vec2 vUv;

float myClamp(float val, float min, float max) {
    if(val < min)
        return min;
    if(val > max)
        return max;
    return val;
}

void main() {
    vec3 color = vec3(0.0);

    float value1 = vUv.x;
    float value2 = myClamp(vUv.x, 0.25, 0.75);

    float line = smoothstep(0.0, 0.005, abs(vUv.y - 0.5));
    float linearLine = smoothstep(0.0, 0.0075, abs(vUv.y - mix(0.5, 1.0, value1)));
    float minLine = smoothstep(0.0, 0.0075, abs(vUv.y - mix(0.0, 0.5, value2)));

    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    vec3 white = vec3(1.0, 1.0, 1.0);

    if(vUv.y > 0.5) {
        color = mix(red, blue, value1);
    } else {
        color = mix(red, blue, value2);
    }

    color = mix(white, color, line);
    color = mix(white, color, linearLine);
    color = mix(white, color, minLine);

    gl_FragColor = vec4(color, 1.0);
}
