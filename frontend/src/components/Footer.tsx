const Footer = () => {
  return (
    <footer className="py-12 px-6 border-t border-gray-800">
      <div className="max-w-7xl mx-auto">
        <div className="grid md:grid-cols-4 gap-8">
          <div className="space-y-4">
            <div className="flex items-center space-x-2">
              <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center">
                <div className="w-4 h-4 bg-white rounded transform rotate-45"></div>
              </div>
              <div className="text-white font-bold">DREAM BUILDERS</div>
            </div>
            <p className="text-gray-400 text-sm">
              Engineering exceptional PC builds for enthusiasts and
              professionals.
            </p>
          </div>

          <div className="space-y-4">
            <h4 className="text-white font-semibold">Products</h4>
            <div className="space-y-2 text-sm">
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                PC Builder
              </a>
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Components
              </a>
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Pre-built PCs
              </a>
            </div>
          </div>

          <div className="space-y-4">
            <h4 className="text-white font-semibold">Support</h4>
            <div className="space-y-2 text-sm">
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Documentation
              </a>
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Compatibility
              </a>
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Assembly Service
              </a>
            </div>
          </div>

          <div className="space-y-4">
            <h4 className="text-white font-semibold">Company</h4>
            <div className="space-y-2 text-sm">
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                About
              </a>
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Careers
              </a>
              <a
                href="#"
                className="block text-gray-400 hover:text-white transition-colors"
              >
                Contact
              </a>
            </div>
          </div>
        </div>

        <div className="border-t border-gray-800 mt-12 pt-8 text-center">
          <p className="text-gray-400 text-sm">
            © 2024 Dream Builders. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
