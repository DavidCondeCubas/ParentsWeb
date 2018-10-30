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
                // testTelegram();


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
                // notifyMe();
                // setTimeout(notifyMe2, 10000);

            });
            /*function testTelegram() {
             telegramApi.setConfig({
             app: {
             id: 498527, 
             hash: '17c8afa7a6588194de1360434685b5ee', 
             version: telegramApi.VERSION 
             },
             server: {
             test: [
             {
             id: 2, 
             host: '149.154.167.40',
             port: 443
             }
             ],
             production: [
             {id: 1, host: '149.154.167.50', port: 443},
             {id: 2, host: '149.154.167.50', port: 443},
             {id: 3, host: '149.154.167.50', port: 443},
             {id: 4, host: '149.154.167.50', port: 443},
             {id: 5, host: '149.154.167.50', port: 443},
             ]
             }
             });
             
             /*  angModule = angular.module("myApp", []);
             angModule.controller("mainCtrl", function ($scope) {
             $scope.person = {
             firstName: "John",
             lastName: "Doe",
             };
             });*/



            /* var options = {
             
             clearDraft: true
             }
             telegramApi.invokeApi('auth.sendCode', {
             flags: 0,
             phone_number: '+34616790081',
             api_id: 498527,
             api_hash: '17c8afa7a6588194de1360434685b5ee',
             lang_code: navigator.language || 'en'
             },options).then(function (sentCode) {
             
             var result = sentCode.phone_code_hash;
             
             });
             
             /*telegramApi.invokeApi('auth.sendCode', {
             flags: 0,
             phone_number: '0034651045332',
             api_id: 498527,
             api_hash: '17c8afa7a6588194de1360434685b5ee',
             lang_code: navigator.language || 'en'
             }).then(function (sentCode) {
             
             result = sentCode.phone_code_hash;
             
             }, function (error) {
             });
             */

            /* Auth methods */
            /* Auth methods */

            /*
             var method = 'auth.signIn'
             var params = {
             phone_number: 651045332,
             phone_code_hash: $scope.credentials.phone_code_hash,
             phone_code: 0034
             }
             
             
             MtpApiManager.invokeApi(method, params, options).then(saveAuth, function (error) {
             $scope.progress.enabled = false
             if (error.code == 400 && error.type == 'PHONE_NUMBER_UNOCCUPIED') {
             error.handled = true
             $scope.credentials.phone_code_valid = true
             $scope.credentials.phone_unoccupied = true
             $scope.about = {}
             return
             } else if (error.code == 400 && error.type == 'PHONE_NUMBER_OCCUPIED') {
             error.handled = true
             return $scope.logIn(false)
             } else if (error.code == 401 && error.type == 'SESSION_PASSWORD_NEEDED') {
             $scope.progress.enabled = true
             updatePasswordState().then(function () {
             $scope.progress.enabled = false
             $scope.credentials.phone_code_valid = true
             $scope.credentials.password_needed = true
             $scope.about = {}
             })
             error.handled = true
             return
             }
             
             switch (error.type) {
             case 'FIRSTNAME_INVALID':
             alert('FIRSTNAME_INVALID');
             
             break
             case 'LASTNAME_INVALID':
             alert('LASTNAME_INVALID');
             
             break
             case 'PHONE_CODE_INVALID':
             
             alert('PHONE_CODE_INVALID');
             
             break
             case 'PHONE_CODE_EXPIRED':
             alert('PHONE_CODE_EXPIRED');
             
             break
             }
             
             telegramApi.sendCode('0034').then(function (sent_code) {
             if (!sent_code.phone_registered) {
             alert("not found");
             }
             // phone_code_hash will need to sign in or sign up
             window.phone_code_hash = sent_code.phone_code_hash;
             });
             
             telegramApi.sendCode('651045332').then(function (sent_code) {
             if (!sent_code.phone_registered) {
             alert("not found");
             }
             // phone_code_hash will need to sign in or sign up
             window.phone_code_hash = sent_code.phone_code_hash;
             });
             */
            /*telegramApi.sendCode('0034651045332').then(function (sent_code) {
             if (!sent_code.phone_registered) {
             alert("not found");
             }
             // phone_code_hash will need to sign in or sign up
             window.phone_code_hash = sent_code.phone_code_hash;
             });
             
             telegramApi.sendSms('0034651045332', window.phone_code_hash).then(function () {
             alert("send sms")
             });
             
             /*   telegramApi.signIn('651045332', window.phone_code_hash, '0034').then(function () {
             // Sign in complete
             delete window.phone_code_hash;
             }, function (err) {
             switch (err.type) {
             case 'PHONE_CODE_INVALID':
             alert("PHONE_CODE_INVALID");
             break;
             case 'PHONE_NUMBER_UNOCCUPIED':
             // User not registered, you should use signUp method
             alert("PHONE_NUMBER_UNOCCUPIED");
             break;
             }
             });
             /* telegramApi.sendMessage(9999999999, 'Hey man!').then(function(updates) {
             // Do something
             });
             
             telegramApi.getUserInfo().then(function (user) {
             if (user.id) {
             alert("encontro usuario");
             } else {
             alert("false");
             }
             });
             */
            //}
            function donothing() {

            }
            function notifyMe2() {
                // Comprobamos si el navegador soporta las notificaciones
                if (!("Notification" in window)) {
                    alert("Este navegador no soporta las notificaciones del sistema");
                }

                // Comprobamos si ya nos habían dado permiso
                else if (Notification.permission === "granted") {
                    // Si esta correcto lanzamos la notificación
                    var notification = new Notification("after 10 seconds");
                }

                // Si no, tendremos que pedir permiso al usuario
                else if (Notification.permission !== 'denied') {
                    Notification.requestPermission(function (permission) {
                        // Si el usuario acepta, lanzamos la notificación
                        if (permission === "granted") {
                            var notification = new Notification("after 10 second");
                        }
                    });
                }




                // Finalmente, si el usuario te ha denegado el permiso y 
                // quieres ser respetuoso no hay necesidad molestar más.
            }
            function notifyMe() {
                // Comprobamos si el navegador soporta las notificaciones
                if (!("Notification" in window)) {
                    alert("Este navegador no soporta las notificaciones del sistema");
                }

                // Comprobamos si ya nos habían dado permiso
                else if (Notification.permission === "granted") {
                    // Si esta correcto lanzamos la notificación
                    var notification = new Notification("first notify");
                }

                // Si no, tendremos que pedir permiso al usuario
                else if (Notification.permission !== 'denied') {
                    Notification.requestPermission(function (permission) {
                        // Si el usuario acepta, lanzamos la notificación
                        if (permission === "granted") {
                            var notification = new Notification("first notify");
                        }
                    });
                }




                // Finalmente, si el usuario te ha denegado el permiso y 
                // quieres ser respetuoso no hay necesidad molestar más.
            }
            function delay() {
            }
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



            //<img src="<c:url value='/recursos/img/iconos/a_ReportIcon.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">

        </script>

    </head>
    <body>
        <!--<script>
            telegramApi.setConfig({
                app: {
                    id: 405384, /* App ID */
                    hash: 'f2619cbb0852a0c50721e4c7c3055e48', /* App hash */
                    version: telegramApi.VERSION /* App version */
                },
                server: {
                    test: [
                        {id: 1, host: '149.154.175.10', port: 80},
                        {id: 2, host: '149.154.167.40', port: 80},
                        {id: 3, host: '149.154.175.117', port: 80}
                    ],
                    production: [
                        {id: 1, host: '149.154.175.50', port: 80},
                        {id: 2, host: '149.154.167.51', port: 80},
                        {id: 3, host: '149.154.175.100', port: 80},
                        {id: 4, host: '149.154.167.91', port: 80},
                        {id: 5, host: '149.154.171.5', port: 80}
                    ]
                    
                }
            });
            /* telegramApi.getUserInfo().then(function (user) {
             if (user.id) {
             
             } else {
             // Log in
             }
             });*/
            telegramApi.sendCode('34651045332').then(function (sent_code) {
                if (!sent_code.phone_registered) {
                    alert("new user");
                }

                // phone_code_hash will need to sign in or sign up
                window.phone_code_hash = sent_code.phone_code_hash;
            });
            /* var app = angular.module("myApp", []);
             app.controller("mainCtrl", function ($scope) {
             angular.extend($scope, {
             update: function () {
             if ($scope._timeout) {
             return;
             }
             
             $scope._timeout = setTimeout(function () {
             delete $scope._timeout;
             $scope.$apply();
             }, 0);
             },
             visible: {
             auth: false,
             info: false
             },
             auth: {},
             info: {},
             logs: [],
             success: [],
             failed: [],
             methods: [],
             json: function (obj, indent) {
             return JSON.stringify(obj, null, indent ? 4 : 0);
             },
             showLog: function (log, type) {
             switch (type) {
             case 'console':
             console.log(log);
             break;
             case 'alert':
             alert(this.json(log, true));
             break;
             }
             },
             invokeMethod: function (method, params, onSuccess, onError) {
             telegramApi[method].apply(telegramApi, params).then(function (result) {
             $scope.success.push(result);
             $scope.update();
             onSuccess && onSuccess(result);
             }, function (err) {
             $scope.failed.push(err);
             $scope.update();
             onError && onError(err);
             });
             }
             });
             /*$scope.sendCode = function () {
             $scope.invokeMethod('sendCode', ['34651045332'], function (sent_code) {
             $scope.phone_code_hash = sent_code.phone_code_hash;
             });
             };*/
            /*  $scope.sendCode = function () {
             var fullPhone = ('34') + ('647441943')
             var badPhone = !fullPhone.match(/^[\d\-+\s]+$/)
             if (!badPhone) {
             fullPhone = fullPhone.replace(/\D/g, '')
             if (fullPhone.length < 7) {
             badPhone = true
             }
             }
             if (badPhone) {
             $scope.progress.enabled = false
             $scope.error = {field: 'phone'}
             return
             }
             
             var id = 42;
             var MtpApiManager = {
             errorField: null,
             getUserID: function () {
             return {
             then: function (callback) {
             callback(id);
             }
             };
             },
             invokeApi: function (action, params) {
             telegramApi[action].apply(telegramApi, params).then(function (result) {
             $scope.success.push(result);
             $scope.update();
             
             }, function (err) {
             $scope.failed.push(err);
             $scope.update();
             
             });
             },
             then: function (callback, error) {
             if (!this.errorField) {
             callback({})
             } else {
             error(this.errorField)
             }
             return {
             finally: function (final) {
             final()
             }
             }
             }
             }
             
             var options = {};
             //  var authKeyStarted = tsNow()
             MtpApiManager.invokeApi('auth.sendCode', {
             flags: 0,
             phone_number: '34651045332',
             api_id: '498527',
             api_hash: '17c8afa7a6588194de1360434685b5ee',
             lang_code: navigator.language || 'en'
             }, options).then(function (sentCode) {
             
             }, function (error) {
             
             });
             };
             });*/

        </script>-->
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
            <div class="col-xs-12 col-md-12 col-lg-10 col-lg-offset-1">

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
                                <strong>Activities Calendar 2018</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin ">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10  nopaddingMargin">
                                <strong>Assembly orientation montessori methodology</strong><br>
                                Presenter: Vincent Watters.
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10 nopaddingMargin">
                                <strong>Renweb platform in Spanish and English</strong><br>
                                Orientation on changing the language in ParentWEB.
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10  nopaddingMargin">
                                <strong>Registration open for football team.</strong><br>

                            </div>
                        </div>            
                    </div>  
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10 nopaddingMargin">
                                <strong>June´s menu</strong><br>

                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-2 nopaddingMargin">
                                <img src="<c:url value='/recursos/img/iconos/Icon_Announcements.svg'/>" data-toggle="tooltip" data-placement="top" title="Report Card">
                            </div>
                            <div class="col-xs-10  nopaddingMargin">
                                <strong>Flag raising ceremony</strong><br>
                                There will be a flag raising ceremony next Monday. All
                                students must wear white uniforms.Don´t be late. 
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
                                <strong>2018: Term End</strong> 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/10/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/11/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/12/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/13/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/14/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/15/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong> 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/16/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/17/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong> 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/18/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Winter vacations</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/19/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>2018: Term2 Begin</strong> 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/20/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Teacher´s day</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    07/25/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Assembly</strong> 
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 secondFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    08/01/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Progress Report</strong>
                            </div>
                        </div>            
                    </div> 
                    <div class="col-xs-12 firstFormatCalendar">
                        <div class="col-xs-12 nopaddingMargin">
                            <div class="col-xs-12 col-sm-3 col-lg-12 nopaddingMargin">
                                <div class="fechaSchool">
                                    08/02/2018
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-9 col-lg-12 nopaddingMargin">
                                <strong>Parent's meeting</strong> 
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
                                    09:00 h
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
                                    10:30 h
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
                                    09:00 h
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
                                    10:00 h
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
                                    12:00
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
            <div class="col-xs-12 tittleReport">
                Last Report card
            </div>
            <div id="idObjectReport" class="col-xs-12 objectReport">        
                <object id="objectPdf" data="" type="application/pdf" width="100%" height="100%">
                    <p>This browser does not support PDFs. Please download the PDF to view it: <a id="linkPdf" onclick="downloadPdf()">Download PDF</a>.</p>
                </object>
            </div>
        </div>
    </body>
</html>
