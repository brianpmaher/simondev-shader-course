uniform sampler2D diffuse;

varying vec2 vUv;

void main() {
    vec4 diffuseSample = texture2D(diffuse, vec2(vUv.x, 1.0 - vUv.y));
    gl_FragColor = vec4(diffuseSample.g, diffuseSample.g, diffuseSample.g, 1.0);
}
