
var currentWeek = 0;

function clickCircleWeek(numWeeks) {
    $("#allWeeks").scrollLeft(0);
    var desplz = (($(".circleWeek").width() + 10) * numWeeks);
    $("#allWeeks").animate({scrollLeft: "+=" + desplz}, 350);

}

function initObservations(url) {
    resetNavInf();
    currentOption = "teacherObservations";
    $("#navInfObservations").empty();
    $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");
    menu("teacherObservations");
    $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");

}
function initObservationsMenu(url) {
    currentOption = "teacherObservations";
    $("#navInfObservations").empty();
    $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");
    $("#divCircleDays").empty();
    $("#divAllComments").empty();

    if ($('header').width() < 769) {
        $("#teacherObsDesktopView").hide();
        $("#teacherObservations").show();
        getCirclesWeeksMovil();
    } else {
        $("#teacherObservations").hide();
        $("#teacherObsDesktopView").show();
        getCirclesWeeks();
    }

}

function getCirclesWeeks() {
    $("#divCircleWeeks").empty();
    $("#namesMonths").empty();
    var d = new Date();

    var startMonth = 10;
    var startYear = 2017;
    var contMonth = startMonth;
    var contYear = startYear;

    var currentMonth = d.getMonth() + 1;
    var currentYear = d.getFullYear();
    var totalWeeks = 0;
    while (contMonth < currentMonth || contYear < currentYear) {
        var numWeeks = weeksInAMonth(contYear, contMonth, 0);
        totalWeeks += numWeeks;
        makeCircleWeek(numWeeks, contMonth, (contMonth === startMonth && contYear === startYear), contYear);
        contMonth = (contMonth + 1) % 13;
        if (contMonth === 0) {
            ++contYear;
            ++contMonth;
        }
    }
    numWeeks = weeksInAMonth(contYear, contMonth, d.getDay());
    totalWeeks += numWeeks;
    makeCircleWeek(numWeeks, contMonth, (contMonth === startMonth && contYear === startYear), contYear);

    $("#namesMonths").css("width", (totalWeeks + 10) * ($(".circleWeek").width() + 10));
    $("#divCircleWeeks").css("width", (totalWeeks + 10) * ($(".circleWeek").width() + 10));

    var d = new Date();
    var month = (d.getMonth() + 1)
    var idCircle = "#1-" + month + "-2018";
    $(idCircle).click();
}

function resizeMargins() {
    var idx = 0;
    $("#divAllComments .divOneComment").each(function (index) {
        var marginB = parseInt($(this).css("height")) - parseInt($("#divCircle" + $(this).prop("id").split("divOne")[1]).css("height"));
        $("#divCircleDays").children().eq(idx).css("margin-bottom", marginB + "px");
        idx++;
    });
}/*
 function resizeMargins() {
 var month = "-1";
 var cont = 0;
 var idx = 0;
 var heightCircle = $("#divCircleWeeks div").height();
 
 $("#divCircleWeeks div").each(function (index) {
 if (month !== "-1" && month !== $(this).prop("id").split("-")[1]) {
 $("#namesMonths").children().eq(idx).width(cont * (heightCircle + 10));
 cont = 0;
 idx++;
 }
 cont++;
 month = $(this).prop("id").split("-")[1];
 });
 
 $("#namesMonths").children().eq(idx).width(cont * (heightCircle + 10));
 $("#divCircleWeeks div").length;
 
 $("#namesMonths").css("width", $("#divCircleWeeks div").length * (heightCircle + 10));
 $("#divCircleWeeks").css("width", $("#divCircleWeeks div").length * (heightCircle + 10));
 
 idx = 0;
 $("#divAllComments .divOneComment").each(function (index) {
 var marginB = parseInt($(this).css("height")) - parseInt($("#divCircle" + $(this).prop("id").split("divOne")[1]).css("height"));
 $("#divCircleDays").children().eq(idx).css("margin-bottom", marginB + "px");
 idx++;
 });
 
 //parseInt($("#divCircle" + id).css("height"));
 
 
 /*
 $("#namesMonths").children().eq(1); 
 $("#divCircleWeeks div")[0].id.split("-")[1]
 $("#divCircleWeeks div").height()
 $("#namesMonths div")
 $("#namesMonths div").first().width(360)*//*
  }*/

function getCirclesWeeksMovil() {
    $("#divCircleWeeks .weekNumbers").empty();
    $("#namesMonths").empty();
    /*
     <div id="allWeeks" class="col-xs-12">
     <div  id="namesMonths" class="col-xs-12">
     </div>
     <div id="divCircleWeeks" class="col-xs-12">
     <div class="col-xs-2">Week:</div>
     <div class="col-xs-10 weekNumbers"></div>
     </div>
     </div>
     */
    var d = new Date();

    var startMonth = 10; // ¡TOMAR EL MES DE INICIO DEL SEMESTRE!!
    var startYear = 2017; // ¡TOMAR EL AÑO DE INICIO DEL SEMESTRE!!
    var contMonth = startMonth;
    var contYear = startYear;

    var currentMonth = d.getMonth() + 1;
    var currentYear = d.getFullYear();
    var totalWeeks = 0;

    while (contMonth < currentMonth || contYear < currentYear) {
        var numWeeks = weeksInAMonth(contYear, contMonth, 0);
        totalWeeks += numWeeks;
        makeCircleWeekMovil(numWeeks, contMonth, (contMonth === startMonth && contYear === startYear), contYear);
        contMonth = (contMonth + 1) % 13;
        if (contMonth === 0) {
            ++contYear;
            ++contMonth;
        }
    }
    numWeeks = weeksInAMonth(contYear, contMonth, d.getDay());
    totalWeeks += numWeeks;
    makeCircleWeekMovil(numWeeks, contMonth, (contMonth === startMonth && contYear === startYear), contYear);



    $(".daySelected").click(function () {
        /*  $(".circleWeek").css("box-shadow", "");
         $(this).css("box-shadow", "1px 1px 9px 3px #060606a6");*/

        $(".daySelected").css("background-color", "white");
        $(".daySelected").css("color", "black");

        $(this).css("background-color", colorVerde);
        $(this).css("color", "white");

        clickCircleWeek($(this).index());
        currentWeek = $(this).index();
        getCommentsDay($(this));
    });

    $(".monthObservations").click(function () {
        $(".monthObservations").css("background-color", "white");
        $(".monthObservations").css("color", colorVerde);
        $(this).css("background-color", colorVerde);
        $(this).css("color", "white");

        $(".weekNumbers .daySelected").hide();
        $(".weekNumbers .daySelected[data='" + $(this).attr("id") + "']").show();

        $("#divCircleDays").empty();
        $("#divAllComments").empty();
        $(".daySelected").css("background-color", "white");
        $(".daySelected").css("color", "black");
    });

    $(".weekNumbers .daySelected").hide();
    $("#" + currentMonth + "-" + currentYear).click();
    $("#1-" + currentMonth + "-" + currentYear).click();
    
    
    /*  $("#1-2018").click();
     $("#3-1-2018").click();*/
}
/*
 function getCirclesWeeksMovil() {
 $("#divCircleWeeks").empty();
 $("#namesMonths").empty();
 var d = new Date();
 
 var startMonth = 10;
 var startYear = 2017;
 var contMonth = startMonth;
 var contYear = startYear;
 
 var currentMonth = d.getMonth() + 1;
 var currentYear = d.getFullYear();
 var totalWeeks = 0;
 
 while (contMonth < currentMonth || contYear < currentYear) {
 var numWeeks = weeksInAMonth(contYear, contMonth, 0);
 totalWeeks += numWeeks;
 makeCircleWeekMovil(numWeeks, contMonth, (contMonth === startMonth && contYear === startYear), contYear);
 contMonth = (contMonth + 1) % 13;
 if (contMonth === 0) {
 ++contYear;
 ++contMonth;
 }
 }
 numWeeks = weeksInAMonth(contYear, contMonth, d.getDay());
 totalWeeks += numWeeks;
 makeCircleWeekMovil(numWeeks, contMonth, (contMonth === startMonth && contYear === startYear), contYear);
 
 
 
 $(".circleWeek").click(function () {
 $(".circleWeek").css("box-shadow", "");
 $(this).css("box-shadow", "1px 1px 9px 3px #060606a6");
 clickCircleWeek($(this).index());
 currentWeek = $(this).index();
 getCommentsDay($(this));
 });
 
 
 $("#namesMonths").css("width", (totalWeeks + 10) * ($(".circleWeek").width() + 10));
 $("#divCircleWeeks").css("width", (totalWeeks + 10) * ($(".circleWeek").width() + 10));
 
 var d = new Date();
 var month = (d.getMonth() + 1)
 var idCircle = "#1-" + month + "-2018";
 $(idCircle).click();
 
 }
 */


function makeCircleWeekMovil(numWeeks, contMonth, first, year) {
    /*
     <div id="allWeeks" class="col-xs-12">
     <div  id="namesMonths" class="col-xs-12">
     </div>
     <div id="divCircleWeeks" class="col-xs-12">
     <div class="col-xs-2">Week:</div>
     <div class="col-xs-10 weekNumbers"></div>
     </div>
     </div>
     */

    var idMonth = contMonth + "-" + year;

    for (var i = 1; i <= numWeeks; ++i) {
        $("#divCircleWeeks .weekNumbers").append("<div data='" + idMonth + "' class='daySelected' id='" + i + "-" + contMonth + "-" + year + "' > " + i + "</div>");
    }
    $("#namesMonths").append("<div id='" + idMonth + "' class='monthObservations'>" + monthNames[contMonth - 1].toUpperCase() + "</div>");
}

/*
 function makeCircleWeekMovil(numWeeks, contMonth, first, year) {
 //SOLO PARA MOVIL
 
 for (var i = 1; i <= numWeeks; ++i) {
 $("#divCircleWeeks").append("<div class = 'circleWeek' id='" + i + "-" + contMonth + "-" + year + "' style='background-color:" + monthColors[contMonth - 1] + "' > " + i + "w </div>");
 }
 var tamCircleWeekMovil = 0;
 if (first === true)
 var tamCircleWeekMovil = 10;
 tamCircleWeekMovil += (($(".circleWeek").width() + 10) * numWeeks);
 $("#namesMonths").append("<div style='color:" + monthColors[contMonth - 1] + ";width:" + tamCircleWeekMovil + "px'>" + monthNames[contMonth - 1].toUpperCase() + "</div>");
 }
 */
function makeCircleWeek(numWeeks, contMonth, first, year) {
    for (var i = 1; i <= numWeeks; ++i) {
        $("#divCircleWeeks").append("<div class = 'circleWeek' id='" + i + "-" + contMonth + "-" + year + "' style='background-color:" + monthColors[contMonth - 1] + "' > " + i + "w </div>");
    }
    var tamCircleWeekMovil = 0;
    if (first === true)
        var tamCircleWeekMovil = 10;
    tamCircleWeekMovil += (($(".circleWeek").width() + 10) * numWeeks);
    $("#namesMonths").append("<div style='color:" + monthColors[contMonth - 1] + ";width:" + tamCircleWeekMovil + "px'>" + monthNames[contMonth - 1].toUpperCase() + "</div>");
}


function weeksInAMonth(year, month_number, day) {
    var firstOfMonth = new Date(year, month_number - 1, 1);
    var day = firstOfMonth.getDay() || 6;
    day = day === 1 ? 0 : day;
    if (day) {
        day--
    }
    var diff = 7 - day;
    var lastOfMonth = new Date(year, month_number, 0);

    var lastDate = lastOfMonth.getDate();
    if (lastOfMonth.getDay() === 1) {
        diff--;
    }
    var result = Math.ceil((lastDate - diff) / 7);
    return result + 1;
}

function getCommentsDay(object) {
    $.ajax({
        type: "POST",
        url: "getCommentsDay.htm",
        data: {
            fecha: object.attr("id"),
            idStudent: currentStudent
        },
        datatype: "json",
        success: function (data) {
            $("#divCircleDays").empty();
            $("#divAllComments").empty();

            var data = JSON.parse(data);
            for (var i = 0; i < data.length; ++i) {
                for (var k = 0; k < data[i].length; ++k) {
                    var id = data[i][k].id;
                    $("#divCircleDays").append("<div id='divCircle" + id + "' class='circleDay' >" + (data[i][0].date).split("-")[2] + "</div>");
                    $("#divAllComments").append("<div id='divOne" + id + "' class='divOneComment  col-xs-12'>\n\
                                                <div class='divTeachers col-xs-3 ' >\n\
                                                </div> \n\
                                                <div class='divComments col-xs-9'> \n\
                                                    <div class='triangDivSup'></div>\n\
                                                    <div class='triangDivInf'></div>\n\
                                                    <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>\n\
                                                        <strong>Type: </strong>" + data[i][k].type + "<br> \n\
                                                        <p>" + data[i][k].observation + "</p>\n\
                                                    </div>\n\
                                                </div>\n\
                                            </div>");


                    if (data[i][k].teacherFoto !== "") { // tiene foto
                        var json2 = JSON.parse(data[i][k].teacherFoto);
                        var imageTag2 = '<div class="col-xs-12 divFotoTeacher">' + '<img id="imgPopTeacher' + id + '" class="fotoTeacher" src="" alt="image" height="100" />' + '</div>';
                        $("#divOne" + id + " .divTeachers").append(imageTag2);
                        $('#imgPopTeacher' + id).attr("src", "data:" + json2.ext + ";base64," + json2.imagen);
                        var image2 = new Image();
                        image2.src = "data:" + json2.ext + ";base64," + json2.imagen;

                    } else {//defecto
                        var nameImage = "icon_Recio.svg";
                        if (data[i][k].teacherGender === "Female") {
                            nameImage = "icon_SenyoraRecio.svg";
                        }
                        $("#divOne" + id + " .divTeachers").append("<div class='col-xs-12 divFotoTeacher'><img id='imgPopTeacher" + id + "' class='fotoTeacher' src='../ParentWeb/recursos/img/iconos/" + nameImage + "' height='100'>");
                    }

                    if (mapProfesores[data[i][k].nameTeacher] !== undefined)
                        $("#divOne" + id + " .divTeachers").append("<div>" + mapProfesores[data[i][k].nameTeacher].firstName + "</div>");
                    else
                        $("#divOne" + id + " .divTeachers").append("<div>Teacher   id: " + data[i][k].nameTeacher + "</div>");

                    if (data[i][k].foto !== "false") {
                        var json = JSON.parse(data[i][k].foto);
                        var imageTag = '<div class="col-xs-12 divFoto">' + '<img id="imgPop' + id + '" class="fotoComment" src="" alt="image" height="100" />' + '</div>';
                        $("#divOne" + id + " .divComments").append(imageTag);
                        $('#imgPop' + id).attr("src", "data:" + json.ext + ";base64," + json.imagen);

                        var image = new Image();
                        image.src = "data:" + json.ext + ";base64," + json.imagen;

                        $('#imgPop' + id).css("width", json.naturalWidth);

                        if (json.naturalHeight > json.naturalWidth) {//vertical
                            $('#imgPop' + id).css("height", json.naturalHeight);
                            var marginB = parseInt($("#divOne" + id).css("height") + json.naturalHeight) - parseInt($("#divCircle" + id).css("height"));
                            $("#divCircle" + id).css("margin-bottom", marginB + "px");
                        } else {
                            var marginB = parseInt($("#divOne" + id).css("height")) - parseInt($("#divCircle" + id).css("height"));
                            $("#divCircle" + id).css("margin-bottom", marginB + "px");
                        }

                    } else {
                        var marginB = parseInt($("#divOne" + id).css("height")) - parseInt($("#divCircle" + id).css("height"));
                        $("#divCircle" + id).css("margin-bottom", marginB + "px");
                    }


                }
            }


            $("#divAllComments").append("<div class='col-xs-12' style='height:60px'></div>");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(xhr.responseText);
            console.log(thrownError);
        }
    });
}
