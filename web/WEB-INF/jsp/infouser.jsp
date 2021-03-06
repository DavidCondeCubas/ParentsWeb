<%-- 
    Document   : bannerinfo
    Created on : 12-jul-2016, 16:23:16
    Author     : Jes�s Arag�n
--%>
<%@ page session="true" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="icon" type="image/png" href="<c:url value="/recursos/img/iconos/favicon.ico" />" >
    <link rel="apple-touch-icon" href="<c:url value="/recursos/img/iconos/favicon.ico"/>">
    <link rel="shortcut icon" href="<c:url value="/recursos/img/iconos/favicon.ico"/>">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat">




    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/bootstrap.min.css"/>"/>
    <%--    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/calendar.css"/>"/>--%>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/bootstrap-theme.min.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/bootstrap-datetimepicker.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/bootstrap-toggle.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeJs/default/style.min.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeGrid/default/tree.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeGrid/default/easyui.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeGrid/default/icon.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeGrid/default/demo.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeGrid/bootstrap/datagrid.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/treeGrid/bootstrap/tree.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/recursos/fullcalendar/fullcalendar.css"/>"/>
    <script type="text/javascript" src="<c:url value="/recursos/js/jquery-2.2.0.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/treeGrid/jquery.easyui.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/treeGrid/jquery.datagrid.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/treeGrid/jquery.tree.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/treeGrid/jquery.treegrid.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/starrating/bootstrap-rating-input.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/bootstrap.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/jquery-ui-1.11.4.custom/jquery-ui.js" />"></script>

    <script type="text/javascript" src="<c:url value="/recursos/js/tree/jstree.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/tree/jstree.checkbox.js" />"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/tree/jstree.search.js" />"></script>

    <script type="text/javascript" src="<c:url value="/recursos/js/moment.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/transition.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/collapse.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/bootstrap-toggle.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/bootstrap-datetimepicker.js"/>"></script>
    <%--<script type="text/javascript" src="<c:url value="/scripts/json.min.js" /> "></script>--%>
    <script type="text/javascript" src="<c:url value="/recursos/js/es.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/ar.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/moment.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/fullcalendar/fullcalendar.js"/>"></script>
    <!--        CKEDITOR-->
    <script type="text/javascript" src="<c:url value="/recursos/js/ckeditor.js"/>"></script>

    <!--        DATATABLES-->
    <%--        <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/dataTables.bootstrap.css"/>" />--%>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/dataTables.foundation.css"/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/dataTables.jqueryui.css"/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/dataTables.semanticui.css"/>" />
    <%--        <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/dataTables.material.css"/>" />--%>
    <%--        <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/dataTables.uikit.css"/>" />--%>
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/jquery.dataTables.css"/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/css/dataTables/jquery.dataTables_themeroller.css"/>" />

    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/jquery.dataTables.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.bootstrap.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.bootstrap4.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.buttons.min.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/buttons.print.min.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.foundation.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.jqueryui.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.material.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/dataTables/dataTables.uikit.js"/>" ></script>


    <script type="text/javascript" src="<c:url value="/recursos/js/constantes.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/parentJs/progressStudent.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/parentJs/teacherObservations.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/parentJs/whatIdoing.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/parentJs/reportCard.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/parentJs/calendar.js"/>"></script>
    
    <!--pdf object-->
    <script type="text/javascript" src="<c:url value="/recursos/js/pdfobject.js"/>" ></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/pdfobject.min.js"/>" ></script>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.2/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    
    <link href="https://fonts.googleapis.com/css?family=Coda+Caption:800|Roboto:700" rel="stylesheet">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
    <link rel="stylesheet" type="text/css" href="<c:url value="/recursos/cssParent/homepage.css"/>" />
 
    <script type="text/javascript" src="<c:url value="/recursos/js/utils.js"/>"></script>
  
    <!--<script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/app.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/services.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/controllers.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/filters.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/messages_manager.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/message_composer.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/directives.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/recursos/js/telegram-js/directives_mobile.js"/>"></script>
 -->
 
</head>

<script>
//    $(document).ready(function () {
//        $('logoutmodal').hide();
//    });
    function logout() {
        document.location.href = "<c:url value="/cerrarLogin.htm"/>";
    }
   
</script>


<header>
    <div class="navUsuario" id="infousuario">   
       
        <div class="row">
            <div class="col-xs-7" id="childrensNav">
                <div class="row"> </div>
                <div class="col-xs-12"></div>
            </div>



            <div class="divName col-xs-3">
                <div class="row">
                    <p class="parentName text-center"><strong><c:out value="${sessionScope.user.name}"/></strong></p> 
                    <p class="termName text-center"><c:out value="${sessionScope.termYearName}"/></p>
                </div>
            </div>
            <div class="logOut col-xs-2">
                <a onclick="$('#logoutmodal').modal('show');" role="button" aria-haspopup="true" aria-expanded="false"><img class="imgUser" src="<c:url value="/recursos/img/iconos/logoBamboo_IconLogout.svg"/>"></a>
            </div>
        </div>
    </div>    
</header>



<div id="logoutmodal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header modal-header-delete">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Are you sure you want to logout?</h4>
            </div>
            <div class="modal-footer text-center">
                <button id="buttonDelete" type="button" class="btn btn-danger" data-dismiss="modal" onclick="logout()">Yes</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
            </div>
        </div>

    </div>
</div>

