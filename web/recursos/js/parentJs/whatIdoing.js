function initWhatDoing(url) {
    resetNavInf();
    /*currentOption = "teacherObservations";
     $("#navInfObservations").empty();
     $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");
     menu("teacherObservations");
     $("#navInfReport").hide();
     $("#navInfMore").attr("value", "a_MenuIcon.svg");
     
     
     */

    currentOption = "whatIdo";
    $("#navInfWhatIam").empty();
    $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='What I am learning now?'>");
    menu("whatIdo");
    $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");
}

function initWhatDoingMenu(url) {
    currentOption = "whatIdo";
    $("#navInfWhatIam").empty();
    $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");
    getDataWhat();
    paintDataWhat("attemptedWeek");
    $("#whatsDoingPage").show();
}

$(document).ready(function () {
    $(".card-header a").click(function () {

        if ($(this).parent().next().hasClass("collapse") && $(this).parent().next().hasClass("in")) {
            $(this).parent().children(".accorSteps").show()
        } else
            $(this).parent().children(".accorSteps").hide()

    });
    $(".btnInfNavWhat").click(function () {
// navInfWhatIDoing //div Secundarios
// infWhatPrincipal //div principal
        var currentValue = $("#infWhatPrincipal div").attr("value");
        var currentText = $("#infWhatPrincipal div").text().trim();
        $("#infWhatPrincipal div").attr("value", $(this).attr("value"));
        $("#infWhatPrincipal div").html($(this).text().trim() + '  <span class="glyphicon glyphicon-menu-down"></span>');
        $(this).attr("value", currentValue);
        $(this).html(currentText + '  <span class="glyphicon glyphicon-menu-down"></span>');
        /* $("#infWhatPrincipal ").empty().append(seleccDiv);
         $("#navInfWhatIDoing").append(CurrentDiv);
         */
        //HACER CARGA DE DATOS
    });
});
var arrayAttemp;
var arrayMastered;
var arrayFuture;
function getDataWhat() {
    var id = currentStudent;
    $.ajax({
        type: "POST",
        url: "getDataWhat.htm?seleccion=" + id,
        data: id,
        dataType: 'text',
        success: function (data) {
            var data = JSON.parse(data);
            arrayAttemp = JSON.parse(data.arrayAttempted);
            arrayMastered = JSON.parse(data.arrayMastered);
            arrayFuture = JSON.parse(data.arrayFuture);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(xhr.responseText);
            console.log(thrownError);
        }
    });
}
function paintDataWhat(valueSelected) {
    var arrayData;
    switch (valueSelected) {
        case "attemptedWeek":
            arrayData = arrayAttemp;
            break;
        case "masterWeek":
            arrayData = arrayMastered;
            break;
        default:
            arrayData = arrayFuture;
    }
    $("#accordionWhats").empty();

    for (var i = 0; i < arrayData.length; i++) {
        $("#accordionWhats").append("<div class='card'>\n\
                                    <div class='card-header'>\n\
                                        <a class='collapsed card-link' data-toggle='collapse' href='#collapseTwo2'>\n\
                                            <div>\n\
                                                <img src='../ParentWeb/recursos/img/iconos/target.svg' alt='image' />\n\
                                                <div>Rhyming words</div>\n\
                                            </div>\n\
                                            <div>\n\
                                                <div>MUSIC</div>\n\
                                                <img src='../ParentWeb/recursos/img/iconos/subject.svg' alt='image' />\n\
                                            </div>\n\
                                        </a>\n\
                                        <div class= 'accorSteps'>\n\
                                            <img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />\n\
                                            <img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />\n\
                                            <img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />\n\
                                        </div>\n\
                                    </div>\n\
                                    <div id='collapseTwo2' class='collapse' data-parent='#accordion'>\n\
                                        <div class='card-body'>\n\
                                            <ul id='menu'>\n\
                                                <li><img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />Rhyming boxes</li>\n\
                                                <li><img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />Match correct cards</li>\n\
                                                <li><img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />Write and illustrate in book</li>\n\
                                            </ul>\n\
                                        </div>\n\
                                    </div>\n\
                                </div>");
    }
}


