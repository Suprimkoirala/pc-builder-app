import type React from "react";
import {
  Cpu,
  HardDrive,
  Monitor,
  Zap,
  Settings,
  ChevronDown,
} from "lucide-react";
import { Card } from "./ui/card";
import { Button } from "./ui/button";
import PCCase from "../assets/pcCase.png";

interface Component {
  name: string;
  icon: React.ReactNode;
  selected: string | null;
  placeholder: string;
}

const PCBuilder = () => {
  const components: Component[] = [
    {
      name: "Case",
      icon: <Monitor className="w-5 h-5" />,
      selected: "iBUYPOWER Element 9 PRO Gaming Case - Black",
      placeholder: "iBUYPOWER Element 9 PRO Gaming Case - Black",
    },
    {
      name: "Processor",
      icon: <Cpu className="w-5 h-5" />,
      selected: null,
      placeholder: "Processor Name",
    },
    {
      name: "Processor Cooling",
      icon: <Settings className="w-5 h-5" />,
      selected: null,
      placeholder: "Cooler name",
    },
    {
      name: "Memory",
      icon: <HardDrive className="w-5 h-5" />,
      selected: null,
      placeholder: "Memory Brand",
    },
    {
      name: "Graphics Card",
      icon: <Monitor className="w-5 h-5" />,
      selected: null,
      placeholder: "GPU",
    },
    {
      name: "Motherboard",
      icon: <Settings className="w-5 h-5" />,
      selected: null,
      placeholder: "Motherboard Name",
    },
    {
      name: "Power Supply",
      icon: <Zap className="w-5 h-5" />,
      selected: null,
      placeholder: "PSU",
    },
  ];

  const recommendations = Array.from({ length: 8 }, (_, index) => ({
    id: index,
    name: "iBUYPOWER Element 9 PRO Gaming Case - Black",
  }));

  return (
    <section id="builder" className="px-6 py-16">
      <div className="max-w-7xl mx-auto">
        <div className="grid lg:grid-cols-3 gap-8">
          <div className="relative">
            <img
              src={PCCase}
              alt="PC Case"
              className="w-90 h-auto rounded-lg"
            />
            <Button className="absolute bottom-4 left-4 bg-emerald-400 hover:bg-emerald-500 text-emerald-900 font-bold">
              COMPATIBILITY CHECKER
            </Button>
          </div>

          <div className="space-y-3">
            {components.map((component, index) => (
              <Card
                key={index}
                className="bg-emerald-200/20 border-emerald-300/30"
              >
                <div className="p-4 flex items-center justify-between cursor-pointer hover:bg-emerald-200/30 transition-colors">
                  <div className="flex items-center space-x-3">
                    <div className="text-emerald-300">{component.icon}</div>
                    <div>
                      <div className="text-white font-semibold">
                        {component.name}
                      </div>
                      <div className="text-emerald-200 text-sm">
                        {component.selected || component.placeholder}
                      </div>
                    </div>
                  </div>
                  <ChevronDown className="w-5 h-5 text-emerald-300" />
                </div>
              </Card>
            ))}
            <div className="flex justify-center pt-4">
              <ChevronDown className="w-6 h-6 text-white" />
            </div>
          </div>

          {/* Recommendations */}
          <div className="space-y-4">
            <h3 className="text-white font-semibold text-lg mb-4">
              Recommendations
            </h3>
            {recommendations.map((item) => (
              <Card
                key={item.id}
                className="bg-white/10 border-white/20 hover:bg-white/20 transition-colors cursor-pointer"
              >
                <div className="p-3">
                  <div className="text-white text-sm">{item.name}</div>
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
