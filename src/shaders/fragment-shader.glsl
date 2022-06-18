uniform sampler2D uDiffuse;
uniform sampler2D uOverlay;

varying vec2 vUv;

void main() {
    vec4 diffuseSample = texture2D(uDiffuse, vUv);
    vec4 overlaySample = texture2D(uOverlay, vUv);
    gl_FragColor = mix(diffuseSample, overlaySample, overlaySample.w);
}
