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

  connect() {
    this.dragging = false
    this.resizeD = ""
    this.resizing = false
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
        el.style.width = width + pos1 + 'px'
        el.style.left = el.offsetLeft + pos1 * -1 + 'px'
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
