import {
  Mesh,
  OrthographicCamera,
  PCFSoftShadowMap,
  PlaneGeometry,
  Scene,
  ShaderMaterial,
  TextureLoader,
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

const textureLoader = new TextureLoader();
const lakeTexture = textureLoader.load('assets/textures/hebgen-lake.jpg');

const material = new ShaderMaterial({
  uniforms: {
    diffuse: { value: lakeTexture },
    time: { value: 0.0 },
  },
  vertexShader,
  fragmentShader,
});

const geometry = new PlaneGeometry(1, 1);

const plane = new Mesh(geometry, material);
plane.position.set(0.5, 0.5, 0);
scene.add(plane);

(function runLoop(t: number) {
  requestAnimationFrame(runLoop);

  material.uniforms.time.value = t * 0.001;

  renderer.render(scene, camera);
})(0);
