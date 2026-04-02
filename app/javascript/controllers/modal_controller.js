// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container"]
    static values = {
        closeOnBackdrop: { type: Boolean, default: true },
        closeOnEscape: { type: Boolean, default: true }
    }

    connect() {
        this.handleKeydown = this.handleKeydown.bind(this)
        document.addEventListener("keydown", this.handleKeydown)
    }

    disconnect() {
        document.removeEventListener("keydown", this.handleKeydown)
    }

    close(event) {
        if (event) event.preventDefault()
        this.element.remove()
    }

    closeOnBackdrop(event) {
        if (!this.closeOnBackdropValue) return
        // Solo cerrar si el click fue directamente en el backdrop
        if (event.target === event.currentTarget) {
            this.close(event)
        }
    }

    handleKeydown(event) {
        if (!this.closeOnEscapeValue) return
        if (event.key === "Escape") {
            this.close()
        }
    }
}