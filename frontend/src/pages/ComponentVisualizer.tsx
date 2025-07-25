"use client";

import { useState, Suspense } from "react";
import { Link } from "react-router-dom";
import { Canvas } from "@react-three/fiber";
import {
  OrbitControls,
  Environment,
  PerspectiveCamera,
} from "@react-three/drei";
import { ArrowLeft, RotateCcw, ZoomIn, ZoomOut } from "lucide-react";
import { useAuthStore } from "../store/authStore";
import { useBuilderStore } from "../store/builderStore";
import { Button } from "../components/ui/button";
import { Card } from "../components/ui/card";
import ComponentModel from "../components/3d/ComponentModel";

const ComponentVisualizerPage = () => {
  const user = useAuthStore((state) => state.user);
  const logout = useAuthStore((state) => state.logout);
  const { selectedComponents } = useBuilderStore();
  const [selectedCategory, setSelectedCategory] = useState<string>("cpu");

  const categories = [
    { id: "cpu", name: "Processor" },
    { id: "gpu", name: "Graphics Card" },
    { id: "motherboard", name: "Motherboard" },
    { id: "memory", name: "Memory" },
    { id: "storage", name: "Storage" },
    { id: "cooling", name: "Cooling" },
  ];

  return (
    <div className="min-h-screen">
      <header className="bg-black/90 backdrop-blur-sm border-b border-gray-800">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center space-x-4">
            <Link to="/builder">
              <Button
                variant="ghost"
                className="text-gray-900 hover:text-black"
              >
                <ArrowLeft className="w-4 h-4 mr-2" />
                Back to Builder
              </Button>
            </Link>
            <div className="flex items-center space-x-2">
              <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center">
                <div className="w-4 h-4 bg-white rounded transform rotate-45"></div>
              </div>
              <div className="text-white font-bold">3D VISUALIZER</div>
            </div>
          </div>

          <div className="flex items-center space-x-4">
            <span className="text-emerald-500 ">Welcome, {user?.username}</span>
            <Button
              variant="ghost"
              onClick={logout}
              className="text-emerald-900  hover:text-black"
            >
              Logout
            </Button>
          </div>
        </div>
      </header>

      <div className="flex h-[calc(100vh-80px)]">
        <div className="flex-1 relative">
          <div className="absolute inset-0 bg-gradient-to-br from-gray-900 to-black">
            <Canvas>
              <PerspectiveCamera makeDefault position={[5, 5, 5]} />
              <OrbitControls
                enablePan={true}
                enableZoom={true}
                enableRotate={true}
              />
              <Environment preset="studio" />
              <ambientLight intensity={0.5} />
              <directionalLight position={[10, 10, 5]} intensity={1} />

              <Suspense fallback={null}>
                <ComponentModel category={selectedCategory} />
              </Suspense>
            </Canvas>
          </div>

          <div className="absolute top-4 right-4 space-y-3">
            <Button
              size="sm"
              className="bg-gray-800 hover:bg-gray-700 text-black"
            >
              <RotateCcw className="w-4 h-4" />
            </Button>
            <Button
              size="sm"
              className="bg-gray-800 hover:bg-gray-700 text-black"
            >
              <ZoomIn className="w-4 h-4" />
            </Button>
            <Button
              size="sm"
              className="bg-gray-800 hover:bg-gray-700 text-black"
            >
              <ZoomOut className="w-4 h-4" />
            </Button>
          </div>

          <div className="absolute bottom-4 left-4 right-4">
            <Card className="bg-black/80 backdrop-blur-sm border-gray-800 p-4">
              <p className="text-center text-white text-lg">
                This is where we can visually see the build from the components
                we plan to use
              </p>
            </Card>
          </div>
        </div>

        <div className="w-80 bg-gray-950 border-l border-gray-800 p-6 overflow-y-auto">
          <h2 className="text-xl font-semibold mb-6">Component Categories</h2>

          <div className="grid grid-cols-2 gap-3">
            {categories.map((category) => {
              const component = selectedComponents[category.id];
              return (
                <Card
                  key={category.id}
                  className={`p-4 cursor-pointer transition-all ${
                    selectedCategory === category.id
                      ? "bg-blue-500/20 border-blue-500"
                      : "bg-gray-800 border-gray-700 hover:bg-gray-700"
                  }`}
                  onClick={() => setSelectedCategory(category.id)}
                >
                  <div className="text-center">
                    <h3 className="font-medium text-sm mb-1">
                      {category.name}
                    </h3>
                    <p className="text-xs text-gray-400">
                      {component ? "Selected" : "Not selected"}
                    </p>
                  </div>
                </Card>
              );
            })}
          </div>

          <div className="mt-8">
            <h3 className="text-lg font-semibold mb-4">Current Selection</h3>
            {selectedComponents[selectedCategory] ? (
              <Card className="bg-gray-800 border-gray-700 p-4">
                <h4 className="font-medium mb-2">
                  {selectedComponents[selectedCategory]?.name}
                </h4>
                <p className="text-sm text-gray-400 mb-2">
                  Category:{" "}
                  {categories.find((c) => c.id === selectedCategory)?.name}
                </p>
                <p className="text-lg font-semibold text-blue-400">
                  $
                  {selectedComponents[selectedCategory]?.price.toLocaleString()}
                </p>
              </Card>
            ) : (
              <Card className="bg-gray-800 border-gray-700 p-4 text-center">
                <p className="text-gray-400">
                  No component selected for this category
                </p>
                <Link to="/builder">
                  <Button
                    size="sm"
                    className="mt-2 bg-blue-500 hover:bg-blue-600 text-black"
                  >
                    Select Component
                  </Button>
                </Link>
              </Card>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ComponentVisualizerPage;
