import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-tabs"
export default class extends Controller {
  static targets = ["tab"]

  selectTab(event) {
    const clickedButton = event.currentTarget
    
    // Remove active classes from all tabs
    this.tabTargets.forEach(tab => {
      tab.classList.remove("bg-white", "text-gray-900", "shadow")
      tab.classList.add("hover:text-gray-700")
    })
    
    // Add active classes to clicked tab
    clickedButton.classList.add("bg-white", "text-gray-900", "shadow")
    clickedButton.classList.remove("hover:text-gray-700")
    
    // Dispatch custom event with the selected tab name
    const tabName = clickedButton.dataset.tabName
    const customEvent = new CustomEvent("filter-tabs:changed", {
      detail: { tab: tabName },
      bubbles: true
    })
    this.element.dispatchEvent(customEvent)
  }
}

