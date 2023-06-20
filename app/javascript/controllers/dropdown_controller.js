import { Controller } from "@hotwired/stimulus"

const DROPDOWN_CLASS = '.dropdown-container';

export default class extends Controller {
  connect() {
    this.body = document.querySelector('body');
    this.body.addEventListener("dropdown:close", this.close.bind(this));
    this.body.addEventListener("keydown", this.close.bind(this));
    this.body.addEventListener("click", this.close.bind(this));
  }

  disconnect() {
    this.body.removeEventListener("dropdown:close", this.close.bind(this));
    this.body.removeEventListener("keydown", this.close.bind(this));
    this.body.removeEventListener("click", this.close.bind(this));
  }

  toggle(e) {
    e.preventDefault();
    const element = this.findElement(e);
    if (!element.classList.contains('block')) {
      this.body.dispatchEvent(new CustomEvent('dropdown:close', { bubbles: true, detail: { tiggeredBy: element.dataset['dropdownId'] } }));
    }
    element.classList.toggle('block');
  }

  close(e) {
    const isEscapeAction = e.type === 'keydown' && e.key === "Escape";
    const isDropdownCloseAction = e.type === 'dropdown:close';
    const isClickAction = e.type === 'click' && !e.target.closest(DROPDOWN_CLASS);

    if (isEscapeAction || isDropdownCloseAction || isClickAction) {
      const elements = this.body.querySelectorAll(".dropdown-container.block");
      elements.forEach((elem) => {
        if (!this.preventClose(e, elem) || isDropdownCloseAction) { elem.classList.remove('block'); };
      });
    }
  }

  findElement(event) {
    return event.target.closest(DROPDOWN_CLASS);
  }

  preventClose(e, elem) {
    return this.preventCloseOnFlatpickrClick(e, elem);
  }

  preventCloseOnFlatpickrClick(e, elem) {
    return elem.classList.contains('disable-close-on-flatpickr') &&
      (e.key === 'Escape' || e.target.closest('div.container__months'));
  }
}
