import { createContext, useState, useEffect, useContext } from "react";
import type { ReactNode } from "react";
import axios, { AxiosError } from "axios";

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

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [currentUser, setCurrentUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem("access");
    if (token) {
      axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;
      // Get user info
      axios
        .get("/api/v1/me/")
        .then((response) => {
          setCurrentUser(response.data);
          setLoading(false);
        })
        .catch((error) => {
          console.error("Auth error:", error);
          localStorage.removeItem("access");
          localStorage.removeItem("refresh");
          delete axios.defaults.headers.common["Authorization"];
          setLoading(false);
        });
    } else {
      setLoading(false);
    }
  }, []);

  const login = async (email: string, password: string) => {
    try {
      const response = await axios.post("/api/v1/login/", {
        email,
        password,
      });

      const { access, refresh, user } = response.data;

      // store tokens
      localStorage.setItem("access", access);
      localStorage.setItem("refresh", refresh);
      axios.defaults.headers.common["Authorization"] = `Bearer ${access}`;

      setCurrentUser(user);

      return { success: true, user };
    } catch (error) {
      const axiosError = error as AxiosError;
      console.error("Login error:", axiosError.response?.data);
      return { success: false, error: axiosError.response?.data || "Login failed" };
    }
  };

  const register = async (username: string, email: string, password: string) => {
    try {
      const response = await axios.post("/api/v1/register/", {
        username,
        email,
        password,
      });
      const { access, refresh, user } = response.data;

      localStorage.setItem("access", access);
      localStorage.setItem("refresh", refresh);
      axios.defaults.headers.common["Authorization"] = `Bearer ${access}`;
      setCurrentUser(user);

      return { success: true, user };
    } catch (error) {
      const axiosError = error as AxiosError;
      return {
        success: false,
        error: axiosError.response?.data || "Registration failed",
      };
    }
  };

  const logout = async () => {
    try {
      const refresh = localStorage.getItem("refresh");

      await axios.post("/api/v1/logout/", { refresh });

      // Clear local storage and headers
      localStorage.removeItem("access");
      localStorage.removeItem("refresh");
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
