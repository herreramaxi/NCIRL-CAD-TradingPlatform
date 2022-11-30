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

            $("#addToFavorites").click(function (event) {

                var id = $('#symbolDataDiv').data('id');
                var symbol = $('#symbolDataDiv').data('symbol');
                console.log(id);

                event.preventDefault();
                console.log("addToFavorites")

                $.ajax({
                    url: 'addFavoriteStock',
                    type: 'post',
                    data: {
                        id: id
                    },
                    headers: {
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: 'json',
                    success: function (data) {
                        // $('#favorites').html("<%= render 'favorites' %>")
                        // $("#favorites").html('#{escape_javascript(render :partial => "favorites")}');
                        // $("#favorites").append('<%=j render :partial=>"favorites", :locals=>{:@traderStocks=>@traderStocks}%>');
                        console.log("success")
                        console.info(data);

                        if (data.result !== "ok") {
                            console.log("Error")
                            return;
                        }

                        window.location.assign("/trading/index?symbol=" + symbol)

                    }
                });
            });

            $("#removeFromFavorites").click(function (event) {
                var id = $('#symbolDataDiv').data('id');
                var symbol = $('#symbolDataDiv').data('symbol');
                event.preventDefault();
                console.log("remove")

                $.ajax({
                    url: 'removeFavoriteStock',
                    type: 'post',
                    data: {
                        id: id
                    },
                    headers: {
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: 'json',
                    success: function (data) {
                        // $('#favorites').html("<%= render 'favorites' %>")
                        // $("#favorites").html('#{escape_javascript(render :partial => "favorites")}');
                        // $("#favorites").append('<%=j render :partial=>"favorites", :locals=>{:@traderStocks=>@traderStocks}%>');
                        console.log("success")
                        console.info(data);

                        if (data.result !== "ok") {
                            console.log("Error")
                            return;
                        }

                        window.location.assign("/trading/index?symbol=" + symbol)

                    }
                });

            });

            $("#removeFromFavorites_FavoritesList").click(function (event) {
                var id = $('#symbolDataDivFavorites_FavoritesList').data('id');
                var symbol = $('#symbolDataDivFavorites_FavoritesList').data('symbol');
                event.preventDefault();
                console.log("removeFromFavorites_FavoritesList")

                $.ajax({
                    url: 'removeFavoriteStock',
                    type: 'post',
                    data: {
                        id: id
                    },
                    headers: {
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: 'json',
                    success: function (data) {
                        // $('#favorites').html("<%= render 'favorites' %>")
                        // $("#favorites").html('#{escape_javascript(render :partial => "favorites")}');
                        // $("#favorites").append('<%=j render :partial=>"favorites", :locals=>{:@traderStocks=>@traderStocks}%>');
                        console.log("success")
                        console.info(data);

                        if (data.result !== "ok") {
                            console.log("Error")
                            return;
                        }

                        window.location.assign("/trading/index?symbol=" + symbol)

                    }
                });

            });
        });
    }
}