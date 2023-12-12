import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "code" ]

  connect() {
    console.log("dwadwad")
    console.log(this.codeTarget)

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

  run_script() {
    console.log("run")
    this.channel.send({ command: "run", args: [this.codeTarget.value] })
  }

  disconnect() {
  }
}
