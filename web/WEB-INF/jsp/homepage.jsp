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

                $(".circle").click(function () {
                    var color = $( this ).css( "background-color" );
                    
                    if(color === "rgb(5, 82, 99)"){ //noSelect
                        $(".circle").css({ 'background-color': 'rgb(5, 82, 99)', 'color': 'white' });
                        $(this).css({ 'background-color': '#f99927', 'color': '#055263' });
                        $("#nameStudent").text($(this).attr("title"));
                    }
                });
                
                $("#childrensNav div").children().first().css({ 'background-color': '#f99927', 'color': '#055263' });
                $("#nameStudent").text($("#childrensNav div").children().first().attr("title"));
            });

            function makeCircleSons() {
                $.each(sons, function (key, value) {
                    $("#childrensNav .row").append("<div data='" + key + "' title='" + value + "' class='circle'>" + value.substring(0, 2) + "</div>");
                });
            }
        </script>
    </head>
    <body>
        <div class="col-xs-12" id="nameStudent"></div>
        <div id="AreasDiv">
            <div class="col-xs-12 col-md-6 area" style="background-color: #055263;"></div>
            <div class="col-xs-12 col-md-6 area" style="background-color: #f99927;"></div>
            <div class="col-xs-12 col-md-6 area" style="background-color: #055263;"></div> 
            <div class="col-xs-12 col-md-6 area" style="background-color: #f99927;"></div>        
        </div>
    </body>
</html>
