$(document).ready(function(){
	
	$('#customer').on('change', function(){
	 $.ajax({
		url:"/customer",
		method:"GET",
		data:{id: $("#customer").val()},
		success:function(data){
			$(".next-step1").show()
			console.log(data)
			console.log(data.length)
			setoption("#building", data)
		
		}
    })
	})
	
	$('#building').on('change', function(){
	 $.ajax({
		url:"/building",
		method:"GET",
		data:{id: $("#building").val()},
		success:function(data){
			$(".next-step2").show()
			console.log(data)
			console.log(data.length)
			setoption("#battery", data)
		
		}
    })
	})
	
	$('#battery').on('change', function(){
	 $.ajax({
		url:"/battery",
		method:"GET",
		data:{id: $("#battery").val()},
		success:function(data){
			$(".next-step3").show()
			console.log(data)
			console.log(data.length)
			setoption("#column", data)
		
		}
    })
	})
	
		$('#column').on('change', function(){
	 $.ajax({
		url:"/column",
		method:"GET",
		data:{id: $("#column").val()},
		success:function(data){
			$(".next-step4").show()
			console.log(data)
			console.log(data.length)
			setoption("#elevator", data)
		
		}
    })
	})
	
	
	function setoption(who,data){
		$(who).html('')
		$(who).append(new Option("select","select"))
			for(var i=0;i<data.length;i++){
				$(who).append(new Option(data[i].id,data[i].id))
			}
	}
})