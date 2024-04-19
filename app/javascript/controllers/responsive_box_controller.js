import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  static targets = [ "el", "shadowEl" ]

  connect() {
    var ro = new ResizeObserver(entries => {
      for (let entry of entries) {
        this.mirrorElements()
      }
    });
    ro.observe(this.shadowElTarget);
  }

  mirrorElements() {
    let shadowHeight = this.shadowElTarget.offsetHeight
    let shadowWidth = this.shadowElTarget.offsetWidth
    this.elTarget.style.height = shadowHeight + "px"
    this.elTarget.style.width = shadowWidth + "px"
  }
}
