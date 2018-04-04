function initProgress(url) {
    resetNavInf();
    currentOption = "progressStudent";
    $("#navInfProgress").empty();
   
    $("#navInfProgress").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");
    menu("progressStudent");
    $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");
}

function initProgressMenu(url) {
    currentOption = "progressStudent";
    getRating_Student();
    $("#navInfProgress").empty();
  
    $("#navInfProgress").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");
    $("#progressStudent").show();
}

function getRating_Student() {
    var id = currentStudent;
    $("#mySidenav").empty();
    $("#accordion").empty();
    $("#subjectProgress").empty();
    $.ajax({
        type: "POST",
        url: "getSubjectsStudents.htm?seleccion=" + id,
        data: id,
        dataType: 'text',
        success: function (data) {
            var data = JSON.parse(data);
            var subjects = JSON.parse(data.subjects);
            mapFinalRatings = JSON.parse(data.mapFinalRatings);

            $("#mySidenav").empty();
            $("#mySidenav").append(" <a href='javascript:void(0)' class='closebtn' onclick='closeNav()'>&times;</a>")
            for (var i = 1; i < subjects.length; i++) {
                $("#mySidenav").append("<a id='" + subjects[i] + "' href='#' class='animated zoomIn subjectsMenu'>" + mapSubjects[subjects[i]].name + "</a>")
            }

            $(".subjectsMenu").click(function () {
                $(".subjectsMenu").css({'color': '#818181'});
                $(this).css({'color': 'white'});
                showObjectivesRatings($(this).attr("id"));
                closeNav();
            });
            var firstSubject = $("#mySidenav").children().first().next().attr("id");
            if (firstSubject !== undefined)
                showObjectivesRatings(firstSubject);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(xhr.responseText);
            console.log(thrownError);
        }
    });
}

function  showObjectivesRatings(idSubject) {
    var currentMonth = new Date();

    $("#accordion").empty();
    $("#subjectProgress").empty();
    $("#subjectProgress").append("<div col-xs-3  onclick='openNav()'><span class='glyphicon glyphicon-chevron-left'></span><span>Subjects</span></div>");
    $("#subjectProgress").append("<div col-xs-6>" + (mapSubjects[idSubject].name).toUpperCase() + "</h1></div>");
    $("#subjectProgress").append("<div col-xs-3>" + monthNames[currentMonth.getMonth()] + "</div>");

    $.each(mapFinalRatings, function (key, value) {
        if (mapObjectives[key.split("_")[1]].idSubject == idSubject) {
            $("#accordion").append("<div class='card '>\n\
                                                <div class='card-header col-xs-12' id='heading" + key + "'>\n\
                                                    <h5 class='mb-0' style='width:100%'\n\
                                                        <button class='btn btn-link collapsed col-xs-12 nopadding' data-toggle='collapse' data-target='#collapse" + key + "' aria-expanded='false' aria-controls='collapse" + key + "'>\n\
                                                            <div class='col-xs-12 nopadding text-left'>\n\
                                                            " + mapObjectives[key.split("_")[1]].name + "\
                                                            </div>\n\
                                                            <div class='col-xs-12 nopadding text-center'>\n\
                                                                <div class='progress col-xs-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2 nopadding'>\n\
                                                                " + drawRating(value) + "\n\
                                                                </div>\n\
                                                            </div>\n\
                                                        </button>\n\
                                                    </h5>\n\
                                                </div>\n\
                                                <div id='collapse" + key + "' class='collapse text-center' aria-labelledby='heading" + key + "' data-parent='#accordion'>\n\
                                                    <div class='card-body'>\n\
                                                        " + mapObjectives[key.split("_")[1]].description + "\n\
                                                    </div>\n\
                                                </div>\n\
                                            </div>");
        }
    });

    $.each(mapFinalRatings, function (key, value) {
        if (mapObjectives[key.split("_")[1]].idSubject == idSubject) {
            $("#accordion").append("<div class='card '>\n\
                                                <div class='card-header col-xs-12' id='heading" + key + "'>\n\
                                                    <h5 class='mb-0' style='width:100%'\n\
                                                        <button class='btn btn-link collapsed col-xs-12 nopadding' data-toggle='collapse' data-target='#collapse" + key + "' aria-expanded='false' aria-controls='collapse" + key + "'>\n\
                                                            <div class='col-xs-12 nopadding text-left'>\n\
                                                            " + mapObjectives[key.split("_")[1]].name + "\
                                                            </div>\n\
                                                            <div class='col-xs-12 nopadding text-center'>\n\
                                                                <div class='progress col-xs-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2 nopadding'>\n\
                                                                " + drawRating(value) + "\n\
                                                                </div>\n\
                                                            </div>\n\
                                                        </button>\n\
                                                    </h5>\n\
                                                </div>\n\
                                                <div id='collapse" + key + "' class='collapse text-center' aria-labelledby='heading" + key + "' data-parent='#accordion'>\n\
                                                    <div class='card-body'>\n\
                                                        " + mapObjectives[key.split("_")[1]].description + "\n\
                                                    </div>\n\
                                                </div>\n\
                                            </div>");
        }
    });
    $.each(mapFinalRatings, function (key, value) {
        if (mapObjectives[key.split("_")[1]].idSubject == idSubject) {
            $("#accordion").append("<div class='card '>\n\
                                                <div class='card-header col-xs-12' id='heading" + key + "'>\n\
                                                    <h5 class='mb-0' style='width:100%'\n\
                                                        <button class='btn btn-link collapsed col-xs-12 nopadding' data-toggle='collapse' data-target='#collapse" + key + "' aria-expanded='false' aria-controls='collapse" + key + "'>\n\
                                                            <div class='col-xs-12 nopadding text-left'>\n\
                                                            " + mapObjectives[key.split("_")[1]].name + "\
                                                            </div>\n\
                                                            <div class='col-xs-12 nopadding text-center'>\n\
                                                                <div class='progress col-xs-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2 nopadding'>\n\
                                                                " + drawRating(value) + "\n\
                                                                </div>\n\
                                                            </div>\n\
                                                        </button>\n\
                                                    </h5>\n\
                                                </div>\n\
                                                <div id='collapse" + key + "' class='collapse text-center' aria-labelledby='heading" + key + "' data-parent='#accordion'>\n\
                                                    <div class='card-body'>\n\
                                                        " + mapObjectives[key.split("_")[1]].description + "\n\
                                                    </div>\n\
                                                </div>\n\
                                            </div>");
        }
    });
    //DIV VACIO PARA DARLE ESPACIO A LA BARRA INFERIOR
    $("#accordion").append("<div class='card '>\n\
                                                <div class='card-header col-xs-12' style='height:50px'>\n\
                                                    <h5 class='mb-0' style='width:100%'\n\
                                                        <button class='btn btn-link collapsed col-xs-12 nopadding' data-toggle='collapse'  aria-expanded='false'>\n\
                                                            <div class='col-xs-12 nopadding text-left'>\n\
                                                            \
                                                            </div>\n\
                                                            <div class='col-xs-12 nopadding text-center'>\n\
                                                                <div class='col-xs-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2 nopadding'>\n\
                                                                \n\
                                                                </div>\n\
                                                            </div>\n\
                                                        </button>\n\
                                                    </h5>\n\
                                                </div>\n\
                                            </div>");
}
function drawRating(rating) {
    var res = "<div class='progress-bar progress-bar-striped active progressAttempted' role='progressbar'aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' >\n\
                            Attempted \n\
                        </div> ";
    if (rating === "Presented") {
        res += " <div class='progress-bar progress-bar-striped active progressPresented' role='progressbar'aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' >\n\
                            Presented \n\
                        </div> "
    } else if (rating === "Mastered") {
        res += " <div class='progress-bar progress-bar-striped active progressMastered' role='progressbar'aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' >\n\
                            Mastered \n\
                        </div> "
    }
    return res;

}