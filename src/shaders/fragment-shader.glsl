uniform sampler2D uDiffuse;
uniform vec4 uTint;

varying vec2 vUv;

void main() {
    vec4 diffuseSample = texture2D(uDiffuse, vUv);
    gl_FragColor = vec4(diffuseSample.r);
}
