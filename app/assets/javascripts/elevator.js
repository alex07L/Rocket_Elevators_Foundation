$(document).ready(function(){
$(window).scroll(function() {
    var currentTop = $(window).scrollTop();
    var elems = $('.scrollspy');
    elems.each(function(index){
      var elemTop 	= $(this).offset().top;
      var elemBottom 	= elemTop + $(this).height();
	  
      if(currentTop >= elemTop-400 && currentTop <= elemBottom-225){
        var id = $(this).attr('id');
        var elevator = $("#melevator").offset().top;
        var time = 5;
        var scroll = (elemTop-elevator)/time;
        $("#melevator").animate({ top: "+="+(scroll)+"px"}, time)
      }
	  
    })
});
});