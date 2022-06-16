import {
  Color,
  Float32BufferAttribute,
  Mesh,
  OrthographicCamera,
  PlaneGeometry,
  Scene,
  ShaderMaterial,
  Vector4,
  WebGLRenderer,
} from 'three';

const renderer = new WebGLRenderer();
document.body.appendChild(renderer.domElement);
renderer.setSize(window.innerWidth, window.innerHeight);
window.addEventListener('resize', () => renderer.setSize(window.innerWidth, window.innerHeight));

const scene = new Scene();

const camera = new OrthographicCamera(0, 1, 1, 0, 0.1, 1000);
camera.position.set(0, 0, 1);

const vertexShader = await fetch('src/shaders/vertex-shader.glsl').then((r) => r.text());
const fragmentShader = await fetch('src/shaders/fragment-shader.glsl').then((r) => r.text());

const material = new ShaderMaterial({
  uniforms: {
    uColor1: { value: new Vector4(1.0, 1.0, 0.0, 1.0) },
    uColor2: { value: new Vector4(0.0, 1.0, 1.0, 1.0) },
  },
  vertexShader,
  fragmentShader,
});

const colors = [new Color(0xff0000), new Color(0x00ff00), new Color(0x0000ff), new Color(0x00ffff)];
const colorFloats = colors.flatMap((c) => c.toArray());
const geometry = new PlaneGeometry(1, 1);
geometry.setAttribute('aColor', new Float32BufferAttribute(colorFloats, 3));

const plane = new Mesh(geometry, material);
plane.position.set(0.5, 0.5, 0);
scene.add(plane);

let prevDeltaTime!: number;
(function runLoop(deltaTime: number) {
  requestAnimationFrame(runLoop);

  renderer.render(scene, camera);
  prevDeltaTime = deltaTime;
})(0);
