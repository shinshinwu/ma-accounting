var ready;

ready = function() {
  initializeMaterializeElements();
  bindEventListeners();
};

$(document).ready(ready);
$(document).on('page:load', ready);


function initializeMaterializeElements(){
  
    $('.button-collapse').sideNav();
    $('.parallax').parallax();
    $('.modal').modal();

    options = [
      {selector: '#image-test', offset: 0, callback: function(el) {
        Materialize.fadeInImage($(el));
      } }
    ];
    Materialize.scrollFire(options);

    $('.collapsible').collapsible();
    
  console.log("initialized materialized elements");
}

function bindEventListeners(){
  smoothScroll.init();
}