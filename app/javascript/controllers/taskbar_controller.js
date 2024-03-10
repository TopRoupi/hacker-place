import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  connect() {
  }

  openApp(e) {
    var app = e.target.dataset.app

    this.dispatch("open", {
      detail: {
        app: app,
        args: {
        }
      }
    })
  }
}
