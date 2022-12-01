import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element", "select"]
  static values = { value: String }

  connect() {
    if (this.hasSelectTarget) {
      for (let select of this.selectTargets) {
        this.changed({target: select})
      }
    }
  }

  changed(event) {
    if (this.hasElementTarget) {
      for (let element of this.elementTargets) {
        this.toggle(element, element.dataset.selectValue, event.target.value);
      }
    }
  }

  toggle(element, values, value) {
    if (element && values) {
      let hidden = true;
      for (let _value of values.split(",")) {
        if (_value === value) {
          hidden = false;
        }
      }
      element.hidden = hidden;
    }
  }
}
