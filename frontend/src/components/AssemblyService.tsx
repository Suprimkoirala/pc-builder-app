import { Button } from "./ui/button";

const AssemblyService = () => {
  return (
    <section className="px-6 py-16 text-center">
      <div className="max-w-4xl mx-auto space-y-8">
        <h2 className="text-4xl md:text-5xl font-bold text-white tracking-wider">
          WANT US ASSEMBLE YOUR PC?
        </h2>
        <div className="space-y-6 text-emerald-100 text-lg leading-relaxed">
          <p>
            Not sure how to put all the parts together? No worries! Our expert
            team will assemble your custom PC with care and precision—tested,
            optimized, and ready to power on. You choose the parts, we build the
            beast.
          </p>
          <p>
            We know building a PC can be intimidating—cables, compatibility,
            thermal paste, and tiny screws! Let us handle it all for you. Our
            assembly service ensures everything is perfectly installed, neatly
            wired, and fully stress-tested for maximum performance and
            reliability. Enjoy peace of mind knowing your custom rig is in the
            hands of professionals.
          </p>
        </div>
        <Button
          size="lg"
          className="bg-gray-800 hover:bg-gray-700 text-emerald-900 px-8 py-4 text-lg font-semibold"
        >
          ASSEMBLE MY BUILDS
        </Button>
      </div>
    </section>
  );
};

export default AssemblyService;
