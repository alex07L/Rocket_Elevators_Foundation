$(window).bind('scroll', function() {
    var currentTop = $(window).scrollTop();
    var elems = $('.scrollspy');
    elems.each(function(index){
      var elemTop 	= $(this).offset().top;
      var elemBottom 	= elemTop + $(this).height();
      if(currentTop >= elemTop-250 && currentTop <= elemBottom){
        var id = $(this).attr('id');
        console.log("ok"+id)
        var elevator = $("#melevator").offset().top;
        var time = 10;
        var scroll = (elemTop-elevator)/time;
        $("#melevator").animate({ top: "+="+(scroll)+"px"}, time)
      }
    })
});