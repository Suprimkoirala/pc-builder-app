"use client";

import { useRef } from "react";
import { useFrame } from "@react-three/fiber";
import { Box, Sphere, Cylinder } from "@react-three/drei";
import type { Mesh } from "three";

interface ComponentModelProps {
  category: string;
}

const ComponentModel = ({ category }: ComponentModelProps) => {
  const meshRef = useRef<Mesh>(null);

  useFrame((state, delta) => {
    if (meshRef.current) {
      meshRef.current.rotation.y += delta * 0.5;
    }
  });

  const getComponentModel = () => {
    switch (category) {
      case "cpu":
        return (
          <Box ref={meshRef} args={[2, 0.2, 2]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#4ade80" />
          </Box>
        );
      case "gpu":
        return (
          <Box ref={meshRef} args={[3, 1, 0.5]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#ef4444" />
          </Box>
        );
      case "motherboard":
        return (
          <Box ref={meshRef} args={[4, 0.1, 3]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#3b82f6" />
          </Box>
        );
      case "memory":
        return (
          <Box ref={meshRef} args={[0.3, 1.5, 2]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#8b5cf6" />
          </Box>
        );
      case "storage":
        return (
          <Box ref={meshRef} args={[1.5, 0.3, 2.5]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#f59e0b" />
          </Box>
        );
      case "cooling":
        return (
          <Cylinder ref={meshRef} args={[1, 1, 0.5, 8]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#06b6d4" />
          </Cylinder>
        );
      default:
        return (
          <Sphere ref={meshRef} args={[1]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#6b7280" />
          </Sphere>
        );
    }
  };

  return <>{getComponentModel()}</>;
};

export default ComponentModel;
