
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
    $("#teacherObservations").show();
    getCirclesWeeks();
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

    $(".circleWeek").click(function () {
        $(".circleWeek").css("box-shadow", "");
        $(this).css("box-shadow", "1px 1px 9px 3px #060606a6");
        clickCircleWeek($(this).index());
        currentWeek = $(this).index();
        getCommentsDay($(this));
    });


    $("#namesMonths").css("width", (totalWeeks + 10) * ($(".circleWeek").width() + 10));
    $("#divCircleWeeks").css("width", (totalWeeks + 10) * ($(".circleWeek").width() + 10));
}

function makeCircleWeek(numWeeks, contMonth, first, year) {
    //SOLO PARA MOVIL

    for (var i = 1; i <= numWeeks; ++i) {
        $("#divCircleWeeks").append("<div class = 'circleWeek' id='" + i + "/" + contMonth + "/" + year + "' style='background-color:" + monthColors[contMonth - 1] + "' > " + i + "w < /div>")
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
                    $("#divCircleDays").append("<div id='divCircle" + id + "' class='circleDay' style='background-color:" + object.css("background-color") + "'>" + (data[i][0].date).split("-")[2] + "</div>");
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

                    if(data[i][k].teacherFoto !== ""){ // tiene foto
                        var json2 = JSON.parse(data[i][k].teacherFoto);
                        var imageTag2 = '<div class="col-xs-12 divFotoTeacher">' + '<img id="imgPopTeacher' + id + '" class="fotoTeacher" src="" alt="image" height="100" />' + '</div>';
                        $("#divOne" + id + " .divTeachers").append(imageTag2);
                        $('#imgPopTeacher' + id).attr("src", "data:" + json2.ext + ";base64," + json2.imagen);
                        var image2 = new Image();
                        image2.src = "data:" + json2.ext + ";base64," + json2.imagen;     
                      
                    }
                    else{//defecto
                        var nameImage = "icon_Recio.svg";
                        if(data[i][k].teacherGender === "Female"){
                            nameImage = "icon_SenyoraRecio.svg";
                        }
                        $("#divOne" + id + " .divTeachers").append("<div class='col-xs-12 divFotoTeacher'><img id='imgPopTeacher" + id + "' class='fotoTeacher' src='../ParentWeb/recursos/img/iconos/"+nameImage+"' height='100'>");
                    }
                    
                    if(mapProfesores[data[i][k].nameTeacher] !== undefined) $("#divOne" + id + " .divTeachers").append("<div>"+mapProfesores[data[i][k].nameTeacher].firstName+"</div>");
                    else $("#divOne" + id + " .divTeachers").append("<div>Teacher   id: "+data[i][k].nameTeacher+"</div>");
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
