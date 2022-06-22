varying vec2 vUv;

void main() {
    vec3 baseColor = vec3(0.5);
    vec3 lighting = vec3(0.0);

    // Ambient
    vec3 ambeint = vec3(0.5);

    lighting = ambeint;

    vec3 color = baseColor * lighting;

    gl_FragColor = vec4(color, 1.0);
}
