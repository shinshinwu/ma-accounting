$(document).ready(function(){
  setTimeout(function(){
    $('.flash').fadeOut();
  }, 8000);

  /* Dismissalbe alert */

  $(".flash.alerttop").click(function(event){
    $(this).fadeToggle(350);

    return false;
  });
});
