import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite-button"
export default class extends Controller {
  static values = { favorited: Boolean, favoriteId: Number }
  static targets = ['icon']

  favorite(event) {
    event.preventDefault();

    const csrf = document.querySelector('meta[name="csrf-token"]').content
    const url = this.element.href;

    if (this.favoritedValue === true) {
      fetch(`favorites/${this.favoriteIdValue}`, { method: "DELETE",
                   headers: {
                    "Accept": "text/plain",
                    "X-CSRF-TOKEN": csrf }})
        .then(response => response.text())
        .then(data => {
          this.element.outerHTML = data
        })
    } else {
      fetch(url, { method: "POST",
                   headers: {
                    "Accept": "text/plain",
                    "X-CSRF-TOKEN": csrf }})
        .then(response => response.text())
        .then(data => {
          this.element.outerHTML = data
        })
    }
  }
}
