import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code", "stdinput" ]

  connect() {
    console.log("dwadwad")
    console.log(this.codeTarget)
    console.log(this.stdinputTarget)

    this.channel = this.application.consumer.subscriptions.create(
      {
        channel: "TerminalChannel",
        id: "test",
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
    console.log("run")
    this.channel.send({ command: "run", args: [this.codeTarget.value] })
  }

  disconnect() {
  }
}
