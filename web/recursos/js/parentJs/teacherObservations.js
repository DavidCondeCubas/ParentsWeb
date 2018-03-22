function getWeeks() {
    var d = new Date();
    var startMonth = 1;
    var starYear = 2018;
    var contMonth = startMonth;
    var month = d.getMonth() + 1;
    
    while(contMonth <= )
   
    var day = d.getDate();
    var year = d.getYear();
    
    
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
