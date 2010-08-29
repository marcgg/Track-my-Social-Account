$(function(){
    
  $(".account").click(function(e){
    var $this = $(this);
    $this.find(".form").slideDown("slow");
    $this.addClass("selected"); 
  });
   
  /* HANDLING NOTICES */
  $("#flash").delay(1500).slideDown("slow").delay(5000).slideUp("slow");
  
});