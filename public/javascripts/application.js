$(function(){
   $(".account").click(function(e){
      var $this = $(this);
      $this.find(".form").slideDown("slow");
      $this.addClass("selected"); 
   });
});