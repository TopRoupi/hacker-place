import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = ["titleBar"]

  connect() {
    this.dragging = false
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
