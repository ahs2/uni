import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "dark", "light" ];

  connect() {
    let theme = localStorage.getItem('dark');
    if (theme) {
      if (theme == "true") {
        this.dark()
      }
      if (theme == "false") {
        this.light()
      }
    } else{
      localStorage.setItem('dark', false);
    }

  }

  toggle(e) {
    e.preventDefault();
    let theme = localStorage.getItem('dark');
    if (theme) {
      if (theme == "true") {
        this.light()
        localStorage.setItem('dark', false);
      } 
      if (theme == "false") {
        this.dark()
        localStorage.setItem('dark', true);
      }
    }
  }

  light() {
    this.darkTarget.classList.add('hidden')
    this.lightTarget.classList.remove('hidden')
    document.getElementsByTagName('html')[0].classList.remove('dark')
  }

  dark() {
    this.darkTarget.classList.remove('hidden')
    this.lightTarget.classList.add('hidden')
    document.getElementsByTagName('html')[0].classList.add('dark')
  }
}
