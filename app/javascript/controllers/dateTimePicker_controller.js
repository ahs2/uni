import { Controller } from "@hotwired/stimulus"
import { initDatepicker, initTimepicker } from "./utilities/datepicker.js";

export default class extends Controller {
  static targets = [ 'input' ];

  connect() {
    this.type = this.data.get('type');

    if (this.type === 'time')  {
      this.picker = initTimepicker(this.inputTarget);
    }
    else {
      this.picker = initDatepicker(this.inputTarget);
    }
  }

  clear(e) {
    e.preventDefault();
    this.picker.clear();
  }
}
