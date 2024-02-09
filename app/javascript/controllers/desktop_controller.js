import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static values = {
    reset: { type: Boolean, default: true },
  }
  static targets = [ "desktop" ]

  connect () {
  }

  resetValueChanged(value, previousValue) {
    if(value == false) {
      this.resetValue = true
      this.desktopTarget.childNodes.forEach((e) => {
        if(e.nodeType != 8) {
          e.classList.add("hidden")
        }
      })
    }
  }
}
