import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class FilterController extends Controller {
  static targets = [ "form", "select" ]

  initialize() {
    this.url = new URL(window.location.origin);
  }

  submitForm(event) {
    event.preventDefault()
    this.form.submit()
  }

  onChange() {
    const selectedOption = this.selectTarget.options[this.selectTarget.selectedIndex].value

    if (selectedOption === "today") {
      this.url.searchParams.set("filter", "today")
    } else if (selectedOption === "weekly") {
      this.url.searchParams.set("filter", "weekly")
    } else if (selectedOption === "monthly") {
      this.url.searchParams.set("filter", "monthly")
    } else {
      this.url.searchParams.delete("filter")
    }

    Turbo.visit(this.url)
  }
}
