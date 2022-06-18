uniform sampler2D uDiffuse;
uniform sampler2D uOverlay;

varying vec2 vUv;

void main() {
    vec2 uv = vUv / 10.0;
    vec4 diffuseSample = texture2D(uDiffuse, uv);
    vec4 overlaySample = texture2D(uOverlay, uv);
    gl_FragColor = diffuseSample;
}
