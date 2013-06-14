$(document).ready(function() {
   $('.pagination a').attr('data-remote', 'true');    
  // alert('hii');
   ajaxifyPagination();

});

function ajaxifyPagination() {
    $(".pagination a").live("click", function () {//alert('hii');
	var paginatn=$(this).attr("href");
var value = paginatn.substring(paginatn.lastIndexOf("/") + 1);//alert(value);
    	$.ajax({
    	  type: "GET",
    	  url: $(this).attr("href"),
	//url: '../quoteList/'+value,
    	  success: function(data){
     //alert(data);
 result = $(data).find("#devices");
        //alert(result);
$("#devices").html(result);

        }
    	});
if(paginatn!=window.location){
      window.history.pushState({path:paginatn},'',paginatn);
    }goToByScroll('mymain');
    	return false;
    });
}

function goToByScroll(id){
    $('html,body').animate({scrollTop: $("."+id).offset().top - 30},'slow');
}
