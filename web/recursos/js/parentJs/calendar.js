function initCalendar(url) {
    resetNavInf();
    /*
     *  resetNavInf();
                            currentOption = "calendar";
                            $("#navInfCalendar").empty();
                            url = "<c:url value='/recursos/img/iconos/n_CalendarIconNaranja.svg'/>";
                            $("#navInfCalendar").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
                            menu("calendar");
     */

    currentOption = "calendar";
    $("#navInfCalendar").empty();
    $("#navInfCalendar").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
    menu("calendar");
   
}

function initCalendarMenu(url) {
    currentOption = "calendar";
    $("#navInfCalendar").empty();
    $("#navInfCalendar").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Calendar and Announcements'>");
  //  getReport();
    $("#calendarPage").show();
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