function initWhatDoing(url) {
    resetNavInf();
    /*currentOption = "teacherObservations";
    $("#navInfObservations").empty();
    $("#navInfObservations").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Teachers Observations'>");
    menu("teacherObservations");
    $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");
    
    
    */
   
    currentOption = "whatIdo";
    $("#navInfWhatIam").empty();
    $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='What I am learning now?'>");
    menu("whatIdo");
    $("#navInfReport").hide();
    $("#navInfMore").attr("value", "a_MenuIcon.svg");
}

function initWhatDoingMenu(url) {
    currentOption = "whatIdo";
    $("#navInfWhatIam").empty();
    $("#navInfWhatIam").append("<img src='" + url + "' data-toggle='tooltip' data-placement='top' title='Student Progress'>");
    $("#whatsDoingPage").show();
}