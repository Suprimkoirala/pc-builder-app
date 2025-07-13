import Header from "./components/Header";
import Hero from "./components/Hero";
import PCBuilder from "./components/PCBuilder";
import AssemblyService from "./components/AssemblyService";
import PastBuilds from "./components/PastBuild";
import DIYResources from "./components/DIYResources";
import Footer from "./components/Footer";

function App() {
  return (
    <div>
      <div className="min-h-screen bg-gradient-to-br from-emerald-900 via-teal-800 to-green-900">
        <Header />
        <Hero />
        <PCBuilder />
        <AssemblyService />
        <PastBuilds />
        <DIYResources />
        <Footer />
      </div>
    </div>
  );
}

export default App;
