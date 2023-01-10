import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {

        var notes_text = $("#pm_notes_text");
        var counter = $("#counter");
        var max_length = counter.data("pm-notes-max-length");

        counter.text(`${notes_text[0].value.length}/${max_length}`);

        notes_text.keyup(function () {
            counter.text(`${$(this).val().length}/${max_length}`);
        });

        var src = $("#previewImage").attr("src");

        if (src == null || src == '') {
            $("#previewImage").hide();
        }else{
            $("#avatar").hide();
        }

    }

    deletePhoto() {
        $("#inputFileId").val('');
        $("#previewImage").attr("src", '');
        $("#previewImage").hide();
        $("#avatar").show();
    }

    uploadPhoto(event) {
        $("#inputFileId").click();
    }

    inputFileOnChanged(event) {
        var input = event.target;

        try {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $("#previewImage").attr("src", e.target.result);
                    $("#previewImage").show();
                    $("#avatar").hide();
                };

                reader.readAsDataURL(input.files[0]);
            }
        } catch (ex) {
            console.log("Error when trying to preview selected image");
        }
    }
}