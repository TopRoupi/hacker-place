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

  open({ detail: { app, args } }) {
    this.deChannel.send({ command: "open", args: [app, args] })
    console.log(app)
  }

  activeAppValueChanged () {
    if(this.activeAppValue == "")
      return

    document.getElementById(this.activeAppValue).classList.remove("hidden")
    console.log(this.activeAppValue)
  }
}
