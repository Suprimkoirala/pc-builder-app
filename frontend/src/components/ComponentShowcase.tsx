import { ArrowRight } from "lucide-react";
import { Card } from "./ui/card";
import { Button } from "./ui/button";

const ComponentShowcase = () => {
  const categories = [
    {
      name: "Processors",
      description: "High-performance CPUs for every need",
      image: "/placeholder.svg?height=300&width=400",
      count: "50+ options",
    },
    {
      name: "Graphics Cards",
      description: "Cutting-edge GPUs for gaming and work",
      image: "/placeholder.svg?height=300&width=400",
      count: "30+ options",
    },
    {
      name: "Memory",
      description: "Fast and reliable RAM modules",
      image: "/placeholder.svg?height=300&width=400",
      count: "25+ options",
    },
    {
      name: "Storage",
      description: "SSDs and HDDs for all your data",
      image: "/placeholder.svg?height=300&width=400",
      count: "40+ options",
    },
  ];

  return (
    <section id="components" className="py-20 px-6 bg-gray-950">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="text-4xl md:text-6xl font-bold mb-6">
            COMPONENT CATALOG
          </h2>
          <p className="text-gray-400 text-xl max-w-2xl mx-auto">
            Explore our extensive collection of premium PC components
          </p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          {categories.map((category, index) => (
            <Card
              key={index}
              className="bg-black border-gray-800 hover:border-gray-700 transition-all group"
            >
              <div className="p-6 space-y-4">
                <div className="aspect-video bg-gray-900 rounded-lg overflow-hidden">
                  <img
                    src={category.image || "/placeholder.svg"}
                    alt={category.name}
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                  />
                </div>
                <div className="space-y-2">
                  <h3 className="text-xl font-semibold">{category.name}</h3>
                  <p className="text-gray-400 text-sm">
                    {category.description}
                  </p>

                  <p className="text-blue-400 text-sm font-medium">
                    {category.count}
                  </p>
                </div>
                <Button
                  variant="ghost"
                  className="w-full justify-between text-emerald-900 font-semibold hover:text-black hover:bg-gray-900"
                >
                  Explore
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};

export default ComponentShowcase;
