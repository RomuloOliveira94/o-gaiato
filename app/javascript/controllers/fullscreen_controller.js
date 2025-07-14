import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]
  
  connect() {
    // Adiciona evento para detectar mudanças no modo fullscreen
    document.addEventListener('fullscreenchange', this.handleFullscreenChange.bind(this))
    document.addEventListener('webkitfullscreenchange', this.handleFullscreenChange.bind(this))
    document.addEventListener('mozfullscreenchange', this.handleFullscreenChange.bind(this))
    
    // Tenta esconder a barra de endereço no mobile
    this.hideAddressBar()
  }

  disconnect() {
    document.removeEventListener('fullscreenchange', this.handleFullscreenChange.bind(this))
    document.removeEventListener('webkitfullscreenchange', this.handleFullscreenChange.bind(this))
    document.removeEventListener('mozfullscreenchange', this.handleFullscreenChange.bind(this))
  }

  toggle() {
    if (this.isFullscreen()) {
      this.exitFullscreen()
    } else {
      this.enterFullscreen()
    }
  }

  enterFullscreen() {
    const element = document.documentElement

    if (element.requestFullscreen) {
      element.requestFullscreen()
    } else if (element.mozRequestFullScreen) {
      element.mozRequestFullScreen()
    } else if (element.webkitRequestFullscreen) {
      element.webkitRequestFullscreen()
    } else if (element.msRequestFullscreen) {
      element.msRequestFullscreen()
    }
  }

  exitFullscreen() {
    if (document.exitFullscreen) {
      document.exitFullscreen()
    } else if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen()
    } else if (document.webkitExitFullscreen) {
      document.webkitExitFullscreen()
    } else if (document.msExitFullscreen) {
      document.msExitFullscreen()
    }
  }

  isFullscreen() {
    return !!(document.fullscreenElement || 
              document.mozFullScreenElement || 
              document.webkitFullscreenElement ||
              document.msFullscreenElement)
  }

  handleFullscreenChange() {
    // Você pode adicionar lógica aqui para reagir a mudanças no modo fullscreen
    console.log('Fullscreen state changed:', this.isFullscreen())
  }

  hideAddressBar() {
    // Força scroll para esconder a barra de endereço no mobile
    setTimeout(() => {
      window.scrollTo(0, 1)
    }, 100)
    
    // Para iOS Safari
    if (window.navigator.standalone !== undefined) {
      document.body.classList.add('standalone')
    }
  }
}
