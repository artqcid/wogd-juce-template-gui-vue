# WOGD JUCE Template GUI

Vue.js 3 + TypeScript GUI for JUCE plugins with WebView2 integration

## 🚀 Quick Start

> **Note:** This GUI is typically used as a git submodule within the main JUCE plugin project.  
> See the [main README](../README.md) for complete project setup instructions.

### Standalone Development

If developing the GUI separately:

```bash
# Clone your GUI repository
git clone https://github.com/YOUR_USERNAME/YOUR_GUI_PROJECT.git
cd YOUR_GUI_PROJECT

# Install dependencies
npm install

# Start dev server
npm run dev
```

Open http://localhost:5173 to preview the GUI in your browser.

### Integrated Development (Recommended)

When working within the full plugin project:

```bash
# From project root
cd gui
npm install
npm run dev
```

The plugin loads the GUI automatically from `http://localhost:5173` in debug builds.

## 📁 Structure

```
src/
  ├── views/PluginView.vue     # Main plugin interface
  ├── components/              # Reusable components
  ├── services/pluginService.ts # Plugin communication
  └── assets/master.css        # Global styles
```

## 🔌 Plugin Communication

The `pluginService.ts` handles bidirectional communication with JUCE:

```typescript
import { pluginService } from '@/services/pluginService'

// Get parameter value
const value = await pluginService.getParameter('gain')

// Set parameter value
await pluginService.setParameter('gain', 0.8)

// Listen for parameter changes from plugin
pluginService.onParameterChange('gain', (newValue) => {
  console.log('Gain changed:', newValue)
})
```

### Communication Flow
- **Plugin → GUI**: Automatic updates via parameter listeners
- **GUI → Plugin**: Via `setParameter()` calls through WebView2 bridge

## 🎯 Integration with Plugin

The plugin loads this GUI via WebView2:
- **Debug builds**: `http://localhost:5173` (hot reload with Vite)
- **Release builds**: `dist/index.html` (bundled static files)

See [../plugin/source/PluginEditor.cpp](../plugin/source/PluginEditor.cpp) for the WebView2 integration implementation.

## 🛠️ Development Workflow

### 1. Start Dev Server
```bash
npm run dev
```

### 2. Build Plugin
In the plugin folder:
```bash
cmake --build build --config Debug
```

### 3. Test in DAW
The plugin automatically connects to your dev server at `http://localhost:5173`

### Production Build
```bash
npm run build
```

Output goes to `dist/` and is embedded in the release plugin build.

## 📝 Customization

Start editing in `src/views/PluginView.vue`:

```vue
<template>
  <div class="plugin-view">
    <h1>Your Plugin UI</h1>
    <!-- Add knobs, sliders, buttons, etc. -->
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { pluginService } from '@/services/pluginService'

const gain = ref(0.5)

// Update plugin parameter
const updateGain = (value: number) => {
  gain.value = value
  pluginService.setParameter('gain', value)
}
</script>
```

Add global styles in `src/assets/master.css`.

## 🧪 Testing & Quality

### Type Checking
```bash
npm run type-check
```

### Linting
```bash
npm run lint
```

## 📚 Resources

- [Main Project README](../README.md)
- [Plugin README](../plugin/README.md)
- [Vue.js 3 Documentation](https://vuejs.org/)
- [TypeScript Guide](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
- [JUCE WebView Integration Docs](https://docs.juce.com/)
