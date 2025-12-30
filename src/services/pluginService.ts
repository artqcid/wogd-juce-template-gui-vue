/**
 * WebView2 Service for Plugin Communication
 * Uses native WebView2 Message-Passing API
 * 
 * No WebSockets needed - direct communication between C++ and JavaScript!
 */

class PluginService {
  private messageHandler: ((message: any) => void) | null = null

  /**
   * Checks if running in WebView2 environment
   */
  isInWebView2(): boolean {
    return !!(window as any).__JUCE__?.backend
  }

  /**
   * Sends a message to the plugin
   */
  sendMessage(message: any): void {
    if (this.isInWebView2()) {
      // Use JUCE native integration API
      const juce = (window as any).__JUCE__
      if (juce && juce.backend && juce.backend.emitEvent) {
        juce.backend.emitEvent('juce_message', JSON.stringify(message))
      }
    } else {
      console.log('[Dev Mode] Would send to plugin:', message)
    }
  }

  /**
   * Registers a message handler for incoming plugin messages
   */
  onMessage(handler: (message: any) => void): void {
    this.messageHandler = handler

    if (this.isInWebView2()) {
      // Use JUCE native integration API
      const juce = (window as any).__JUCE__
      if (juce && juce.backend && juce.backend.addEventListener) {
        juce.backend.addEventListener('plugin_update', (data: any) => {
          try {
            const message = typeof data === 'string' ? JSON.parse(data) : data
            this.messageHandler?.(message)
          } catch (e) {
            console.error('Failed to parse message from plugin:', e)
          }
        })
      }
    }
  }

  /**
   * Sends parameter change to plugin
   */
  setParameter(paramId: string, value: number): void {
    this.sendMessage({
      type: 'setParameter',
      data: { id: paramId, value }
    })
  }

  /**
   * Requests all parameters from plugin
   */
  requestParameters(): void {
    this.sendMessage({
      type: 'getParameters'
    })
  }

  /**
   * Sets the plugin window size
   */
  setWindowSize(width: number, height: number): void {
    this.sendMessage({
      type: 'setWindowSize',
      data: { width, height }
    })
  }
}

export const pluginService = new PluginService()
