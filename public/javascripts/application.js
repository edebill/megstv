$(document).ready(function(){
    $(':input').each(function(index, element){
        if ($(element).val().match("^e\.g\.")){
            $(element).addClass("example");
            $(element).focus(function(event){
                $(event.target).val("").unbind("focus").removeClass("example");
            });
        }
    });
});