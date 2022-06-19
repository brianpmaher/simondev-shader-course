uniform vec2 resolution;

varying vec2 vUv;

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 green = vec3(0.0, 1.0, 0.0);
vec3 blue = vec3(0.0, 0.0, 1.0);
vec3 white = vec3(1.0);
vec3 black = vec3(0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);

void main() {
    vec3 color = vec3(0.75);

    vec2 center = vUv - 0.5;
    vec2 cell = fract(center * resolution / 100.0);
    cell = abs(cell - 0.5);
    float distToCell = 1.0 - 2.0 * max(cell.x, cell.y);

    float cellLine = smoothstep(0.0, 0.05, distToCell);

    float xAxis = smoothstep(0.0, 0.002, abs(center.y));
    float yAxis = smoothstep(0.0, 0.002, abs(center.x));

    // Lines
    vec2 pos = center * resolution / 100.0;
    float value1 = pos.x;
    float value2 = fract(pos.x);
    float functionLine1 = smoothstep(0.0, 0.075, abs(pos.y - value1));
    float functionLine2 = smoothstep(0.0, 0.075, abs(pos.y - value2));

    color = mix(black, color, cellLine);
    color = mix(blue, color, xAxis);
    color = mix(blue, color, yAxis);
    color = mix(yellow, color, functionLine1);
    color = mix(red, color, functionLine2);

    gl_FragColor = vec4(color, 1.0);
}
