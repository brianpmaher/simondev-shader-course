varying vec2 vUv;

void main() {
    vec3 color = vec3(0.0);

    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);

    color = mix(red, blue, vec3(vUv.x));
    gl_FragColor = vec4(color, 1.0);
}
