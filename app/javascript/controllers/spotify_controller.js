import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spotify"
export default class extends Controller {
  connect() {
    window.onSpotifyIframeApiReady = (IFrameAPI) => {
      let iframes = document.querySelectorAll('#embed-iframe')
      iframes.forEach(element => {
      let options = {
          uri:  element.dataset.uri
        };
      let callback = (EmbedController) => {};
      IFrameAPI.createController(element, options, callback)
      })
    };
  }
}
