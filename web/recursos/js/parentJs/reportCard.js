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
    var is_safari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
    if (is_safari) {
        $("#idObjectReport").empty();
        $("#idObjectReport").append("<p>This browser does not support PDFs. Please download the PDF to view it: <a id='linkPdf' onclick='downloadPdf()'>Download PDF</a>.</p>");
    }

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

function downloadPdf() {

    var blob = b64toBlob($("#objectPdf").attr("data").split(',')[1], 'application/pdf');
    var blobUrl = URL.createObjectURL(blob);
    window.open(blobUrl);
}

function b64toBlob(b64Data, contentType, sliceSize) {
    contentType = contentType || '';
    sliceSize = sliceSize || 512;

    var byteCharacters = atob(b64Data);
    var byteArrays = [];

    for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
        var slice = byteCharacters.slice(offset, offset + sliceSize);

        var byteNumbers = new Array(slice.length);
        for (var i = 0; i < slice.length; i++) {
            byteNumbers[i] = slice.charCodeAt(i);
        }

        var byteArray = new Uint8Array(byteNumbers);

        byteArrays.push(byteArray);
    }

    var blob = new Blob(byteArrays, {type: contentType});
    return blob;
}
