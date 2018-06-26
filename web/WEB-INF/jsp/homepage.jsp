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
            var mapSteps = ${mapSteps};
            var mapFinalRatings;
            var currentStudent;
            var currentOption;
            var colorVerde = "#3aaa35";

            var monthNames = ["January", "February", "March", "April", "May", "June",
                "Jule", "August", "September", "October", "November", "December"];

            var monthColors = ["#ff9529", "#451c8c", "#3d962d", "#054663",
                "#ff9529", "#451c8c", "#3d962d", "#054663",
                "#ff9529", "#451c8c", "#3d962d", "#054663"];

            $(document).ready(function () {



                makeCircleSons();
                mostrarHome();
                //$("#navInfReport").hide();
                $("#navBarDesktop").hide();
                $(".opcionMenuDesktop").click(function () {
                    var idOption = $(this).attr("value");
                    $(this).parent().children().css("background-color", colorVerde);
                    $(this).css("background-color", "#1d1d1b");

                    $(this).parent().children().css("font-weight", "");
                    $(this).css("font-weight", "bold");

                    $("#" + idOption).click();
                });

                $(".circle").click(function () {
                    var color = $(this).css("background-color");
                    if (color === "rgb(139, 194, 110)") { //noSelect
                        currentStudent = $(this).attr("data");
                        $(".circle").css({'background-color': 'rgb(139, 194, 110)', 'color': 'white'});
                        $(this).css({'background-color': '#3aaa35', 'color': 'white'});
                        $("#nameStudent").text($(this).attr("title"));
                        menu(currentOption);
                    }
                });

                $(".btnHomepage").click(function () {
                    menu($(this).attr("value"));
                });

                $("#navbarInferior div").click(function () {
                    var nameDiv = $(this).attr("id"), url;
                    hideAllElements();

                    $("#homepage").hide();
                    $("#" + nameDiv).show();

                    switch (nameDiv) {
                        case "navInfProgress":
                            url = "<c:url value='/recursos/img/iconos/n_ProgressIconNaranja.svg'/>";
                            initProgress(url);
                            break;
                        case "navInfObservations":
                            url = "<c:url value='/recursos/img/iconos/n_ObservationIconNaranja.svg'/>";
                            initObservations(url);
                            // getCirclesWeeks();
                            break;
                        case "navInfWhatIam":
                            url = "<c:url value='/recursos/img/iconos/n_LearningIconNaranja.svg'/>";
                            initWhatDoing(url);

                            /* resetNavInf();
                             currentOption = "whatIdo";
                             $("#navInfWhatIam").empty();
                             url = "<c:url value='/recursos/img/iconos/n_LearningIconNaranja.svg'/>";
                             $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='What I am learning now?'>");
                             menu("whatIdo");
                             $("#navInfReport").hide();
                             $("#navInfMore").attr("value", "a_MenuIcon.svg");*/
                            break;
                        case "navInfCalendar":

                            url = "<c:url value='/recursos/img/iconos/n_CalendarIconNaranja.svg'/>";
                            initCalendar(url);
                            //  $("#navInfMore").attr("value", "a_MenuIcon.svg");

                            break;
                        case "navInfReport":
                            /*  resetNavInf();
                             currentOption = "report";
                             $("#navInfReport").empty();
                             url = "<c:url value='/recursos/img/iconos/n_ReportIconNaranja.svg'/>";
                             $("#navInfReport").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
                             menu("report");
                             $("#navInfReport").hide();
                             $("#navInfMore").attr("value", "a_MenuIcon.svg");*/

                            url = "<c:url value='/recursos/img/iconos/n_ReportIconNaranja.svg'/>";
                            initReportCard(url);

                            ;
                            break

                        default: //more
                            var prevState = $("#navInfMore").attr("value") === "a_MenuIcon.svg";
                            $("#navInfProgress").empty();
                            $("#navInfObservations").empty();
                            $("#navInfWhatIam").empty();
                            $("#navInfCalendar").empty();

                            var url = "<c:url value='/recursos/img/iconos/a_ProgressIcon.svg'/>";
                            $("#navInfProgress").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");

                            url = "<c:url value='/recursos/img/iconos/a_ObservationIcon.svg'/>";
                            $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");

                            url = "<c:url value='/recursos/img/iconos/a_LearningIcon.svg'/>";
                            $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='What I am learning now?'>");

                            url = "<c:url value='/recursos/img/iconos/a_CalendarIcon.svg'/>";
                            $("#navInfCalendar").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");


                            $("#navInfMore").empty();
                            if (prevState) {

                                url = "<c:url value='/recursos/img/iconos/n_MenuIconNaranja.svg'/>";
                                $("#navInfMore").attr("value", "n_MenuIconNaranja.svg");
                                $("#navInfReport").show();
                            } else {
                                /* 
                                 if ($("#navInfReport").attr("value") !== "n_ReportIconNaranja.svg") {
                                 
                                 $("#navInfMore").empty();
                                 }*/
                                url = "<c:url value='/recursos/img/iconos/a_MenuIcon.svg'/>";
                                $("#navInfMore").attr("value", "a_MenuIcon.svg");
                                $("#navInfReport").hide();

                            }
                            $("#navInfMore").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='More'>");
                    }


                });

            });

            function hideAllOptionsContent() {
                $("#progressStudent").hide();
                $("#teacherObservations").hide();
                $("#teacherObsDesktopView").hide();
                $("#whatsDoingPage").hide();
                $("#reportPage").hide();
                $("#calendarPage").hide();
            }

            function menu(nameDiv) {
                document.body.style.backgroundColor = "white";

                hideAllOptionsContent();
                var url = "";
                $("#homepage").hide();
                $("#" + nameDiv).show();
                $("#navbarInferior").show();
                //     $("#navBarDesktop").show();
                if ($('header').width() >= 768)     // Landscape phones
                    $("#navBarDesktop").show();

                switch (nameDiv) {
                    case "progressStudent":
                        paintButtonMenu(1);
                        url = "<c:url value='/recursos/img/iconos/n_ProgressIconNaranja.svg'/>";
                        initProgressMenu(url);
                        break;
                    case "teacherObservations":
                        paintButtonMenu(2);
                        url = "<c:url value='/recursos/img/iconos/n_ObservationIconNaranja.svg'/>";
                        initObservationsMenu(url);
                        break;
                    case "whatIdo":
                        paintButtonMenu(3);
                        url = "<c:url value='/recursos/img/iconos/n_LearningIconNaranja.svg'/>";
                        initWhatDoingMenu(url);
                        break;
                    case "calendar":
                        paintButtonMenu(4);
                        url = "<c:url value='/recursos/img/iconos/n_CalendarIconNaranja.svg'/>";
                        initCalendarMenu(url);
                        break;
                    case "report":
                        //  $("#navBarDesktop div:nth-child(5)").click();
                        paintButtonMenu(5);
                        url = "<c:url value='/recursos/img/iconos/n_ReportIconNaranja.svg'/>";
                        initReportCardMenu(url);

                        break;
                    default: //more
                        text = "I have never heard of that fruit...";
                }


            }
            function hideAllElements() {
                $("#mySidenav").empty();
                $("#accordion").empty();
                $("#subjectProgress").empty();
            }
            function resetNavInf() {
                $("#navInfProgress").empty();
                $("#navInfObservations").empty();
                $("#navInfWhatIam").empty();
                $("#navInfCalendar").empty();
                $("#navInfMore").empty();
                $("#navInfReport").empty();

                var url = "<c:url value='/recursos/img/iconos/a_ProgressIcon.svg'/>";
                $("#navInfProgress").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");

                url = "<c:url value='/recursos/img/iconos/a_ObservationIcon.svg'/>";
                $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");

                url = "<c:url value='/recursos/img/iconos/a_LearningIcon.svg'/>";
                $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='What I am learning now?'>");

                url = "<c:url value='/recursos/img/iconos/a_CalendarIcon.svg'/>";
                $("#navInfCalendar").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");

                url = "<c:url value='/recursos/img/iconos/a_MenuIcon.svg'/>";
                $("#navInfMore").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='More'>");

                url = "<c:url value='/recursos/img/iconos/a_ReportIcon.svg'/>";
                $("#navInfReport").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Report Card'>");

            }

            function mostrarHome() {
                $("#progressStudent").hide();
                $("#teacherObservations").hide();
                $("#whatsDoingPage").hide();
                $("#calendarPage").hide();
                $("#reportPage").hide();
                $("#navbarInferior").hide();
                $("#homepage").show();
            }
            /* Set the width of the side navigation to 250px and the left margin of the page content to 250px and add a black background color to body */
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
                document.getElementById("accordion").style.marginLeft = "250px";
                //document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
            }

            /* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
            function closeNav() {
                if ($('header').width() <= 768) { // solos e cerrara para las las tablets y moviles
                    document.getElementById("mySidenav").style.width = "0";
                    document.getElementById("accordion").style.marginLeft = "0";
                    document.body.style.backgroundColor = "white";
                }
            }

            function makeCircleSons() {
                $.each(sons, function (key, value) {
                    $("#childrensNav .row").append("<div data-GradeLevel='" + value[1] + "' data='" + key + "' title='" + value[0] + "' class='circle'>" + value[0].substring(0, 2).toUpperCase() + "</div>");
                });
                currentStudent = $("#childrensNav div").children().first().attr("data");

                $("#childrensNav div").children().first().css({'background-color': '#3aaa35', 'color': 'white'});
                $("#nameStudent").text($("#childrensNav div").children().first().attr("title"));
            }

            var resizeId;
            $(window).resize(function () {
                clearTimeout(resizeId);
                resizeId = setTimeout(doneResizing, 500);
            });

            function doneResizing() {
                /*if (currentOption === "teacherObservations") {
                 if ($('header').width() < 769) {
                 resizeMargins();
                 } else {
                 if (!$("#teacherObsDesktopView").is(":visible"))
                 getCirclesWeeks();
                 }
                 
                 }*/
                /*Extra small devices
                 Portrait phones (<544px)
                 Small devices
                 (≥544px - <768px)
                 Medium devices
                 Tablets (≥768px - <992px)
                 Large devices
                 Desktops (≥992px - <1200px)
                 Extra large devices
                 Desktops (≥1200px)*/
                if ($('header').width() < 544) {// is mobile device
                    $("#navBarDesktop").hide();

                } else if ($('header').width() < 768) {    // Landscape phones
                    $("#navBarDesktop").hide();

                } else if ($('header').width() < 992) { //Tablets 
                    if (currentOption !== undefined)
                        $("#navBarDesktop").show();

                } else if ($('header').width() < 1200) { // Desktops
                    if (currentOption !== undefined)
                        $("#navBarDesktop").show();

                } else { //Desktops
                    if (currentOption !== undefined)
                        $("#navBarDesktop").show();

                }
                resizeMargins();
            }


            function paintButtonMenu(indice) {

                $("#navBarDesktop div").css("background-color", colorVerde);
                $("#navBarDesktop div:nth-child(" + indice + ")").css("background-color", "#1d1d1b");
                $("#navBarDesktop div").css("font-weight", "");
                $("#navBarDesktop div:nth-child(" + indice + ")").css("font-weight", "bold");
            }
            function downloadPdf() {
                var pdfResult = $("#objectPdf").attr("data").split(',')[1];
                let pdfWindow = window.open("");
                pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64, " + encodeURI(pdfResult) + "'></iframe>");
            }
            function downloadPdf_2() {
                var out = $("#objectPdf").attr("data");
                window.open(out);
            }

            function functionPdf_3() {
                var pdfResult = $("#objectPdf").attr("data").split(',')[1];
                solution1(pdfResult);
            }
            function solution1(base64Data) {

                var arrBuffer = base64ToArrayBuffer(base64Data);

                // It is necessary to create a new blob object with mime-type explicitly set
                // otherwise only Chrome works like it should
                var newBlob = new Blob([arrBuffer], {type: "application/pdf"});

                // IE doesn't allow using a blob object directly as link href
                // instead it is necessary to use msSaveOrOpenBlob
                if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                    window.navigator.msSaveOrOpenBlob(newBlob);
                    return;
                }

                // For other browsers: 
                // Create a link pointing to the ObjectURL containing the blob.
                var data = window.URL.createObjectURL(newBlob);

                var link = document.createElement('a');
                document.body.appendChild(link); //required in FF, optional for Chrome
                link.href = data;
                link.download = "file.pdf";
                link.click();
                window.URL.revokeObjectURL(data);
                link.remove();
            }

            function base64ToArrayBuffer(data) {
                var binaryString = window.atob(data);
                var binaryLen = binaryString.length;
                var bytes = new Uint8Array(binaryLen);
                for (var i = 0; i < binaryLen; i++) {
                    var ascii = binaryString.charCodeAt(i);
                    bytes[i] = ascii;
                }
                return bytes;
            }
            ;
            //<img src="<c:url value='/recursos/img/iconos/a_ReportIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
        </script>
    </head>
    <body>
        <div class="col-xs-12" id="nameStudent"></div>
        <div class="col-md-12" id="navBarDesktop">
            <div  value="navInfProgress" class="opcionMenuDesktop">
                Academic Progress
            </div>
            <div   value="navInfObservations" class="opcionMenuDesktop">
                Teachers Observations
            </div>
            <div   value="navInfWhatIam" class="opcionMenuDesktop">
                What I am learning <br>now?
            </div>
            <div   value="navInfCalendar" class="opcionMenuDesktop">
                Calendar and Announcements
            </div>
            <div   value="navInfReport" class="opcionMenuDesktop">
                Report Card
            </div>
        </div>     
        <div id="homepage" class="container-fluid">
            <div class="col-xs-12 col-md-12 col-lg-12">

                <div class="col-xs-6 col-sm-offset-1 col-sm-5 col-md-offset-0 col-md-4  col-lg-offset-0 col-lg-4">
                    <div class="btnHomepage col-xs-12" value="progressStudent" style="background-color:#862200;">
                        <img src="<c:url value='/recursos/img/iconos/a_ProgressIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Student Progress">
                        <p>Academic Progress</P>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-5 col-md-4 col-lg-4">
                    <div class="btnHomepage col-xs-12" value="teacherObservations" style="background-color:#055263;">
                        <img src="<c:url value='/recursos/img/iconos/a_ObservationIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Teachers Observations" style="margin-left:15px;">
                        <p> Teachers Observations</P>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-offset-1 col-sm-5 col-md-offset-0 col-md-4 col-lg-offset-0 col-lg-4">
                    <div class="btnHomepage col-xs-12" value="whatIdo" style="background-color:#333333;">
                        <img src="<c:url value='/recursos/img/iconos/a_LearningIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="What I am learning now?">
                        <p>What I am learning now?</P>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-5 col-md-4 col-lg-4">
                    <div class="btnHomepage col-xs-12" value="calendar" style="background-color:#c4a72b;">
                        <img src="<c:url value='/recursos/img/iconos/a_CalendarIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Calendar and Announcements">
                        <p>Calendar and Announcements</P>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-offset-1 col-sm-5 col-md-offset-0 col-md-4 col-lg-offset-0 col-lg-4">
                    <div class="btnHomepage col-xs-12" value="report" style="background-color:#fd8469;">
                        <img src="<c:url value='/recursos/img/iconos/a_ReportIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                        <p>Report Card</P>
                    </div>
                </div>
            </div>
        </div>
        <div id="progressStudent">
            <div id="mySidenav" class="sidenav">
                <div>
                </div>
            </div>
            <div class="col-xs-12" id="subjectProgress"></div>
            <div id="accordion">
            </div>
        </div>

        <div id="teacherObservations">
            <div id="allWeeks" class="col-xs-12 col-md-offset-1 col-md-10">
                <div  id="namesMonths" class="col-xs-12 col-sm-offset-1 col-sm-10">
                </div>
                <div id="divCircleWeeks" class="col-xs-12 col-sm-offset-2 col-sm-8">
                    <div class="col-xs-2">Week:</div>
                    <div class="col-xs-10 weekNumbers"></div>
                </div>
            </div>
            <div id="divObservations" class="col-xs-12 col-md-offset-1 col-md-10 col-lg-offset-2 col-lg-8">
                <!-- <div id="allDays" class="col-xs-1">
                     <div id="divCircleDays">
                     </div>
                 </div>            --> 
                <div  id="divAllComments" class="col-xs-12 nopaddingMargin">
                </div>
            </div>    

        </div>
        <div id="teacherObsDesktopView" style="display:none">
            <div  id="namesMonthsDesktop"></div>
            <div id="contentTeacherObservationsDesktop" style="    display: flex;">
                <div class="allWeeksDesktop" class="col-xs-12">
                    <div id="divWeekDesktop">
                        <div id="divCircleWeeksDesktop">
                            <div class = 'circleWeek'  style='background-color:#f99927' > 1w </div>
                        </div>
                        <div style="max-height: -webkit-fill-available;overflow:auto;width: 350px;margin-right: 0px;">
                            <div style="position: relative; max-width:100%; overflow:auto;width: 450px;">
                                <div  id="divAllCommentsDesktop" class="col-xs-10 nopaddingMargin divAllCommentsStyle">
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>

                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div> 
                        </div>
                    </div>  
                </div>
                <div class="allWeeksDesktop" class="col-xs-12">
                    <div id="divWeekDesktop">
                        <div id="divCircleWeeksDesktop">
                            <div class = 'circleWeek'  style='background-color:#f99927' > 1w </div>
                        </div>
                        <div style="max-height: -webkit-fill-available;overflow:auto;width: 350px;margin-right: 0px;">
                            <div style="position: relative; max-width:100%; overflow:auto;width: 450px;">
                                <div  id="divAllCommentsDesktop" class="col-xs-10 nopaddingMargin divAllCommentsStyle">
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>

                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div> 
                        </div>
                    </div>  
                </div>
                <div class="allWeeksDesktop" class="col-xs-12">
                    <div id="divWeekDesktop">
                        <div id="divCircleWeeksDesktop">
                            <div class = 'circleWeek'  style='background-color:#f99927' > 1w </div>
                        </div>
                        <div style="max-height: -webkit-fill-available;overflow:auto;width: 350px;margin-right: 0px;">
                            <div style="position: relative; max-width:100%; overflow:auto;width: 450px;">
                                <div  id="divAllCommentsDesktop" class="col-xs-10 nopaddingMargin divAllCommentsStyle">
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>

                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                    <div class='divComments col-xs-12'>
                                        <div class='divInfoComment' class='col-xs-12 nopaddingMargin'>
                                            <div class="col-xs-12 nopaddingMargin">
                                                <div class="col-xs-8 nopaddingMargin">
                                                    <strong class="circleColor"> Type:</strong> &nbsp; <strong>General</strong>
                                                </div>
                                                <div class="col-xs-4 nopaddingMargin text-right">
                                                    <strong class="circleColor">25/04/2018</strong><br> 
                                                </div> 
                                            </div>
                                            <p>Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto</p>
                                        </div>
                                        <div class="divTeachers col-xs-12 ">
                                            <div class="col-xs-offset-3 col-xs-6 text-right" >Megan Moore</div>
                                            <div class="col-xs-3 divFotoTeacher nopaddingMargin">
                                                <img id="imgPopTeacher9" class="fotoTeacher" src="http://media.beam.usnews.com/e7/39/200d98cf4e538f62a25682c75b07/171219-teacher-stock.jpg" alt="image" >              
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div> 
                        </div>
                    </div>  
                </div>
            </div>
        </div>


        <div id="whatsDoingPage" class="col-xs-12"> 
            <div class="col-xs-12 nopaddingMargin" id="infWhatPrincipal" >
                <div class="col-xs-12 infWhat" value ="attemptedWeek" >
                    What i attempted this week
                </div>
            </div>

            <div class="col-xs-12 col-md-10 col-md-offset-1" id="accordionWhats">       

            </div>

            <div class="col-xs-12  nopaddingMargin" id="navInfWhatIDoing">
                <div class="col-xs-6 infWhat btnInfNavWhat btnSecundario" value ="masterWeek" >
                    What i mastered this week  
                </div>
                <div class="col-xs-6 infWhat btnInfNavWhat btnSecundario"  value="plannedWeek">
                    What I have planned next week  
                </div>
            </div>
        </div>

        <div class="col-xs-12 nopaddingMargin" id="navbarInferiorContenedor">
            <div class="col-xs-12 " id="navbarInferior">
                <div class="col-xs-2 col-sm-2 col-md-2" id="navInfProgress" value="a_ProgressIcon.svg">
                    <img src="<c:url value='/recursos/img/iconos/a_ProgressIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Student Progress">
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2" id="navInfObservations" value="a_ObservationIcon.svg">
                    <img src="<c:url value='/recursos/img/iconos/a_ObservationIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Teachers Observations">
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2" id="navInfWhatIam" value="a_LearningIcon.svg">
                    <img src="<c:url value='/recursos/img/iconos/a_LearningIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="What I am learning now?">
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2" id="navInfCalendar" value="a_CalendarIcon.svg">
                    <img src="<c:url value='/recursos/img/iconos/a_CalendarIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Calendar and Announcements">
                </div>
                <!--<div class="col-xs-2 col-sm-2 col-md-2" id="navInfMore" value="a_MenuIcon.svg">
                    <img src="<c:url value='/recursos/img/iconos/a_MenuIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="More">
                </div>-->
                <div class="col-xs-2 col-sm-2 col-md-2"  id="navInfReport" value="a_ReportIcon.svg">
                    <img src="<c:url value='/recursos/img/iconos/a_ReportIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                </div>
            </div>
        </div> 
        <div id="calendarPage">
            <div id="announcements" class="col-xs-12 col-md-6 col-lg-3">
                <div class="col-xs-12 contenedorAnnon">
                    <div class="col-xs-12 titleCalendar">
                        Announcements        
                    </div>                   
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin ">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10  nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10  nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div>  
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10  nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div>

                </div> 
            </div>
            <div id="schoolCalendar" class="col-xs-12 col-md-6 col-lg-3">
                <div class="col-xs-12 contenedorAnnon">
                    <div class="col-xs-12 titleCalendar">
                        School Calendar: Dates to note     
                    </div>                   
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                </div>
            </div>
            <div id="todayEvents" class="col-xs-12 col-md-6 col-lg-3">
                <div class="col-xs-12 contenedorAnnon">
                    <div class="col-xs-12 titleCalendar">
                       Today´s Events     
                    </div>                   

                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                </div>
            </div>
             <div id="tomorrowEvents" class="col-xs-12 col-md-6 col-lg-3">
                <div class="col-xs-12 contenedorAnnon">
                    <div class="col-xs-12 titleCalendar">
                       Tomorrow´s Events     
                    </div>                   

                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/04/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                Lorem Ipsum has been the industry's standard dummy. 
                            </div>
                        </div>            
                    </div> 
                </div>
            </div>
        </div>
        <div id="reportPage" class="col-xs-10 col-xs-offset-1 col-md-8 col-md-offset-2 ">
            <object id="objectPdf" data="" type="application/pdf" width="100%" height="100%">
                <p><b>Example fallback content</b>: This browser does not support PDFs. Please download the PDF to view it: <a id="linkPdf" href="">Download PDF</a>.</p>
            </object>
            <div class="col-xs-12">
                <button onclick="downloadPdf_2()"> test 2 </button>
                <button onclick="downloadPdf()"> test 1 </button>
                <button onclick="downloadPdf_3()"> test 3</button>
            </div>
        </div>
    </body>
</html>
