import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = ["titleBar", "window"]

  connect() {
    this.dragging = false
    this.resizeD = ""
    this.resizing = false
  }

  checkResize(e) {
    var rect = this.windowTarget.getBoundingClientRect()

    var x = e.clientX - rect.left
    var y = e.clientY - rect.top
    var w = rect.width
    var h = rect.height

    if(this.resizing == false){
      if(y > h - 7) {
        this.element.style.cursor = "s-resize";
        this.resizeD = "s"
      } else if(x > w - 7){
        this.element.style.cursor = "e-resize";
        this.resizeD = "e"
      } else if(x < 7){
        this.element.style.cursor = "w-resize";
        this.resizeD = "w"
      }
      else {
        this.resizeD = ""
        this.element.style.cursor = "default"
      }
    }
  }

  startResize(e) {
    if(this.resizeD != "") {
      console.log("start")
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

      if(this.resizeD == "s") {
        el.style.height = height + pos2 * -1 + 'px'
      }
      if(this.resizeD == "e") {
        el.style.width = width + pos1 * -1 + 'px'
      }
      if(this.resizeD == "w") {
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
