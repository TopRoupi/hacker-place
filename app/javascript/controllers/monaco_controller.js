import ApplicationController from "./application_controller"
import * as monaco from 'monaco-editor'

export default class extends ApplicationController {
  connect() {
    this.element.editor = monaco.editor.create(this.element, {
      value: `a = 2\nprint(a)`,
      language: 'lua',
      theme: 'vs-dark',
      automaticLayout: true,
      minimap: { enabled: false },
    })
  }
}
