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

            $(document).ready(function () {
                makeCircleSons();
                $("#AreasDiv").hide();
                
                $(".circle").click(function () {
                    var color = $(this).css("background-color");

                    if (color === "rgb(5, 82, 99)") { //noSelect
                        $(".circle").css({'background-color': 'rgb(5, 82, 99)', 'color': 'white'});
                        $(this).css({'background-color': '#f99927', 'color': '#055263'});
                        $("#nameStudent").text($(this).attr("title"));
                    }
                });


            });

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
                    $("#childrensNav .row").append("<div data='" + key + "' title='" + value + "' class='circle'>" + value.substring(0, 2) + "</div>");
                });
                $("#childrensNav div").children().first().css({'background-color': '#f99927', 'color': '#055263'});
                $("#nameStudent").text($("#childrensNav div").children().first().attr("title"));
            }
        </script>
    </head>
    <body>
        <div class="col-xs-12" id="nameStudent"></div>
        <!--<div id="AreasDiv">
            <div class="col-xs-12 col-md-6 area" style="background-color: #055263;"></div>
            <div class="col-xs-12 col-md-6 area" style="background-color: #f99927;"></div>
            <div class="col-xs-12 col-md-6 area" style="background-color: #055263;"></div> 
            <div class="col-xs-12 col-md-6 area" style="background-color: #f99927;"></div>        
        </div>-->
        <div id="progressStudent">
            <div id="mySidenav" class="sidenav">
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                <a href="#">Mathematics</a>
                <a href="#">Afrikaans</a>
                <a href="#">Art</a>
                <a href="#">English</a>
                <a href="#">Music</a>
                <a href="#">Xhosa</a>
                <a href="#">Geometry</a>
            </div>

            <!-- Use any element to open the sidenav -->
            <div class="col-xs-12" id="subjectProgress"><span onclick="openNav()">open</span></div>

            <div id="accordion">
                <h1>Mathematics</h1>
                <div class="card">
                    <div class="card-header col-xs-12" id="headingThree">              

                        <h5 class="mb-0" style="width:100%">
                            <button class="btn btn-link collapsed col-xs-12 nopadding" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                <div class="col-xs-12 nopadding text-left">
                                    T1 - Counting in 2s, 5s and 10s 
                                </div>
                                <div class="col-xs-12 nopadding text-center">
                                    <div class="progress col-xs-8 col-xs-offset-2 nopadding">
                                        <div class="progress-bar progress-bar-striped active progressAttempted" role="progressbar"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" >
                                            Attempted
                                        </div>
                                        <div class="progress-bar progress-bar-striped active progressPresented" role="progressbar"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" >
                                            Presented
                                        </div>
                                    </div>
                                </div>  
                            </button>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse text-center" aria-labelledby="headingThree" data-parent="#accordion">
                        <div class="card-body">
                            Abstracting, calculating, memorising, counting                        
                        </div>
                    </div>

                </div>

                <div class="card">
                    <div class="card-header col-xs-12" id="headingFour">              

                        <h5 class="mb-0" style="width:100%">
                            <button class="btn btn-link collapsed col-xs-12 nopadding" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                <div class="col-xs-12 nopadding text-left">
                                    T1 - Ordering and sequencing numbers
                                </div>
                                <div class="col-xs-12 nopadding text-center">

                                    <div class="progress col-xs-8 col-xs-offset-2 nopadding">
                                        <div class="progress-bar progress-bar-striped active progressAttempted" role="progressbar"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" >
                                            Attempted
                                        </div>
                                        <div class="progress-bar progress-bar-striped active progressPresented" role="progressbar"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" >
                                            Presented
                                        </div>
                                        <div class="progress-bar progress-bar-striped active progressMastered" role="progressbar"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" >
                                            Mastered
                                        </div>
                                    </div>
                                </div>  
                            </button>
                        </h5>
                    </div>
                    <div id="collapseFour" class="collapse text-center" aria-labelledby="headingFour" data-parent="#accordion">
                        <div class="card-body">
                            Abstracting, analysing, calculating, concluding, identifying, recognising, decomposing, writing, spelling               
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
