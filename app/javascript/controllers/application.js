import { Application } from "@hotwired/stimulus"

const application = Application.start()
// const redirectUri = 'http://localhost:8888/callback';

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
