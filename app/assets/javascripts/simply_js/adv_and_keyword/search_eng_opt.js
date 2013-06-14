function putComma(event)
{
   var keyCode = event.which || event.keyCode;
   if(keyCode == 13)
   {
      event.preventDefault();
      var currKeyword = document.getElementById("keyword_keyword").value; 
      document.getElementById("keyword_keyword").value = currKeyword + ", "; 
      var newKeyword = document.getElementById("keyword_keyword").value; 
   }
   if(keyCode == 44)
   {
      event.preventDefault();
   }
}


