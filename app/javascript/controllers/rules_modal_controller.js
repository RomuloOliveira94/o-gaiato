import { Controller } from "@hotwired/stimulus"

// Controla o modal (nativo <dialog>) com o resumo rápido das regras,
// acessível pelo botão flutuante presente em todas as telas do jogo.
export default class extends Controller {
  static targets = ["dialog"]

  open() {
    if (!this.dialogTarget.open) {
      this.dialogTarget.showModal()
    }
  }

  close() {
    if (this.dialogTarget.open) {
      this.dialogTarget.close()
    }
  }

  // Fecha ao clicar fora do conteúdo (no backdrop do <dialog>).
  closeOnBackdropClick(event) {
    if (event.target === this.dialogTarget) {
      this.close()
    }
  }
}
