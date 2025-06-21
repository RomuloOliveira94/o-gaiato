import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { autoDismiss: Boolean }

  connect() {
    if (this.autoDismissValue) {
      this.dismissTimer = setTimeout(() => {
        this.dismiss()
      }, 3000)
    }
  }

  disconnect() {
    if (this.dismissTimer) {
      clearTimeout(this.dismissTimer)
    }
  }

  dismiss() {
    this.element.classList.add('flash-message-dismissing')
    
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
