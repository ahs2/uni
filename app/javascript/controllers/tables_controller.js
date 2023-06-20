import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static values = {
    indexUrl: String
  };

  connect() {
  }

  onItemPerPageChange(e) {
    e.preventDefault();
    const value = e.target.value;
    location.replace(`${this.indexUrlValue}?items=${value}`);
  }

  onArchivedChange(e) {
    e.preventDefault();
    const value = e.target.value;
    location.replace(`${this.indexUrlValue}?is_archived=${value}`);
  }
}
