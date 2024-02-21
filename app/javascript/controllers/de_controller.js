import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "desktop", "taskbar", "desktopApp" ]
  static values = {
    activeApp: {type: String},
    computerId: {type: String}
  }

  connect () {
    this.deChannel = this.application.consumer.subscriptions.create(
      {
        channel: "DEChannel",
        computerId: this.computerIdValue
      },
      {
        received (data) {
          if (data.cableReady) CableReady.perform(data.operations)
        }
      }
    )
  }

  activeAppValueChanged () {
    if(this.activeAppValue == "")
      return

    document.getElementById(this.activeAppValue).classList.remove("hidden")
    console.log(this.activeAppValue)
  }
}
