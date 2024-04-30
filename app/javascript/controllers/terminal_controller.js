import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "params", "stdinput" ]
  static values = {
    computerId: String,
    appId: String
  }

  connect() {
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

    setTimeout(() => {
      this.terminalChannel.perform("run", {
        appId: this.appIdValue,
        code: this.codeTarget.value,
        params: this.paramsTarget.value
      })
    }, "500")
  }

  send_input() {
    this.terminalChannel.perform("input", {input: this.stdinputTarget.value})
  }

  disconnect () {
    this.terminalChannel.unsubscribe()
  }
}
