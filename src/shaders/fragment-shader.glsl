varying vec2 vUv;

void main() {
    vec3 color = vec3(0.0);

    float stepValue = step(0.5, vUv.x);
    float linearValue = vUv.x;
    float smoothValue = smoothstep(0.0, 1.0, vUv.x);

    float topThird = 2.0 / 3.0;
    float bottomThird = 1.0 / 3.0;

    float topDivider = smoothstep(0.0, 0.005, abs(vUv.y - topThird));
    float bottomDivider = smoothstep(0.0, 0.005, abs(vUv.y - bottomThird));

    float stepLine = smoothstep(0.0, 0.0075, abs(vUv.y - mix(topThird, 1.0, stepValue)));
    float linearLine = smoothstep(0.0, 0.0075, abs(vUv.y - mix(bottomThird, topThird, linearValue)));
    float smoothLine = smoothstep(0.0, 0.0075, abs(vUv.y - mix(0.0, bottomThird, smoothValue)));

    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    vec3 white = vec3(1.0, 1.0, 1.0);

    if(vUv.y > topThird) {
        color = mix(red, blue, step(0.5, stepValue));
    } else if(vUv.y > bottomThird) {
        color = mix(red, blue, vUv.x);
    } else {
        color = mix(red, blue, smoothstep(0.0, 1.0, vUv.x));
    }

    color = mix(white, color, bottomDivider);
    color = mix(white, color, topDivider);

    color = mix(white, color, stepLine);
    color = mix(white, color, linearLine);
    color = mix(white, color, smoothLine);

    gl_FragColor = vec4(color, 1.0);
}
