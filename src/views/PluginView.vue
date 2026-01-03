<template>
  <div class="container">
    <h1>WOGD JUCE Plugin - Vue.js GUI</h1>
    <p>WebView2 Integration Ready</p>
    
    <div class="status">
      <p>Status: {{ isConnected ? 'Connected to Plugin' : 'Development Mode' }}</p>
    </div>

    <div class="info">
      <h2>Plugin Communication</h2>
      <p>This Vue.js app can communicate with the JUCE plugin via WebView2.</p>
      <button @click="testConnection">Test Connection</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { usePluginService } from '../services/plugin.service'

const pluginService = usePluginService()
const isConnected = ref(false)

onMounted(() => {
  console.log('PluginView mounted')
  isConnected.value = pluginService.isInWebView2()
  console.log('Is connected:', isConnected.value)
  
  // Listen for plugin messages
  pluginService.onMessage((message: any) => {
    console.log('Received from plugin:', message)
  })

  // Request parameters on startup
  if (isConnected.value) {
    pluginService.requestParameters()
  }
})

function testConnection() {
  console.log('testConnection called!')
  pluginService.sendMessage({
    type: 'test',
    data: { message: 'Hello from Vue!' }
  })
  console.log('Test message sent to plugin')
}
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  text-align: center;
  font-family: Arial, sans-serif;
}

h1 {
  color: #42b983;
}

.status {
  margin: 20px 0;
  padding: 15px;
  background: #f4f4f4;
  border-radius: 8px;
}

.info {
  margin-top: 30px;
}

button {
  padding: 10px 20px;
  background: #42b983;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background 0.1s ease;
}

button:active {
  background: #359268;
}
</style>
