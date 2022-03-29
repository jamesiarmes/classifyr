import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    updateButton() {
        if (this.element.checked == true) {
            document.getElementById('map_button').innerText = "Mark Unknown";
        } else {
            document.getElementById('map_button').innerText = "Map Call Type";
        }
    }

    submit() {
        document.getElementById('class_form').submit();
    }
}
