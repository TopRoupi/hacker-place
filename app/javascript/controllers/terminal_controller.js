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


    var args = [
      this.appIdValue,
      this.codeTarget.value,
      this.paramsTarget.value
    ]
    console.log("AAAAAAAAAAAAAAAAAAAAAA")
    console.log(args)
    setTimeout(() => {
      this.terminalChannel.send({
        command: "run",
        args: args
      })
    }, "500");
  }

  send_input() {
    this.terminalChannel.send({ command: "input", args: [this.stdinputTarget.value] })
  }

  disconnect() {
  }
}
