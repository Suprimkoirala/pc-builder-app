"use client";

import { useState } from "react";
import { Link } from "react-router-dom";
import {
  LogOut,
  Eye,
  Cpu,
  Monitor,
  HardDrive,
  Zap,
  Settings,
  MemoryStick,
  CircuitBoardIcon as Motherboard,
  Fan,
} from "lucide-react";
import { useAuthStore } from "../store/authStore";
import { useBuilderStore } from "../store/builderStore";
import { Button } from "../components/ui/button";
import { Card } from "../components/ui/card";

const BuilderPage = () => {
  const { user, logout } = useAuthStore();
  const { selectedComponents, selectComponent, getTotalPrice } =
    useBuilderStore();
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);

  const categories = [
    { id: "cpu", name: "Processor", icon: <Cpu className="w-6 h-6" /> },
    { id: "gpu", name: "Graphics Card", icon: <Monitor className="w-6 h-6" /> },
    {
      id: "motherboard",
      name: "Motherboard",
      icon: <Motherboard className="w-6 h-6" />,
    },
    { id: "memory", name: "Memory", icon: <MemoryStick className="w-6 h-6" /> },
    { id: "storage", name: "Storage", icon: <HardDrive className="w-6 h-6" /> },
    { id: "psu", name: "Power Supply", icon: <Zap className="w-6 h-6" /> },
    { id: "case", name: "Case", icon: <Settings className="w-6 h-6" /> },
    { id: "cooling", name: "Cooling", icon: <Fan className="w-6 h-6" /> },
  ];

  // Mock component data
  const mockComponents = {
    cpu: [
      {
        id: "cpu1",
        name: "Intel Core i9-13900K",
        category: "cpu",
        price: 589,
        model: "13th Gen",
      },
      {
        id: "cpu2",
        name: "AMD Ryzen 9 7950X",
        category: "cpu",
        price: 699,
        model: "Zen 4",
      },
    ],
    gpu: [
      {
        id: "gpu1",
        name: "NVIDIA RTX 4090",
        category: "gpu",
        price: 1599,
        model: "Ada Lovelace",
      },
      {
        id: "gpu2",
        name: "AMD RX 7900 XTX",
        category: "gpu",
        price: 999,
        model: "RDNA 3",
      },
    ],
    // Add more mock data for other categories...
  };

  return (
    <div className="min-h-screen">
      {/* Header */}
      <header className="bg-black/90 backdrop-blur-sm border-b border-gray-800">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center space-x-2">
            <div className="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center">
              <div className="w-6 h-6 bg-white rounded transform rotate-45"></div>
            </div>
            <div className="text-white font-bold text-xl">DREAM BUILDERS</div>
          </div>

          <div className="flex items-center space-x-4">
            <span className="text-gray-300">Welcome, {user?.username}</span>
            <Link to="/visualizer">
              <Button className="bg-blue-500 hover:bg-blue-600 text-gray-900">
                <Eye className="w-4 h-4 mr-2" />
                3D Visualizer
              </Button>
            </Link>
            <Button
              variant="ghost"
              onClick={logout}
              className="text-gray-900 hover:text-black"
            >
              <LogOut className="w-4 h-4 mr-2" />
              Logout
            </Button>
          </div>
        </div>
      </header>

      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="mb-8">
          <h1 className="text-4xl font-bold mb-4">PC Builder</h1>
          <p className="text-gray-400">
            Select components to build your perfect PC
          </p>
        </div>

        <div className="grid lg:grid-cols-3 gap-8">
          {/* Component Categories */}
          <div className="lg:col-span-2 space-y-4">
            {categories.map((category) => {
              const selectedComponent = selectedComponents[category.id];
              return (
                <Card
                  key={category.id}
                  className={`bg-gray-900 border-gray-800 hover:border-gray-700 transition-all cursor-pointer ${
                    selectedCategory === category.id ? "border-blue-500" : ""
                  }`}
                  onClick={() =>
                    setSelectedCategory(
                      selectedCategory === category.id ? null : category.id
                    )
                  }
                >
                  <div className="p-6">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center space-x-4">
                        <div className="text-blue-400">{category.icon}</div>
                        <div>
                          <h3 className="text-lg font-semibold">
                            {category.name}
                          </h3>
                          <p className="text-gray-400 text-sm">
                            {selectedComponent
                              ? selectedComponent.name
                              : `Select ${category.name.toLowerCase()}`}
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        {selectedComponent && (
                          <p className="text-lg font-semibold">
                            ${selectedComponent.price.toLocaleString()}
                          </p>
                        )}
                        <p className="text-sm text-gray-400">
                          {selectedComponent ? "Selected" : "Not selected"}
                        </p>
                      </div>
                    </div>

                    {selectedCategory === category.id && (
                      <div className="mt-6 pt-6 border-t border-gray-800">
                        <div className="space-y-3">
                          {(
                            mockComponents[
                              category.id as keyof typeof mockComponents
                            ] || []
                          ).map((component) => (
                            <div
                              key={component.id}
                              className="flex items-center justify-between p-3 bg-gray-800 rounded-lg hover:bg-gray-700 cursor-pointer"
                              onClick={(e) => {
                                e.stopPropagation();
                                selectComponent(category.id, component);
                                setSelectedCategory(null);
                              }}
                            >
                              <div>
                                <p className="font-medium">{component.name}</p>
                                <p className="text-sm text-gray-400">
                                  {component.model}
                                </p>
                              </div>
                              <p className="font-semibold">
                                ${component.price.toLocaleString()}
                              </p>
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                </Card>
              );
            })}
          </div>

          {/* Build Summary */}
          <div className="space-y-6">
            <Card className="bg-gray-900 border-gray-800 p-6 sticky top-6">
              <h3 className="text-xl font-semibold mb-4">Build Summary</h3>
              <div className="space-y-4">
                <div className="space-y-2">
                  {Object.entries(selectedComponents).map(
                    ([category, component]) => (
                      <div
                        key={category}
                        className="flex justify-between text-sm"
                      >
                        <span className="text-gray-300 capitalize">
                          {category}
                        </span>
                        <span>
                          {component
                            ? `$${component.price.toLocaleString()}`
                            : "-"}
                        </span>
                      </div>
                    )
                  )}
                </div>
                <div className="border-t border-gray-800 pt-4">
                  <div className="flex justify-between text-lg font-semibold">
                    <span>Total</span>
                    <span>${getTotalPrice().toLocaleString()}</span>
                  </div>
                </div>
                <div className="space-y-3">
                  <Link to="/visualizer">
                    <Button className="w-full bg-blue-500 hover:bg-blue-600 text-emerald-900">
                      <Eye className="w-4 h-4 mr-2" />
                      View in 3D
                    </Button>
                  </Link>
                  <Button
                    variant="outline"
                    className="w-full border-gray-700 text-emerald-900 hover:bg-gray-800 hover:text-black bg-transparent mt-4"
                  >
                    Save Build
                  </Button>
                </div>
              </div>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
};

export default BuilderPage;
