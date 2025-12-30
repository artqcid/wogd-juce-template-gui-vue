# WOGD JUCE Template GUI

Vue.js 3 + TypeScript GUI for JUCE plugins with WebView2

## 🚀 Quick Start

### 1. Create from Template
Click **"Use this template"** on GitHub to create your own GUI repository.

### 2. Clone & Setup
```bash
git clone https://github.com/YOUR_USERNAME/YOUR_GUI_PROJECT.git
cd YOUR_GUI_PROJECT
./setup-gui.ps1
```

The setup will ask for:
- **GUI Name** (e.g., "MyPlugin GUI")
- **Package Name** (e.g., "myplugin-gui")
- **Description** (optional)

### 3. Install & Run
```bash
npm install
npm run dev
```

Open http://localhost:5173 to preview the GUI in your browser.

## 📁 Structure

```
src/
  ├── views/PluginView.vue     # Main plugin interface
  ├── components/              # Reusable components
  ├── services/pluginService.ts # Plugin communication
  └── assets/master.css        # Global styles
```

## 🔌 Plugin Communication

The `pluginService.ts` handles communication with JUCE:

```typescript
import { pluginService } from '@/services/pluginService'

// Get parameter
const value = await pluginService.getParameter('gain')

// Set parameter
await pluginService.setParameter('gain', 0.8)
```

## 🛠️ Development

### Build for Production
```bash
npm run build
```

Output goes to `dist/` and is loaded by the plugin.

### Type Checking
```bash
npm run type-check
```

## 🎯 Integration with Plugin

The plugin loads this GUI via WebView2:
- **Debug**: `http://localhost:5173` (hot reload)
- **Release**: `dist/index.html` (bundled)

## 📝 Customization

Start editing in `src/views/PluginView.vue`:

```vue
<template>
  <div class="plugin-view">
    <h1>Your Plugin UI</h1>
    <!-- Add knobs, sliders, etc. -->
  </div>
</template>
```

Add global styles in `src/assets/master.css`.

## 📚 Resources

- [Vue.js 3 Documentation](https://vuejs.org/)
- [TypeScript Guide](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
