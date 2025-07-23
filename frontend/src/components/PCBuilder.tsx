"use client";

import type React from "react";
import { useState } from "react";
import {
  Cpu,
  Monitor,
  HardDrive,
  Zap,
  Settings,
  MemoryStick,
  CircuitBoardIcon as Motherboard,
  Fan,
} from "lucide-react";
import { Card } from "./ui/card";
import { Button } from "./ui/button";
import PCCase from "../assets/pcCase.png";

// interface Component {
//   name: string;
//   icon: React.ReactNode;
//   selected: string | null;
//   placeholder: string;
// }

interface Component {
  id: string;
  name: string;
  icon: React.ReactNode;
  selected: string | null;
  price: number | null;
  category: string;
}

const PCBuilder = () => {
  const [selectedComponent, setSelectedComponent] = useState<string | null>(
    null
  );
  const [components, setComponents] = useState<Component[]>([
    {
      id: "case",
      name: "Case",
      icon: <Monitor className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "case",
    },
    {
      id: "cpu",
      name: "Processor",
      icon: <Cpu className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "cpu",
    },
    {
      id: "gpu",
      name: "Graphics Card",
      icon: <Monitor className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "gpu",
    },
    {
      id: "motherboard",
      name: "Motherboard",
      icon: <Motherboard className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "motherboard",
    },
    {
      id: "memory",
      name: "Memory",
      icon: <MemoryStick className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "memory",
    },
    {
      id: "storage",
      name: "Storage",
      icon: <HardDrive className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "storage",
    },
    {
      id: "psu",
      name: "Power Supply",
      icon: <Zap className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "psu",
    },
    {
      id: "cooling",
      name: "Cooling",
      icon: <Fan className="w-6 h-6" />,
      selected: null,
      price: null,
      category: "cooling",
    },
  ]);

  const totalPrice = components.reduce(
    (sum, comp) => sum + (comp.price || 0),
    0
  );

  // const recommendations = Array.from({ length: 8 }, (_, index) => ({
  //   id: index,
  //   name: "iBUYPOWER Element 9 PRO Gaming Case - Black",
  // }));

  return (
    <section id="builder" className="py-20 px-6">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="text-4xl md:text-6xl font-bold mb-6">
            BUILD YOUR SYSTEM
          </h2>
          <p className="text-gray-400 text-xl max-w-2xl mx-auto">
            Select components to create your perfect PC configuration
          </p>
        </div>

        <div className="grid lg:grid-cols-3 gap-12">
          {/* 3D Model Placeholder */}
          <div className="lg:col-span-1">
            <div className="sticky top-24">
              <Card className="bg-gray-900 border-gray-800 p-8 h-96 flex items-center justify-center">
                <div className="text-center space-y-4">
                  <div className="w-32 h-32 bg-gray-800 rounded-lg mx-auto flex items-center justify-center">
                    <Settings className="w-16 h-16 text-gray-600" />
                  </div>
                  <p className="text-gray-400">3D Model View</p>
                  <p className="text-sm text-gray-500">
                    Interactive component visualization
                  </p>
                </div>
              </Card>

              {/* Price Summary */}
              <Card className="bg-gray-900 border-gray-800 p-6 mt-6">
                <div className="space-y-4">
                  <h3 className="text-xl font-semibold">Build Summary</h3>
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span className="text-gray-400">Components</span>
                      <span>
                        {components.filter((c) => c.selected).length}/8
                      </span>
                    </div>
                    <div className="flex justify-between text-lg font-semibold border-t border-gray-800 pt-2">
                      <span>Total</span>
                      <span>${totalPrice.toLocaleString()}</span>
                    </div>
                  </div>
                  <Button className="w-full bg-blue-500 hover:bg-blue-600 text-white">
                    Add to Cart
                  </Button>
                </div>
              </Card>
            </div>
          </div>

          {/* Component Selection */}
          <div className="lg:col-span-2 space-y-4">
            {components.map((component) => (
              <Card
                key={component.id}
                className={`bg-gray-900 border-gray-800 hover:border-gray-700 transition-all cursor-pointer ${
                  selectedComponent === component.id ? "border-blue-500" : ""
                }`}
                onClick={() =>
                  setSelectedComponent(
                    selectedComponent === component.id ? null : component.id
                  )
                }
              >
                <div className="p-6">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-4">
                      <div className="text-blue-400">{component.icon}</div>
                      <div>
                        <h3 className="text-lg font-semibold">
                          {component.name}
                        </h3>
                        <p className="text-gray-400 text-sm">
                          {component.selected ||
                            `Select ${component.name.toLowerCase()}`}
                        </p>
                      </div>
                    </div>
                    <div className="text-right">
                      {component.price && (
                        <p className="text-lg font-semibold">
                          ${component.price.toLocaleString()}
                        </p>
                      )}
                      <p className="text-sm text-gray-400">
                        {component.selected ? "Selected" : "Not selected"}
                      </p>
                    </div>
                  </div>

                  {selectedComponent === component.id && (
                    <div className="mt-6 pt-6 border-t border-gray-800">
                      <div className="grid md:grid-cols-2 gap-4">
                        <Button
                          variant="outline"
                          className="border-gray-700 text-gray-900 hover:bg-gray-800 bg-transparent"
                        >
                          View Options
                        </Button>
                        <Button className="bg-blue-500 hover:bg-blue-600 text-gray-900">
                          Select Component
                        </Button>
                      </div>
                    </div>
                  )}
                </div>
              </Card>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};

export default PCBuilder;
