import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "desktop", "taskbar", "desktopApp" ]
  static values = {
    activeApp: {type: String}
  }

  connect () {
  }

  activeAppValueChanged () {
    if(this.activeAppValue == "")
      return

    document.getElementById(this.activeAppValue).classList.remove("hidden")
    console.log(this.activeAppValue)
  }
}
