import ApplicationController from "./application_controller"
import * as monaco from 'monaco-editor'

export default class extends ApplicationController {
  connect() {
    super.connect()
    this.stimulate('MonitoringReflex#load')
  }
}
