import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {
        $(document).ready(function () {
            var notes_text = $("#pm_notes_text");
            var counter = $("#counter");
            var max_length = counter.data("pm-notes-max-length");
            
            counter.text(`${notes_text[0].value.length}/${max_length}`);

            notes_text.keyup(function () {
                counter.text(`${$(this).val().length}/${max_length}`);
            });
        });
    }
}