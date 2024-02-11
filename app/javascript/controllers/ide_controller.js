import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "codeparams", "stdinput", "programDialog" ]
  static values = {
    computerId: String,
    appId: String
  }

  connect() {
    this.channel = this.application.consumer.subscriptions.create(
      {
        channel: "IdeChannel",
        id: "test",
        computerId: this.computerIdValue,
        appId: this.appIdValue
      },
      {
        received (data) {
          if (data.cableReady) CableReady.perform(data.operations)
        }
      }
    )
  }

  send_input() {
    console.log("input")
    this.channel.send({ command: "input", args: [this.stdinputTarget.value] })
  }

  run_script() {
    this.programDialogTarget.showModal()
    console.log("run")
    console.log(this.codeparamsTarget.value)
    this.channel.send({ command: "run", args: [this.codeTarget.value, this.codeparamsTarget.value] })
  }

  disconnect() {
  }
}
