$(document).ready(function(){
$(window).scroll(function() {
    var currentTop = $(window).scrollTop();
    var elems = $('.scrollspy');
    elems.each(function(index){
      var elemTop 	= $(this).offset().top;
      var elemBottom 	= elemTop + $(this).height();
	  
      if(currentTop >= elemTop-400 && currentTop <= elemBottom-225){
        var id = $(this).attr('id');
        test=0;
        var elevator = $("#melevator").offset().top;
        var time = 5;
        var scroll = (elemTop-elevator)/time;
		console.log("ok"+id+" "+elemTop)
        $("#melevator").animate({ top: "+="+(scroll)+"px"}, time)
      }
	  
    })
});
});