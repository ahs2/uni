import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "closeSide", "openSide", "contentBg", "side" ];

  toggle(e) {
    e.preventDefault();
    this.closeSideTarget.classList.toggle('hidden')
    this.sideTarget.classList.toggle('z-50')
    this.openSideTarget.classList.toggle('hidden')
    this.contentBgTarget.classList.toggle('hidden')
  }

  // close(e) {
  //   e.preventDefault();
  //   this.closeSideTarget.classList.add('hidden')
  //   this.sideTarget.classList.remove('z-50')
  //   this.openSideTarget.classList.remove('hidden')
  //   this.contentBgTarget.classList.add('hidden')
  // }
}
