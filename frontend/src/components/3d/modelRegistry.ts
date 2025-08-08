import { useGLTF } from "@react-three/drei"

export type ModelConfig = {
  url: string
  scale?: [number, number, number]
  position?: [number, number, number]
  rotation?: [number, number, number]
}

// Map each category to a default GLB (one file reused across models of that category)
export const modelRegistry: Record<string, ModelConfig> = {
  // You can replace these URLs with your own files in public/models/*.glb
  // Example: url: "/models/motherboard.glb"
  motherboard: { url: "/assets/3d/duck.glb", scale: [1.2, 1.2, 1.2], position: [0, 0, 0] },
  cpu: { url: "/assets/3d/duck.glb", scale: [0.8, 0.8, 0.8], position: [0, 0, 0] },
  gpu: { url: "/assets/3d/duck.glb", scale: [1.5, 1, 0.8], position: [0, 0, 0] },
  memory: { url: "/assets/3d/duck.glb", scale: [0.6, 0.6, 0.6], position: [0, 0, 0] },
  storage: { url: "/assets/3d/duck.glb", scale: [0.8, 0.8, 0.8], position: [0, 0, 0] },
  psu: { url: "/assets/3d/duck.glb", scale: [1, 1, 1], position: [0, 0, 0] },
  case: { url: "/assets/3d/duck.glb", scale: [1.2, 1.2, 1.2], position: [0, 0, 0] },
  cooling: { url: "/assets/3d/duck.glb", scale: [0.9, 0.9, 0.9], position: [0, 0, 0] },
}

// Optionally preload all default models to speed up switching
Object.values(modelRegistry).forEach((cfg) => {
  try {
    useGLTF.preload(cfg.url)
  } catch {
    // no-op in SSR or outside Canvas; safe to ignore
  }
})
