function initObservations(url) {
    resetNavInf();
    currentOption = "teacherObservations";
    $("#navInfObservations").empty();
    $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");
    menu("teacherObservations");
    $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");
}
function initObservationsMenu(url) {
    currentOption = "navInfObservations";
    $("#navInfObservations").empty();
    $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");
    $("#teacherObservations").show();
}


function getWeeks() {
    $("#divCircleWeeks").empty();
    var d = new Date();

    var startMonth = 10;
    var startYear = 2017;
    var contMonth = startMonth;
    var contYear = startYear;

    var currentMonth = d.getMonth() + 1;
    var currentYear = d.getFullYear();

    while (contMonth <= currentMonth || contYear < currentYear) {
        var numWeeks = weeksInAMonth(contYear, contMonth);
        makeCircleWeek(numWeeks,contMonth,(contMonth === startMonth && contYear === startYear));
        contMonth = (contMonth + 1) % 13;
        if (contMonth === 0) {
            ++contYear;
            ++contMonth;
        }
    }
}

function makeCircleWeek(numWeeks, contMonth,first) {
    //SOLO PARA MOVIL
    var tamCircleWeekMovil =0;
    if(first === true)  var tamCircleWeekMovil = 10;
    tamCircleWeekMovil += (35*numWeeks);
    $("#namesMonths").append("<div style='color:" + monthColors[contMonth - 1] + ";width:" +tamCircleWeekMovil+ "px'>" + monthNames[contMonth - 1].toUpperCase() + "</div>");
    for (var i = 1; i <= numWeeks; ++i) {
        $("#divCircleWeeks").append("<div class = 'circleWeek' style='background-color:" + monthColors[contMonth - 1] + "' > " + i + "w < /div>")
    }

}
function weeksInAMonth(year, month_number) {
    var firstOfMonth = new Date(year, month_number - 1, 1);
    var day = firstOfMonth.getDay() || 6;
    day = day === 1 ? 0 : day;
    if (day) {
        day--
    }
    var diff = 7 - day;
    var lastOfMonth = new Date(year, month_number, 0);
    var lastDate = lastOfMonth.getDate();
    if (lastOfMonth.getDay() === 1) {
        diff--;
    }
    var result = Math.ceil((lastDate - diff) / 7);
    return result + 1;
}
