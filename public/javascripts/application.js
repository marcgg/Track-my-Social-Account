$(function(){
    
  $("#accounts .header").click(function(e){
    var $this = $(this);
    var $parent = $this.parent();
    var $form = $parent.find(".form");
    if($form.is(":visible")){
      $form.slideUp("slow");
      $parent.removeClass("selected");
    }else{
      $form.slideDown("slow");
      $parent.addClass("selected");
    }
    
  });
   
  /* HANDLING NOTICES */
  $("#flash").delay(1500).slideDown("slow").delay(5000).slideUp("slow");
  
});