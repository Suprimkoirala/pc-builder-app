import { Card } from "./ui/card";
import { Button } from "./ui/button";

interface Build {
  id: number;
  title: string;
  image: string;
  lighting: string;
}

const PastBuilds = () => {
  const pastBuilds: Build[] = [
    {
      id: 1,
      title: "RTX 4050 + Ryzen 9 9950x3d + Trident Z 32 GB RAM",
      image: "/placeholder.svg?height=300&width=300",
      lighting: "RGB Multi-Color",
    },
    {
      id: 2,
      title: "RTX 4050 + Ryzen 9 9950x3d + Trident Z 32 GB RAM",
      image: "/placeholder.svg?height=300&width=300",
      lighting: "White/Blue Theme",
    },
    {
      id: 3,
      title: "RTX 4050 + Ryzen 9 9950x3d + Trident Z 32 GB RAM",
      image: "/placeholder.svg?height=300&width=300",
      lighting: "Purple Theme",
    },
    {
      id: 4,
      title: "RTX 4050 + Ryzen 9 9950x3d + Trident Z 32 GB RAM",
      image: "/placeholder.svg?height=300&width=300",
      lighting: "Orange/Yellow Theme",
    },
  ];

  return (
    <section id="past-builds" className="px-6 py-16">
      <div className="max-w-7xl mx-auto">
        <h2 className="text-4xl md:text-5xl font-bold text-white text-center mb-12 tracking-wider">
          PAST BUILDS
        </h2>
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          {pastBuilds.map((build) => (
            <Card
              key={build.id}
              className="bg-black/40 border-emerald-300/30 overflow-hidden hover:bg-black/50 transition-colors"
            >
              <div className="relative">
                <img
                  src={build.image || "/placeholder.svg"}
                  alt={`Gaming PC Build ${build.id}`}
                  className="w-full h-48 object-cover"
                />
              </div>
              <div className="p-4 space-y-3">
                <h3 className="text-white font-semibold text-sm leading-tight">
                  {build.title}
                </h3>
                <Button
                  size="sm"
                  className="w-full bg-emerald-400 hover:bg-emerald-500 text-emerald-900 font-semibold"
                >
                  Customize this Build
                </Button>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};

export default PastBuilds;
