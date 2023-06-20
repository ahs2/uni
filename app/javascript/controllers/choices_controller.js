import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.body = document.querySelector('body');
    this.applyChoiceJs(null);
    this.body.addEventListener("form:append", this.applyChoiceJs.bind(this));
  }

  disconnect() {
    this.body.removeEventListener("form:append", this.applyChoiceJs.bind(this));
  }

  applyChoiceJs(e) {
    const choicesElement = document.querySelectorAll('.js-choice');

    choicesElement.forEach(elt => {

      if (typeof elt.choices === 'undefined') {
        elt.choices = new Choices(elt, {
          placeholderValue: 'Sélectionner un élément',
          searchPlaceholderValue: 'Chercher un élément',
          itemSelectText: '',
          removeItemButton: true,
          loadingText: 'Chargement...',
          noResultsText: 'Aucun résultat',
          noChoicesText: 'Patientez nous sommes en train de charger les données'
        });
      }

    });
  }

}
