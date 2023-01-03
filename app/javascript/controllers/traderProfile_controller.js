import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {
        console.log("trader_profile_controller connect....")
        $(document).ready(function () {         
            var trader_notes_text = $("#trader_notes_text");
            var counter = $("#counter");
            var max_length = counter.data("trader-notes-max-length");

            counter.text(`${trader_notes_text[0].value.length}/${max_length}`);

            trader_notes_text.keyup(function () {
                counter.text(`${$(this).val().length}/${max_length}`);
            });
        });


    }
}