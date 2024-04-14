import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static outlets = [ "de" ]

  connect() {
    this.deController = this.application.getControllerForElementAndIdentifier(this.deOutlet.element, 'de')
  }

  openApp(e) {
    var app = e.target.dataset.app

    this.deController.open({app: app, args: {}})
  }
}
