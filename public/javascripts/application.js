$(function(){
    
  $(".account").click(function(e){
    var $this = $(this);
    var $form = $this.find(".form");
    if($form.is(":visible")){
      $form.slideUp("slow");
      $this.removeClass("selected");
    }else{
      $form.slideDown("slow");
      $this.addClass("selected");
    }
    
  });
   
  /* HANDLING NOTICES */
  $("#flash").delay(1500).slideDown("slow").delay(5000).slideUp("slow");
  
});