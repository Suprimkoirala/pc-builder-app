"use client";

import { useEffect, useMemo, useRef } from "react";
import { useFrame } from "@react-three/fiber";
import { useGLTF, Box, Sphere, Cylinder } from "@react-three/drei";
import type { Mesh, MeshStandardMaterial, Object3D } from "three";
import { useBuilderStore } from "../../store/builderStore";

const CATEGORY_MODEL_MAP: Record<string, string> = {
  motherboard: "/models/motherboard.glb",
  cpu: "/models/cpu.glb",
  gpu: "/models/gpu.glb",
  memory: "/models/memory.glb",
  storage: "/models/storage.glb",
  psu: "/models/psu.glb",
  case: "/models/case.glb",
  cooling: "/models/cooling.glb",
};

const TRANSFORMS: Record<
  string,
  {
    scale?: [number, number, number];
    position?: [number, number, number];
    rotation?: [number, number, number];
  }
> = {
  motherboard: { scale: [1.2, 1.2, 1.2] },
  cpu: { scale: [2, 2, 2] },
  gpu: { scale: [1.1, 1.1, 1.1] },
  memory: { scale: [1, 1, 1] },
  storage: { scale: [1, 1, 1] },
  psu: { scale: [1, 1, 1] },
  case: { scale: [1.2, 1.2, 1.2] },
  cooling: { scale: [1, 1, 1] },
};

function colorFromString(input: string) {
  let hash = 0;
  for (let i = 0; i < input.length; i++)
    hash = input.charCodeAt(i) + ((hash << 5) - hash);
  const hue = Math.abs(hash) % 360;
  return `hsl(${hue}, 70%, 55%)`;
}

interface Props {
  category: string;
}

export default function ComponentModel({ category }: Props) {
  const meshRef = useRef<Mesh>(null);

  const selected = useBuilderStore((s) => s.selectedComponents[category]);
  const tint = useMemo(
    () => (selected?.id ? colorFromString(selected.id) : undefined),
    [selected?.id]
  );

  const url = CATEGORY_MODEL_MAP[category];
  const transform = TRANSFORMS[category] || {};

  if (!url) {
    // fallback primitives (keep the existing switch below)
    useFrame((_, delta) => {
      if (meshRef.current) meshRef.current.rotation.y += delta * 0.4;
    });

    switch (category) {
      case "cpu":
        return (
          <Box ref={meshRef} args={[2, 0.2, 2]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#4ade80"} />
          </Box>
        );
      case "gpu":
        return (
          <Box ref={meshRef} args={[3, 1, 0.5]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#ef4444"} />
          </Box>
        );
      case "motherboard":
        return (
          <Box ref={meshRef} args={[4, 0.1, 3]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#3b82f6"} />
          </Box>
        );
      case "memory":
        return (
          <Box ref={meshRef} args={[0.3, 1.5, 2]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#8b5cf6"} />
          </Box>
        );
      case "storage":
        return (
          <Box ref={meshRef} args={[1.5, 0.3, 2.5]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#f59e0b"} />
          </Box>
        );
      case "cooling":
        return (
          <Cylinder ref={meshRef} args={[1, 1, 0.5, 8]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#06b6d4"} />
          </Cylinder>
        );
      default:
        return (
          <Sphere ref={meshRef} args={[1]} position={[0, 0, 0]}>
            <meshStandardMaterial color={tint || "#6b7280"} />
          </Sphere>
        );
    }
  }

  const gltf = useGLTF(url) as unknown as { scene: Object3D };

  useEffect(() => {
    if (!tint) return;
    gltf.scene.traverse((child) => {
      const mat = (child as Mesh).material as
        | MeshStandardMaterial
        | MeshStandardMaterial[]
        | undefined;
      if (!mat) return;
      if (Array.isArray(mat)) mat.forEach((m) => m?.color?.set?.(tint));
      else (mat as MeshStandardMaterial)?.color?.set?.(tint);
    });
  }, [gltf.scene, tint]);

  return (
    <primitive
      object={gltf.scene}
      scale={transform.scale || [1, 1, 1]}
      position={transform.position || [0, 0, 0]}
      rotation={transform.rotation || [0, 0, 0]}
    />
  );
}
