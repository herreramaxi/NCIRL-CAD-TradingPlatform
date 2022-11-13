import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


    connect() {
        // Twitter typeahead example.

        // instantiate the bloodhound suggestion engine
        var symbols = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('symbol'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            remote: {
                wildcard: '%QUERY',
                url: 'autocomplete/%QUERY'
                // transform: function (response) {
                //     console.log(response);
                //     return response.name + " - " +  response.description;
                // }
            }
        });

        // initialize the bloodhound suggestion engine
        symbols.initialize();

        $(document).ready(function () {

            $('#bloodhound .typeahead').typeahead(null, {
                limit: 10,
                name: 'symbols',
                display: 'name',
                source: symbols.ttAdapter(),
                templates: {
                    suggestion: function (data) {
                        return '<p><strong>' + data.symbol + '</strong> – ' + data.name + '</p>';
                    }
                }
            });

            $('#bloodhound').on('typeahead:selected', function (e, datum) {
                window.location.assign("/trading/index?symbol=" + datum.symbol);
            });
        });
    }
}