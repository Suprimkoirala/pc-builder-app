import { createContext, useState, useEffect, useContext } from "react";
import axios from "axios";

interface User {
  id: number;
  username: string;
  email: string;
  // add more if needed
}

interface AuthContextType {
  currentUser: User | null;
  login: (email: string, password: string) => Promise<any>;
  register: (username: string, email: string, password: string) => Promise<any>;
  logout: () => Promise<void>;
  isAuthenticated: boolean;
  loading: boolean;
}

// eslint-disable-next-line react-refresh/only-export-components
export const AuthContext = createContext<AuthContextType | undefined>(
  undefined
);

export const AuthProvider = ({ children }) => {
  const [currentUser, setCurrentUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;
      // Get user info
      axios
        .get("/api/v1/users/me/")
        .then((response) => {
          setCurrentUser(response.data);
          setLoading(false);
        })
        .catch((error) => {
          console.error("Auth error:", error);
          localStorage.removeItem("token");
          delete axios.defaults.headers.common["Authorization"];
          setLoading(false);
        });
    } else {
      setLoading(false);
    }
  }, []);

  const login = async (username: string, password: string) => {
    try {
      const response = await axios.post("/api/v1/token/", {
        username,
        password,
      });

      const { access, refresh } = response.data;

      // store tokens
      localStorage.setItem("access_token", access);
      localStorage.setItem("refresh_token", refresh);
      axios.defaults.headers.common["Authorization"] = `Bearer ${access}`;

      // fetch user details
      const userResponse = await axios.get("/api/v1/me/");
      const user = userResponse.data;

      setCurrentUser(user);

      return { success: true, user };
    } catch (error) {
      console.error("Login error:", error.response?.data);
      return { success: false, error: error.response?.data || "Login failed" };
    }
  };

  const register = async (username, email, password) => {
    try {
      const response = await axios.post("/api/v1/register/", {
        username,
        email,
        password,
      });
      const { access, user } = response.data;

      localStorage.setItem("token", access);
      axios.defaults.headers.common["Authorization"] = `Bearer ${access}`;
      setCurrentUser(user);

      return { success: true, user };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data || "Registration failed",
      };
    }
  };

  const logout = async () => {
    try {
      const refresh = localStorage.getItem("refresh_token");

      await axios.post("/api/v1/logout/", { refresh });

      // Clear local storage and headers
      localStorage.removeItem("access_token");
      localStorage.removeItem("refresh_token");
      delete axios.defaults.headers.common["Authorization"];
      setCurrentUser(null);
    } catch (error) {
      console.error("Logout failed", error);
    }
  };

  return (
    <AuthContext.Provider
      value={{
        currentUser,
        login,
        register,
        logout,
        isAuthenticated: !!currentUser,
        loading,
      }}
    >
      {!loading && children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
