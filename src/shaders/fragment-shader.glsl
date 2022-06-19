uniform sampler2D uDiffuse;

varying vec2 vUv;

void main() {
    gl_FragColor = smoothstep(0.0, 1.0, vec4(texture2D(uDiffuse, vUv)));
}
