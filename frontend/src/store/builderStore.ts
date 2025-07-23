import { create } from "zustand"

interface Component {
  id: string
  name: string
  category: string
  price: number
  model?: string
}

interface BuilderState {
  selectedComponents: Record<string, Component | null>
  selectComponent: (category: string, component: Component) => void
  removeComponent: (category: string) => void
  getTotalPrice: () => number
}

export const useBuilderStore = create<BuilderState>((set, get) => ({
  selectedComponents: {
    cpu: null,
    gpu: null,
    motherboard: null,
    memory: null,
    storage: null,
    psu: null,
    case: null,
    cooling: null,
  },
  selectComponent: (category: string, component: Component) => {
    set((state) => ({
      selectedComponents: {
        ...state.selectedComponents,
        [category]: component,
      },
    }))
  },
  removeComponent: (category: string) => {
    set((state) => ({
      selectedComponents: {
        ...state.selectedComponents,
        [category]: null,
      },
    }))
  },
  getTotalPrice: () => {
    const { selectedComponents } = get()
    return Object.values(selectedComponents).reduce((total, component) => total + (component?.price || 0), 0)
  },
}))
