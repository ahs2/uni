import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "header", "icon" ];

  toggle(e) {
    e.preventDefault();
    this.contentTarget.classList.toggle('hidden');

    if (this.contentTarget.classList.contains('hidden') && this.hasHeaderTarget) {
      if (this.hasHeaderTarget) this.headerTarget.classList.remove('collapse-active')
      if (this.hasIconTarget) this.iconTarget.textContent = 'unfold_more'
    }

    if (!this.contentTarget.classList.contains('hidden')) {
      if (this.hasHeaderTarget) this.headerTarget.classList.add('collapse-active')
      if (this.hasIconTarget) this.iconTarget.textContent = 'unfold_less'
    }
  }
}
