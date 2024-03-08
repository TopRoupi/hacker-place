import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "stdinput" ]
  static values = {
    computerId: String,
    appId: String
  }

  connect() {
    console.log("terminal")
    this.terminalChannel = this.application.consumer.subscriptions.create(
      {
        channel: "TerminalChannel",
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
    this.terminalChannel.send({ command: "input", args: [this.stdinputTarget.value] })
  }

  disconnect() {
  }
}
