import ApplicationController from "./application_controller"

class ResizeDirection {
  constructor(rect, e) {
    this.dragFrameSize = 7

    this.cursorX = e.clientX - rect.left
    this.cursorY = e.clientY - rect.top
    this.elementWidth = rect.width
    this.elementHeight = rect.height
  }

  direction() {
    if(this.cursorY > this.elementHeight - this.dragFrameSize && this.cursorX > this.elementWidth - this.dragFrameSize)
      return "se"
    if(this.cursorY > this.elementHeight - this.dragFrameSize && this.cursorX < this.dragFrameSize)
      return "sw"
    if(this.cursorY > this.elementHeight - this.dragFrameSize)
      return "s"
    if(this.cursorX > this.elementWidth - this.dragFrameSize)
      return "e"
    if(this.cursorX < this.dragFrameSize)
      return "w"

    return ""
  }

  setCursorToDrag(element) {
    var mapping = {
      "se": "se-resize",
      "sw": "sw-resize",
      "s": "s-resize",
      "w": "w-resize",
      "e": "e-resize",
      "": "default",
    }

    element.style.cursor = mapping[this.direction()];
  }
}


export default class extends ApplicationController {
  static targets = ["titleBar", "window"]
  static outlets = [ "de" ]

  connect() {
    this.deController = this.application.getControllerForElementAndIdentifier(this.deOutlet.element, 'de')

    this.dragging = false
    this.resizeD = ""
    this.resizing = false

    this.maximized = false
  }


  minimize() {
    this.deController.minimize({app : this.element.id})
  }

  maximize() {
    if(this.maximized == true) {
      this.maximized = false
      this.element.style.height = this.unmaximizedHeight + "px"
      this.element.style.width = this.unmaximizedWidth + "px"

      this.element.style.top = this.unmaximizedTop
      this.element.style.left = this.unmaximizedLeft
    } else {
      this.maximized = true
      this.unmaximizedHeight = this.element.offsetHeight
      this.unmaximizedWidth = this.element.offsetWidth

      console.log(this.element.style.top)
      this.unmaximizedTop = this.element.style.top
      this.unmaximizedLeft = this.element.style.left

      this.element.style.top = "0px"
      this.element.style.left = "0px"

      this.element.style.height = this.deOutlet.desktopTarget.offsetHeight + "px"
      this.element.style.width = this.deOutlet.desktopTarget.offsetWidth + "px"
    }
  }

  focus() {
    this.deController.focus({app : this.element.id})
  }


  close() {
    this.deController.close({app : this.element.id})
  }

  checkResize(e) {
    let resize = new ResizeDirection(this.windowTarget.getBoundingClientRect(), e);

    if(this.resizing == false){
      this.resizeD = resize.direction()
      resize.setCursorToDrag(this.element)
    }
  }

  startResize(e) {
    if(this.resizeD != "") {
      this.resizing = true
    }
  }

  stopResize(e) {
    if(this.resizing == true) {
      this.resizing = false
    } else {
      this.resizeD = ""
    }
  }

  resize(e) {
    if(this.resizing == true) {
      let pos1 = this.initialX - e.clientX;
      let pos2 = this.initialY - e.clientY;
      this.initialX = e.clientX
      this.initialY = e.clientY

      var el = this.element
      var height = el.offsetHeight
      var width = el.offsetWidth

      if(this.resizeD.includes("s")) {
        el.style.height = height + pos2 * -1 + 'px'
      }
      if(this.resizeD.includes("e")) {
        el.style.width = width + pos1 * -1 + 'px'
      }
      if(this.resizeD.includes("w")) {
        let minWidth = Number(el.style.minWidth.slice(0, -2))

        el.style.width = width + pos1 + 'px'

        if(width > minWidth || (width == minWidth && pos1 > 0)) {
          if(width + pos1 < minWidth && pos1 < 0) {
            pos1 = (width - minWidth) * -1
          }
          el.style.left = el.offsetLeft + pos1 * -1 + 'px'
        }
      }
    } else {
      this.initialX = e.clientX
      this.initialY = e.clientY
    }
  }

  resetCursor(e) {
    var rect = this.windowTarget.getBoundingClientRect()
    var x = e.clientX - rect.left
    var y = e.clientY - rect.top

    var outside = false
    if(x < 0) {
      var outside = true
    }
    if(x > rect.width) {
      var outside = true
    }
    if(y < 0) {
      var outside = true
    }
    if(y > rect.height) {
      var outside = true
    }

    if(this.resizing == false && outside == true) {
      this.element.style.cursor = "default"
    }
  }

  dragMouseDown(e) {
    e.preventDefault()
    this.initialX = e.clientX
    this.initialY = e.clientY
    this.dragging = true
  }

  closeDrag(e) {
    if(this.dragging == true){
      this.dragging = false
    }
  }

  drag(e) {
    if(this.dragging == false)
      return
    e.preventDefault();

    // calculate the new cursor position:
    let pos1 = this.initialX - e.clientX;
    let pos2 = this.initialY - e.clientY;
    this.initialX = e.clientX;
    this.initialY = e.clientY;

    let elmnt = this.element

    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }
}
