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

  open({ app, args }) {
    this.deChannel.perform("open", {
      app: app,
      args: args
    })
  }

  close({ app }) {
    document.getElementById(app).remove()
    document.getElementById(app + "-taskbar").remove()
  }

  focus({ app }) {
    this.desktopAppTargets.forEach((e) => {
      e.classList.remove("z-10")
    })

    document.getElementById(app).classList.add("z-10")
  }

  activeAppValueChanged () {
    if(this.activeAppValue == "")
      return

    document.getElementById(this.activeAppValue).classList.remove("hidden")
  }
}
