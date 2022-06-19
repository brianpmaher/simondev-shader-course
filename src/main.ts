import {
  Mesh,
  OrthographicCamera,
  PCFSoftShadowMap,
  PlaneGeometry,
  Scene,
  ShaderMaterial,
  Vector2,
  WebGLRenderer,
} from 'three';

const renderer = new WebGLRenderer({ antialias: true });
renderer.shadowMap.enabled = true;
renderer.shadowMap.type = PCFSoftShadowMap;
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);

document.body.appendChild(renderer.domElement);
window.addEventListener('resize', () =>
  renderer.setSize(window.innerWidth, window.innerHeight),
);

const scene = new Scene();

const camera = new OrthographicCamera(0, 1, 1, 0, 0.1, 1000);
camera.position.set(0, 0, 1);

const vertexShader = await fetch('src/shaders/vertex-shader.glsl').then((r) =>
  r.text(),
);
const fragmentShader = await fetch('src/shaders/fragment-shader.glsl').then(
  (r) => r.text(),
);

const material = new ShaderMaterial({
  uniforms: {
    resolution: { value: new Vector2(window.innerWidth, window.innerHeight) },
  },
  vertexShader,
  fragmentShader,
});
window.addEventListener('resize', () => {
  const resolution = material.uniforms.resolution.value;
  (resolution as Vector2).set(window.innerWidth, window.innerHeight);
});

const geometry = new PlaneGeometry(1, 1);

const plane = new Mesh(geometry, material);
plane.position.set(0.5, 0.5, 0);
scene.add(plane);

let prevDeltaTime!: number;
(function runLoop(deltaTime: number) {
  requestAnimationFrame(runLoop);

  renderer.render(scene, camera);

  prevDeltaTime = deltaTime;
})(0);
