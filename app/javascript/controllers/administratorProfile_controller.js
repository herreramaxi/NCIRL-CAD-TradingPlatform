import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {        
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