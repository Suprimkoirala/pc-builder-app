import { create } from "zustand"

interface User {
  id: string
  email: string
  name: string
}

interface AuthState {
  user: User | null
  isAuthenticated: boolean
  login: (email: string, password: string) => Promise<boolean>
  signup: (name: string, email: string, password: string) => Promise<boolean>
  logout: () => void
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isAuthenticated: false,
  login: async (email: string, password: string) => {
    // Simulate API call
    await new Promise((resolve) => setTimeout(resolve, 1000))

    // Mock authentication - in real app, validate with backend
    if (email && password) {
      const user = {
        id: "1",
        email,
        name: email.split("@")[0],
      }
      set({ user, isAuthenticated: true })
      return true
    }
    return false
  },
  signup: async (name: string, email: string, password: string) => {
    // Simulate API call
    await new Promise((resolve) => setTimeout(resolve, 1000))

    if (name && email && password) {
      const user = {
        id: "1",
        email,
        name,
      }
      set({ user, isAuthenticated: true })
      return true
    }
    return false
  },
  logout: () => {
    set({ user: null, isAuthenticated: false })
  },
}))
