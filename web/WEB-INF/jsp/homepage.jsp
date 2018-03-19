<%--
    Document   : homepage
    Created on : 24-ene-2017, 12:12:45
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>

    <head>
        <title>Parents Web</title>

        <script type="text/javascript">

            var userId = ${user.id};
            var sons = ${sons};
            var mapSubjects = ${mapSubjects};
            var mapProfesores = ${mapProfesor};
            var mapObjectives = ${mapObjectives};
            var mapFinalRatings;
            var currentStudent;
            
            $(document).ready(function () {
                makeCircleSons();
                mostrarHome();

                $(".circle").click(function () {
                    var color = $(this).css("background-color");
                    if (color === "rgb(5, 82, 99)") { //noSelect
                        currentStudent = $(this).attr("data");
                        $(".circle").css({'background-color': 'rgb(5, 82, 99)', 'color': 'white'});
                        $(this).css({'background-color': '#f99927', 'color': '#055263'});
                        $("#nameStudent").text($(this).attr("title"));
                        +
                                getRating_Student();
                    }
                });


                $(".btnHomepage").click(function () {
                    var nameDiv = $(this).attr("value")
                    switch (nameDiv) {
                        case "progressStudent":
                            getRating_Student();
                            break;
                        case "teacherObservations":
                            text = "I am not a fan of orange.";
                            break;
                        case "whatIdo":
                            text = "How you like them apples?";
                            break;
                        case "calendar":
                            text = "How you like them apples?";
                            break;
                        default: //reportcard
                            text = "I have never heard of that fruit...";
                    }

                    $("#" + nameDiv).show();
                    $("#homepage").hide();
                });
            });

            function getRating_Student() {
                var id = currentStudent;
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
                        for (var i = 0; i < subjects.length; i++) {
                            $("#mySidenav").append("<a id='" + subjects[i] + "' href='#' class='subjectsMenu'>" + mapSubjects[subjects[i]].name + "</a>")
                        }

                        $(".subjectsMenu").click(function () {
                            $(".subjectsMenu").css({'color': '#818181'});
                            $(this).css({'color': 'white'});
                            showObjectivesRatings($(this).attr("id"));
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }
                });
            }

            function  showObjectivesRatings(idSubject){
                $("#accordion").empty();
                $("#accordion").append("<h1>"+mapSubjects[idSubject].name+"</h1>");
                
                 $.each(mapFinalRatings, function (key, value) {
                    $("#accordion").append("<div class='card'>\n\
                                                <div class='card-header col-xs-12' id='heading"+key+"'>\n\
                                                    <h5 class='mb-0' style='width:100%'\n\
                                                        <button class='btn btn-link collapsed col-xs-12 nopadding' data-toggle='collapse' data-target='#collapse"+key+"' aria-expanded='false' aria-controls='collapse"+key+"'>\n\
                                                            <div class='col-xs-12 nopadding text-left'>\n\
                                                            "+"NOMBRE DE OBJETIVO"+"\
                                                            </div>\n\
                                                            <div class='col-xs-12 nopadding text-center'>\n\
                                                                <div class='progress col-xs-8 col-xs-offset-2 nopadding'>\n\
                                                                "+drawRating(value)+"\n\
                                                                </div>\n\
                                                            </div>\n\
                                                        </button>\n\
                                                    </h5>\n\
                                                </div>\n\
                                                <div id='collapse"+key+"' class='collapse text-center' aria-labelledby='heading"+key+"' data-parent='#accordion'>\n\
                                                    <div class='card-body'>\n\
                                                        descripcionObjective\n\
                                                    </div>\n\
                                                </div>\n\
                                            </div>");
                });
            }
            function drawRating(rating){
                var res="<div class='progress-bar progress-bar-striped active progressAttempted' role='progressbar'aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' >\n\
                            Attempted \n\
                        </div> ";
                if(rating === "Presented"){
                    res += " <div class='progress-bar progress-bar-striped active progressPresented' role='progressbar'aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' >\n\
                            Presented \n\
                        </div> "
                }
                else if(rating === "Mastered"){
                    res +=  " <div class='progress-bar progress-bar-striped active progressMastered' role='progressbar'aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' >\n\
                            Mastered \n\
                        </div> "
                }
                return res;
                             
            }
            function mostrarHome() {
                $("#progressStudent").hide();
                $("#homepage").show();
            }
            /* Set the width of the side navigation to 250px and the left margin of the page content to 250px and add a black background color to body */
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
                document.getElementById("accordion").style.marginLeft = "250px";
                document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
            }

            /* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
                document.getElementById("accordion").style.marginLeft = "0";
                document.body.style.backgroundColor = "white";
            }

            function makeCircleSons() {
                $.each(sons, function (key, value) {
                    $("#childrensNav .row").append("<div data-GradeLevel='" + value[1] + "' data='" + key + "' title='" + value[0] + "' class='circle'>" + value[0].substring(0, 2) + "</div>");
                });
                currentStudent = $("#childrensNav div").children().first().attr("data");
                $("#childrensNav div").children().first().css({'background-color': '#f99927', 'color': '#055263'});
                $("#nameStudent").text($("#childrensNav div").children().first().attr("title"));
            }
        </script>
    </head>
    <body>
        <div class="col-xs-12" id="nameStudent"></div>

        <div id="homepage" class="col-xs-12">
            <div class="col-xs-12 col-md-12 col-lg-12">
                <div class="btnHomepage col-xs-4 col-xs-offset-2 col-md-4 col-md-offset-2 col-lg-2 col-lg-offset-3" value="progressStudent" style="background-color:#f99927;">
                    <img width="60%" src="<c:url value='/recursos/img/iconos/avance-profesional.svg'/>" data-toggle="tooltip" data-placement="top" title="Student Progress">
                    <p>Academic Progress</P>
                </div>
                <div class="btnHomepage col-xs-4 col-xs-offset-1 col-md-4 col-md-offset-1 col-lg-2 col-lg-offset-1"  value="teacherObservations" style="background-color:#055263;">
                    <img width="60%" src="<c:url value='/recursos/img/iconos/blog.svg'/>" data-toggle="tooltip" data-placement="top" title="Teachers Observations" style="margin-left:15px;">
                    <p> Teachers Observations</P>
                </div>
            </div>
            <div class="col-xs-12">
                <div class="btnHomepage col-xs-4 col-xs-offset-2 col-md-4 col-md-offset-2 col-lg-2 col-lg-offset-3" value="whatIdo" style="background-color:#333333;">
                    <img width="60%" src="<c:url value='/recursos/img/iconos/hombre-leyendo.svg'/>" data-toggle="tooltip" data-placement="top" title="What I am learning now?">
                    <p>What I am learning now?</P>
                </div>
                <div class="btnHomepage col-xs-4 col-xs-offset-1 col-md-4 col-md-offset-1 col-lg-2 col-lg-offset-1"  value="calendar" style="background-color:#50d1c1;">
                    <img width="60%" src="<c:url value='/recursos/img/iconos/megafono (2).svg'/>" data-toggle="tooltip" data-placement="top" title="Calendar and Announcements">
                    <p>Calendar and Announcements</P>
                </div>
            </div>
            <div class="col-xs-12">
                <div class="btnHomepage col-xs-4 col-xs-offset-2 col-md-4 col-md-offset-2 col-lg-2 col-lg-offset-3" value="reportCard" style="background-color:#fd8469;">     
                    <img width="60%" src="<c:url value='/recursos/img/iconos/analitica.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                    <p>Report Card</P>
                </div> 
            </div>

        </div>
        <div id="progressStudent">
            <div id="mySidenav" class="sidenav">
                <div>
                </div>
            </div>


            <div class="col-xs-12" id="subjectProgress"><span onclick="openNav()">open</span></div>

            <div id="accordion">
             
            </div>
        </div>
    </body>
</html>
