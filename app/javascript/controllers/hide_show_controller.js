import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content" ];

  toggle(e) {
    e.preventDefault();
    console.log(this.contentTarget.classList);
    this.contentTarget.classList.toggle('is-block');
  }
}
