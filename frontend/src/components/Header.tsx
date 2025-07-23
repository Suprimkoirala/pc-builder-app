"use client";

import { Menu, X } from "lucide-react";
import { Button } from "./ui/button";
import { useAuth } from "../context/AuthContext";
import { useState } from "react";

const Header = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const { currentUser, login, register, logout } = useAuth();
  const [showAuthModal, setShowAuthModal] = useState(false);
  const [isLoginMode, setIsLoginMode] = useState(true);
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    username: "",
    confirmPassword: "",
  });

  const handleInputChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (isLoginMode) {
      await login(formData.email, formData.password);
    } else {
      if (formData.password !== formData.confirmPassword) {
        alert("Passwords don't match");
        return;
      }
      await register(formData.username, formData.email, formData.password);
    }
    setShowAuthModal(false);
    setFormData({ ...formData, password: "", confirmPassword: "" });
  };

  const scrollToSection = (sectionId) => {
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
    setIsMenuOpen(false);
  };

  return (
    <>
      <header className="fixed top-0 left-0 right-0 z-50 bg-black/90 backdrop-blur-sm border-b border-gray-800">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          {/* Logo */}
          <div className="flex items-center space-x-2">
            <div className="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center">
              <div className="w-6 h-6 bg-white rounded transform rotate-45"></div>
            </div>
            <div className="text-white font-bold text-xl">DREAM BUILDERS</div>
          </div>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center space-x-8">
            <button
              onClick={() => scrollToSection("builder")}
              className="text-emerald-900 hover:text-white transition-colors text-sm font-medium"
            >
              PC Builder
            </button>
            <button
              onClick={() => scrollToSection("components")}
              className="text-emerald-900  hover:text-white transition-colors text-sm font-medium"
            >
              Components
            </button>
            <button
              onClick={() => scrollToSection("builds")}
              className="text-emerald-900  hover:text-white transition-colors text-sm font-medium"
            >
              Past Builds
            </button>
            <button
              onClick={() => scrollToSection("about")}
              className="text-emerald-900  hover:text-white transition-colors text-sm font-medium"
            >
              About
            </button>
          </nav>

          {/* Right side */}
          <div className="flex items-center space-x-4">
            <button
              onClick={() => setIsMenuOpen(!isMenuOpen)}
              className="text-emerald-900 font-semibold hover:text-black transition-colors"
            >
              {isMenuOpen ? (
                <X className="w-6 h-6" />
              ) : (
                <Menu className="w-6 h-6" />
              )}
            </button>
          </div>

          {/* Mobile Menu */}
          {isMenuOpen && (
            <div className="md:hidden bg-black border-t border-gray-800">
              <div className="px-6 py-4 space-y-4">
                <button
                  onClick={() => scrollToSection("builder")}
                  className="block text-emerald-900 font-semibold hover:text-black transition-colors text-sm"
                >
                  PC Builder
                </button>
                <button
                  onClick={() => scrollToSection("components")}
                  className="block text-emerald-900 font-semibold hover:text-black transition-colors text-sm"
                >
                  Components
                </button>
                <button
                  onClick={() => scrollToSection("builds")}
                  className="block text-emerald-900 font-semibold hover:text-black transition-colors text-sm "
                >
                  Past Builds
                </button>
                <button
                  onClick={() => scrollToSection("about")}
                  className="block text-emerald-900 font-semibold hover:text-black transition-colors text-sm "
                >
                  About
                </button>
                <Button
                  variant="ghost"
                  className="text-emerald-900 font-semibold hover:text-black"
                >
                  Contact
                </Button>
              </div>
            </div>
          )}

          <div className="flex items-center space-x-4">
            {currentUser ? (
              <div className="flex items-center space-x-4">
                <span className="text-emerald-300">{currentUser.username}</span>
                <Button
                  variant="ghost"
                  className="bg-red-400 hover:bg-red-500 text-emerald-900 font-semibold"
                  onClick={logout}
                >
                  Logout
                </Button>
              </div>
            ) : (
              <>
                <Button
                  variant="ghost"
                  className="bg-emerald-400 hover:text-black text-emerald-900 font-semibold"
                  onClick={() => {
                    setIsLoginMode(true);
                    setShowAuthModal(true);
                  }}
                >
                  Login
                </Button>
                <Button
                  className="bg-emerald-400 hover:text-black text-emerald-900 font-semibold"
                  onClick={() => {
                    setIsLoginMode(false);
                    setShowAuthModal(true);
                  }}
                >
                  Sign up
                </Button>
              </>
            )}
          </div>
        </div>
      </header>

      {/* Auth Modal */}
      {showAuthModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-white text-gray-900 rounded-lg p-6 w-full max-w-md">
            <h2 className="text-2xl font-bold mb-4 text-center text-emerald-600">
              {isLoginMode ? "Login" : "Create Account"}
            </h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              {!isLoginMode && (
                <div>
                  <label className="block text-sm font-medium mb-1">
                    Username
                  </label>
                  <input
                    type="text"
                    name="username"
                    value={formData.username}
                    onChange={handleInputChange}
                    required={!isLoginMode}
                    className="w-full px-3 py-2 border rounded-md"
                  />
                </div>
              )}
              <div>
                <label className="block text-sm font-medium mb-1">Email</label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleInputChange}
                  required
                  className="w-full px-3 py-2 border rounded-md"
                />
              </div>
              <div>
                <label className="block text-sm font-medium mb-1">
                  Password
                </label>
                <input
                  type="password"
                  name="password"
                  autoComplete="current-password" // for login
                  value={formData.password}
                  onChange={handleInputChange}
                  required
                  className="w-full px-3 py-2 border rounded-md"
                />
              </div>
              {!isLoginMode && (
                <div>
                  <label className="block text-sm font-medium mb-1">
                    Confirm Password
                  </label>
                  <input
                    type="password"
                    name="confirmPassword"
                    autoComplete="new-password" // for login
                    value={formData.confirmPassword}
                    onChange={handleInputChange}
                    required
                    className="w-full px-3 py-2 border rounded-md"
                  />
                </div>
              )}
              <div className="pt-2 flex justify-between">
                <button
                  type="button"
                  onClick={() => setIsLoginMode(!isLoginMode)}
                  className="text-emerald-600 hover:underline"
                >
                  {isLoginMode
                    ? "Need an account?"
                    : "Already have an account?"}
                </button>
                <Button
                  type="submit"
                  className="bg-emerald-400 hover:bg-emerald-500 text-emerald-900"
                >
                  {isLoginMode ? "Login" : "Sign Up"}
                </Button>
              </div>
            </form>
            <button
              onClick={() => setShowAuthModal(false)}
              className="absolute top-2 right-2 text-emerald-900 font-semibold hover:text-black"
            >
              &times;
            </button>
          </div>
        </div>
      )}
    </>
  );
};

export default Header;
