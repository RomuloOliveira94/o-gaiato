import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "feedback"];
  static values = {
    text: String,
    feedbackDuration: { type: Number, default: 1500 },
    successMessage: { type: String, default: "Copiado!" },
    errorMessage: { type: String, default: "Erro ao copiar" },
  };

  copy() {
    const textToCopy = this.getTextToCopy();

    navigator.clipboard
      .writeText(textToCopy)
      .then(() => {
        this.showFeedback(this.successMessageValue, "text-green-600");
      })
      .catch(() => {
        this.showFeedback(this.errorMessageValue, "text-red-600");
      });
  }

  getTextToCopy() {
    if (this.textValue) {
      return this.textValue;
    }

    if (this.hasSourceTarget) {
      return this.sourceTarget.textContent.trim();
    }

    return this.element.textContent.trim();
  }

  showFeedback(message, colorClass) {
    if (this.hasFeedbackTarget) {
      this.feedbackTarget.className = this.feedbackTarget.className.replace(
        /text-(green|red)-\d+/g,
        ""
      );

      this.feedbackTarget.classList.add(colorClass);
      this.feedbackTarget.textContent = message;
      this.feedbackTarget.classList.remove("hidden");

      setTimeout(() => {
        this.feedbackTarget.classList.add("hidden");
      }, this.feedbackDurationValue);
    }
  }
}
