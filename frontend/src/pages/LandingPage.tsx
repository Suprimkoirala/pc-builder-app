import { ArrowRight, Cpu, Monitor, Zap, Shield } from "lucide-react";
import { Link } from "react-router-dom";
import { Button } from "../components/ui/button";
import { Card } from "../components/ui/card";
import pcImage from "../assets/pc.png";

const LandingPage = () => {
  const features = [
    {
      icon: <Cpu className="w-8 h-8" />,
      title: "Component Selection",
      description:
        "Choose from thousands of verified PC components with real-time compatibility checking.",
    },
    {
      icon: <Monitor className="w-8 h-8" />,
      title: "3D Visualization",
      description:
        "See your build come to life with interactive 3D models and realistic rendering.",
    },
    {
      icon: <Zap className="w-8 h-8" />,
      title: "Performance Analysis",
      description:
        "Get detailed performance metrics and optimization suggestions for your build.",
    },
    {
      icon: <Shield className="w-8 h-8" />,
      title: "Compatibility Guarantee",
      description:
        "Our advanced algorithms ensure all selected components work perfectly together.",
    },
  ];

  return (
    <div className="min-h-screen">
      {/* Header */}
      <header className="fixed top-0 left-0 right-0 z-50 bg-black/90 backdrop-blur-sm border-b border-gray-800">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center space-x-2">
            <div className="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center">
              <div className="w-6 h-6 bg-white rounded transform rotate-45"></div>
            </div>
            <div className="text-white font-bold text-xl">DREAM BUILDERS</div>
          </div>

          <div className="flex items-center space-x-4">
            <Link to="/login">
              <Button
                variant="ghost"
                className="text-emerald-900  hover:text-black"
              >
                Login
              </Button>
            </Link>
            <Link to="/signup">
              <Button className="bg-blue-500 hover:text-black text-emerald-900 ">
                Sign Up
              </Button>
            </Link>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="min-h-screen flex items-center justify-center px-6 pt-20">
        <div className="max-w-7xl mx-auto text-center space-y-12">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between max-w-4xl mx-auto">
            <div className="space-y-8">
              <h1 className="text-5xl md:text-7xl lg:text-8xl font-bold tracking-tight leading-none">
                BUILDING
                <br />
                <span className="text-white">PERFORMANCE</span>
                <br />
                UNIVERSALLY
                <br />
                <span className="text-white">ACCESSIBLE</span>
              </h1>

              <div className="flex flex-col md:flex-row md:items-center md:justify-between max-w-4xl gap-6 mx-auto">
                <div>
                  <p className="text-gray-400 text-lg md:text-xl font-light max-w-md">
                    WE ENGINEER, BUILD AND
                    <br />
                    OPTIMIZE EXCEPTIONAL COMPUTERS
                  </p>

                  <Link to="/signup">
                    <Button className="bg-blue-500 hover:text-black text-emerald-900 px-8 py-4 text-lg font-medium mt-8 md:mt-0">
                      START BUILDING
                      <ArrowRight className="w-5 h-5 ml-2" />
                    </Button>
                  </Link>
                </div>
              </div>
            </div>
            <div className="relative ml-40 mr-auto">
              <img
                src={pcImage}
                alt="Gaming PC with RGB lighting"
                className="w-95 h-auto"
              />
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 px-6 bg-gray-950">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-6xl font-bold mb-6">
              WHY CHOOSE US
            </h2>
            <p className="text-gray-400 text-xl max-w-2xl mx-auto">
              Experience the future of PC building with our advanced tools and
              expert guidance
            </p>
          </div>

          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
            {features.map((feature, index) => (
              <Card
                key={index}
                className="bg-black border-gray-800 p-6 text-center space-y-4"
              >
                <div className="text-blue-400 flex justify-center">
                  {feature.icon}
                </div>
                <h3 className="text-xl font-semibold">{feature.title}</h3>
                <p className="text-gray-400 text-sm">{feature.description}</p>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-6 text-center">
        <div className="max-w-4xl mx-auto space-y-8">
          <h2 className="text-4xl md:text-5xl font-bold">READY TO BUILD?</h2>
          <p className="text-gray-400 text-xl">
            Join thousands of builders who trust our platform for their PC
            builds
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/signup">
              <Button className="bg-blue-500 hover:bg-blue-600 hover:text-black text-emerald-900 px-8 py-4 text-lg">
                Get Started Free
              </Button>
            </Link>
            <Link to="/login">
              <Button
                variant="outline"
                className="border-gray-700 hover:text-black text-emerald-900 px-8 py-4 text-lg bg-transparent"
              >
                Sign In
              </Button>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
};

export default LandingPage;
