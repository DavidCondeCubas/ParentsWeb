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
        var valueBefore = $(this).attr("value");
    
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
        paintDataWhat(valueBefore);
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
            paintDataWhat("attemptedWeek");
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
    var idSubjectAux;
    if (arrayData.length > 0) {
        idSubjectAux = arrayData[0].idSubject;
        $("#accordionWhats").append("<div class='card'>\n\
                                    <div class='card-header'>\n\
                                        <h3 class='card-link'>\n\
                                            <div class='subjectTitle'>\n\
                                                <img src='../ParentWeb/recursos/img/iconos/subject.svg' alt='image' />\n\
                                                <div>" + mapSubjects[arrayData[0].idSubject].name + "</div>\n\
                                            </div>\n\
                                        </h3>\n\
                                    </div>\n\
                                </div>");
    }
    for (var i = 0; i < arrayData.length; i++) {
        var totalSteps = mapObjectives[arrayData[i].idObjective].arraySteps.length;

        if (idSubjectAux !== arrayData[i].idSubject) {
            $("#accordionWhats").append("<div class='card'>\n\
                                    <div class='card-header'>\n\
                                        <h3 class='card-link'>\n\
                                            <div class='subjectTitle'>\n\
                                                <img src='../ParentWeb/recursos/img/iconos/subject.svg' alt='image' />\n\
                                                <div>" + mapSubjects[arrayData[i].idSubject].name + "</div>\n\
                                            </div>\n\
                                        </h3>\n\
                                    </div>\n\
                                </div>");
        }
        $("#accordionWhats").append("<div class='card'>\n\
                                    <div class='card-header'>\n\
                                        <a class='collapsed card-link' data-toggle='collapse' href='#collapse"+i+"'>\n\
                                            <div>\n\
                                                <img src='../ParentWeb/recursos/img/iconos/target.svg' alt='image' />\n\
                                                <div>" + mapObjectives[arrayData[i].idObjective].name + "</div>\n\
                                            </div>\n\
                                        </a>\n\
                                        <div class= 'accorSteps'>"+makeSteps(arrayData[i].ObjectivesSuccess,totalSteps)+"</div>\n\
                                    </div>\n\
                                    <div id='collapse"+i+"' class='collapse' data-parent='#accordion'>\n\
                                        <div class='card-body'>\n\
                                            <ul id='menu'>"+makeNamesObjectives(arrayData[i].ObjectivesSuccess,totalSteps,mapObjectives[arrayData[i].idObjective].arraySteps)+"</ul>\n\
                                        </div>\n\
                                    </div>\n\
                                </div>");

        idSubjectAux = arrayData[i].idSubject;
    }
}
function makeSteps(comp, total){ //steps completados, no completados
    var res="";
    
    for (var i = 0; i < comp;i++)
        res += "<img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />";
    
    for (var i = 0; i < total-comp;i++)
        res += "<img src='../ParentWeb/recursos/img/iconos/emptyStep.svg' alt='image' />";
    
    return res;
}

function makeNamesObjectives(comp,total,data){
    
    var res="";  
    
    for (var i = 0; i < total;i++){
        
        if(i < comp) 
            res += "<li><img src='../ParentWeb/recursos/img/iconos/step.svg' alt='image' />"+mapSteps[data[i]].name+"</li>";
        else 
            res += "<li><img src='../ParentWeb/recursos/img/iconos/emptyStep.svg' alt='image' />"+mapSteps[data[i]].name+"</li>";
    }
    return res;
}

