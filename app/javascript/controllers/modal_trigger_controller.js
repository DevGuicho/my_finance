// app/javascript/controllers/modal_trigger_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        modalId: String
    }

    open() {
        const modal = document.getElementById(this.modalIdValue)
        if (!modal) return

        modal.showModal()
    }

    close() {
        const modal = document.getElementById(this.modalIdValue)
        if (!modal) return

        modal.close()
    }
}