import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'preview', 'fileName', 'fileInput' ];

  connect() {
    this.body = document.querySelector('body');
    this.element.addEventListener("direct-upload:start", this.uploadStart.bind(this));
    this.element.addEventListener("direct-upload:progress", this.uploadProgress.bind(this));
    this.element.addEventListener("direct-upload:error", this.uploadError.bind(this));
    this.element.addEventListener("direct-upload:end", this.uploadEnd.bind(this));
  }

  disconnect() {
    this.element.removeEventListener("direct-upload:start", this.uploadStart.bind(this));
    this.element.removeEventListener("direct-upload:progress", this.uploadProgress.bind(this));
    this.element.removeEventListener("direct-upload:error", this.uploadError.bind(this));
    this.element.removeEventListener("direct-upload:end", this.uploadEnd.bind(this));
  }

  uploadStart(e) {
    this.fileNameTarget.classList.add('uploading');
    this.fileNameTarget.textContent = 'Téléchargement...';
  }

  uploadProgress(e) {
    this.fileNameTarget.textContent = `Téléchargement... ${parseInt(e.detail.progress)}%`;
  }

  uploadError(e) {
    this.fileNameTarget.classList.remove('uploading');
    alert('Erreur durant le téléchargement');
  }

  uploadEnd(e) {
    this.fileNameTarget.textContent = e.target.files[0].name;
  }

  fileChange(e) {
    const file = e.target.files[0];

    let reader = new FileReader();
    
    reader.onload = (function(img) {
      return function(e) {
        img.src = e.target.result;
      };
    })(this.previewTarget);

    reader.readAsDataURL(file);
  }
}
