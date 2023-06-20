import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'recordsList', 'recordTemplate' ];

  addNewRecord() {
    this.recordsListTarget.appendChild(this._newRecordTemplate());
    const event = new CustomEvent('form:append', { bubbles: true });
    document.querySelector('body').dispatchEvent(event);
  }

  deleteRecord(e) {
    const element = e.currentTarget.closest('.single-record');
    const isNewRecord = element.dataset['new-record'] == 'true';
    if (isNewRecord) {
      this.recordsListTarget.removeChild(e.currentTarget.closest('.single-record'));
    }
    else {
      element.classList.add('hidden');
      element.querySelector('.delete-target').value = true;
    }
  }

  _newRecordTemplate() {
    const template = this.recordTemplateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    return new DOMParser().parseFromString(template, 'text/html').body.firstChild;
  }
}
