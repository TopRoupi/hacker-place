import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "desktop", "taskbar", "desktopApp" ]
  static values = {
    activeApp: {type: String},
    computerId: {type: String}
  }

  connect () {
    this.appIdStack = []

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

    document.addEventListener('register-app-window', this.registerAppWindow)
  }

  registerAppWindow = (e) => {
    var { appId } = e.detail
    this.appIdStack.push(appId)
    this.setAppStackStyles()
  }

  setAppStackStyles() {
    let i = 2
    this.appIdStack.forEach((id) => {
      let elem = document.getElementById(id)
      if(elem == null) return
      elem.style.zIndex = `${i}`;
      i++
    })
  }

  focus({ app }) {
    this.appIdStack.slice(this.appIdStack.indexOf(app))
    this.appIdStack.push(app)

    this.setAppStackStyles()
  }

  open({ app, args }) {
    this.deChannel.perform("open", {
      app: app,
      args: args
    })
  }

  close({ app }) {
    this.appIdStack.slice(this.appIdStack.indexOf(app))
    document.getElementById(app).remove()
    document.getElementById(app + "-taskbar").remove()

    this.setAppStackStyles()
  }

  activeAppValueChanged () {
    if(this.activeAppValue == "")
      return

    document.getElementById(this.activeAppValue).classList.remove("hidden")
  }
}
