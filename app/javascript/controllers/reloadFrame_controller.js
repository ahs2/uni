import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "frame" ];

  reload(e) {
    e.preventDefault();
    var currentStep = parseInt(e.target.dataset.currentstep)
    var studentSavedStep = parseInt(document.getElementById('student_current_step').value) + 1

    if (studentSavedStep >= currentStep) {
      history.replaceState(null, null, `?step=${currentStep}`);
      this.frameTarget.src = `/pre_registration?step=${currentStep}`
    }
  }
}
