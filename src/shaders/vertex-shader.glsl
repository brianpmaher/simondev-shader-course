varying vec3 vNormal;

void main() {
    vec4 localPosition = vec4(position, 1.0);
    gl_Position = projectionMatrix * modelViewMatrix * localPosition;
    vNormal = (modelMatrix * vec4(normal, 0.0)).xyz;
}
