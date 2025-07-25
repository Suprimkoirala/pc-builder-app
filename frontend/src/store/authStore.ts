import { create } from "zustand"
import axios from "axios"

const API_BASE = "http://localhost:8000/api/v1"

interface User {
  id: string
  username: string
  email: string
}

interface AuthState {
  user: User | null
  isAuthenticated: boolean
  login: (email: string, password: string) => Promise<boolean>
  signup: (username: string, email: string, password: string) => Promise<boolean>
  logout: () => Promise<void>
  fetchUser: () => Promise<void>
  tryAutoLogin: () => Promise<void>
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isAuthenticated: false,

  login: async (email, password) => {
    try {
      const res = await axios.post(`${API_BASE}/login/`, {
        email,
        password,
      })
      const { access, refresh } = res.data
      
      localStorage.setItem("access", access)
      localStorage.setItem("refresh", refresh)

      await useAuthStore.getState().fetchUser()
      return true
    } catch (err) {
      console.error("Login error:", err)
      return false
    }
  },

  signup: async (username, email, password) => {
    try {
      const res = await axios.post(`${API_BASE}/register/`, {
        username,
        email,
        password,
      })
      const { access, refresh } = res.data.tokens
      const { id, username: uname, email: userEmail } = res.data.user

      localStorage.setItem("access", access)
      localStorage.setItem("refresh", refresh)

      set({ user: { id, username: uname, email: userEmail }, isAuthenticated: true })

      return true
    } catch (err) {
      console.error("Signup error:", err)
      return false
    }
  },

  logout: async () => {
    try {
      const refresh = localStorage.getItem("refresh")
      if (refresh) {
        await axios.post(`${API_BASE}/logout/`, { refresh }, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("access")}`,
          },
        })
      }
    } catch (err) {
      console.warn("Logout error:", err)
    } finally {
      localStorage.removeItem("access")
      localStorage.removeItem("refresh")
      set({ user: null, isAuthenticated: false })
    }
  },

  fetchUser: async () => {
    try {
      const res = await axios.get(`${API_BASE}/me/`, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("access")}`,
        },
      })
      
      useAuthStore.setState({
        user: res.data,
        isAuthenticated: true,
      })
      
      const { id, username, email } = res.data
      set({ user: { id, username, email }, isAuthenticated: true })
      
  } catch (err) {
    console.error("Failed to fetch user:", err)
    useAuthStore.setState({ user: null, isAuthenticated: false })
    }
  },


  tryAutoLogin: async () => {
    const access = localStorage.getItem("access")
    const refresh = localStorage.getItem("refresh")
    if (!access || !refresh) return

    try {
      await useAuthStore.getState().fetchUser()
    } catch {
      try {
        const res = await axios.post(`${API_BASE}/token/refresh/`, {
          refresh,
        })
        const newAccess = res.data.access
        localStorage.setItem("access", newAccess)
        await useAuthStore.getState().fetchUser()
      } catch (refreshError) {
        console.error("Auto login failed:", refreshError)
        localStorage.removeItem("access")
        localStorage.removeItem("refresh")
      }
    }
  },
}))
