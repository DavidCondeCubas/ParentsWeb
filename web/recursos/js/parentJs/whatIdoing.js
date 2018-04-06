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
    $("#whatsDoingPage").show();
}

$(document).ready(function () {
    $(".card-header").click(function () {

        if ($(this).next().hasClass("collapse") && $(this).next().hasClass("in")) {
            $(this).children(".accorSteps").show()
        } else
            $(this).children(".accorSteps").hide()

    });
      $(".btnInfNavWhat").click(function () {
         // navInfWhatIDoing //div Secundarios
        // infWhatPrincipal //div principal
        var currentValue = $("#infWhatPrincipal div").attr("value");
        var currentText = $("#infWhatPrincipal div").text().trim();
        
        $("#infWhatPrincipal div").attr("value",$(this).attr("value"));
        $("#infWhatPrincipal div").html($(this).text().trim()+'  <span class="glyphicon glyphicon-menu-down"></span>');
        
       $(this).attr("value",currentValue);
       $(this).html(currentText +'  <span class="glyphicon glyphicon-menu-down"></span>');
       /* $("#infWhatPrincipal ").empty().append(seleccDiv);
        $("#navInfWhatIDoing").append(CurrentDiv);
        */
        //HACER CARGA DE DATOS
    });
});