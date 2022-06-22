import {
  CubeTextureLoader,
  PerspectiveCamera,
  Scene,
  ShaderMaterial,
  WebGLRenderer,
} from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader';

const renderer = new WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setPixelRatio(2);

document.body.appendChild(renderer.domElement);

const scene = new Scene();

const camera = new PerspectiveCamera(60, 1920.0 / 1080.0, 0.1, 1000.0);
camera.position.set(1, 0, 3);

window.addEventListener('resize', () => {
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
});

const controls = new OrbitControls(camera, renderer.domElement);
controls.target.set(0, 0, 0);
controls.update();

const cubeTextureLoader = new CubeTextureLoader();
const backgroundTexture = cubeTextureLoader.load([
  'assets/textures/Cold_Sunset__Cam_2_Left+X.png',
  'assets/textures/Cold_Sunset__Cam_3_Right-X.png',
  'assets/textures/Cold_Sunset__Cam_4_Up+Y.png',
  'assets/textures/Cold_Sunset__Cam_5_Down-Y.png',
  'assets/textures/Cold_Sunset__Cam_0_Front+Z.png',
  'assets/textures/Cold_Sunset__Cam_1_Back-Z.png',
]);
scene.background = backgroundTexture;

const [vertexShader, fragmentShader] = await Promise.all([
  fetch('src/shaders/vertex-shader.glsl').then(r => r.text()),
  fetch('src/shaders/fragment-shader.glsl').then(r => r.text()),
]);

const material = new ShaderMaterial({
  uniforms: { specMap: { value: scene.background } },
  vertexShader,
  fragmentShader,
});

const gltfLoader = new GLTFLoader();
gltfLoader.setPath('assets/models/');
gltfLoader.load('suzanne.glb', gltf => {
  gltf.scene.traverse((c: any) => {
    c.material = material;
  });
  scene.add(gltf.scene);
});
// const geometry = new IcosahedronGeometry(1, 128);
// const mesh = new Mesh(geometry, material);
// scene.add(mesh);

(function runLoop(t: number) {
  requestAnimationFrame(runLoop);

  renderer.render(scene, camera);
})(0);
