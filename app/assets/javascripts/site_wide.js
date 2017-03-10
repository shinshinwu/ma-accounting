$(document).ready(function(){
  setTimeout(function(){
    $('.flash').fadeOut();
  }, 8000);

  $('#nestable-menu').nestable();

  /* Dismissalbe alert */

  $(".myadmin-alert-click").click(function(event){
    $(this).fadeToggle(350);

    return false;
  });
});
