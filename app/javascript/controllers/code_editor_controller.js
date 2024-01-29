import ApplicationController from "./application_controller"

import {CodeJar} from "codejar"
// import {withLineNumbers} from "codejar/linenumbers"

/*
Example usage:
```html
<textarea data-controller="code-editor" data-code-editor-language-value="greyscript"></textarea>
*/

export default class extends ApplicationController {
  static values = {
    language: String,
  }

  static targets = [ "editor", "name", "preview", "tabs" ]

  connect() {
    var hljs = window.hljs
    this.editor_element = this.editorTarget.insertAdjacentElement("afterend", document.createElement("div"))
    this.editor_element.classList.add("language-lua", "code-editor")

    this.jar = CodeJar(this.editor_element, this.highlight, {addClosing: false})
    this.editorTarget.style.display = "none"
    // this.editor_element.style.height = "500px"
    this.jar.updateCode(this.editorTarget.value)
    this.jar.onUpdate(code => {
      this.editorTarget.value = code
      delete this.editor_element.dataset.highlighted
      // this.highlight(this.editor_element)
    })
  }

  highlight(editor) {
    hljs.highlightElement(editor);
  }

  reset() {
    this.disconnect()
    this.connect()
  }

  disconnect() {
    this.editor_element.parentNode.remove()
  }
}
