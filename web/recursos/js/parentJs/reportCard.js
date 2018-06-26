function initReportCard(url) {
    resetNavInf();
    /*currentOption = "teacherObservations";
     $("#navInfObservations").empty();
     $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");
     menu("teacherObservations");
     $("#navInfReport").hide();
     $("#navInfMore").attr("value", "a_MenuIcon.svg");
     
     currentOption = "report";
     $("#navInfReport").empty();
     url = "<c:url value='/recursos/img/iconos/n_ReportIconNaranja.svg'/>";
     $("#navInfReport").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
     menu("report");
     $("#navInfReport").hide();
     $("#navInfMore").attr("value", "a_MenuIcon.svg");
     */

    currentOption = "report";
    $("#navInfReport").empty();
    $("#navInfReport").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
    menu("report");
  /*  $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");*/
}

function initReportCardMenu(url) {
    currentOption = "report";
    $("#navInfReport").empty();
    $("#navInfReport").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
    getReport();
    $("#reportPage").show();
}

$(document).ready(function () {


});

function getReport() {
    $.ajax({
        type: "POST",
        url: "getReport.htm",
        data: {
            idStudent: currentStudent
        },
        datatype: "json",
        success: function (data) {
            var data2 = JSON.parse(data);
            $('#objectPdf').attr("data", "data:application/pdf;base64," + data2.report);
            $('#linkPdf').attr("href", "data:application/pdf;base64," + data2.report);


            /* var pdfObject = $("#objectPdf");
             * 
             pdfObject.attr("type", "application/pdf");
             pdfObject.attr("data", "data:application/pdf;base64," + data2.report);*/
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(xhr.responseText);
            console.log(thrownError);
        }
    });
}