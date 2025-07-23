"use client";

import { ArrowRight } from "lucide-react";
import { Button } from "./ui/button";
import pcImage from "../assets/pc.png";

const Hero = () => {
  return (
    <section className="min-h-screen flex justify-center px-6 pt-20">
      <div className="pt-32 w-full">
        <div className="max-w-7xl mx-auto text-center space-y-12">
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

            <div className="flex flex-col md:flex-row md:items-center md:justify-between max-w-4xl mx-auto">
              <p className="text-gray-400 text-lg md:text-xl font-light max-w-md">
                WE ENGINEER, BUILD AND
                <br />
                OPTIMIZE EXCEPTIONAL COMPUTERS
              </p>
              <div className="flex flex-col sm:flex-row gap-4">
                <Button
                  className="bg-blue-500 hover:bg-blue-600 text-white px-8 py-4 text-lg font-medium mt-8 md:mt-0"
                  onClick={() =>
                    document
                      .getElementById("builder")
                      ?.scrollIntoView({ behavior: "smooth" })
                  }
                >
                  EXPLORE COMPONENTS
                  <ArrowRight className="w-5 h-5 ml-2" />
                </Button>
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
  );
};

export default Hero;
