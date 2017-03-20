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
  $(".show-more a").on("click", function() {
    // e.preventDefault();
    var $this = $(this); 
    var $content = $this.parent().prev("div.content");
    var linkText = $this.text().toUpperCase();    
    
    if(linkText === "SHOW MORE"){
        linkText = "Show less";
        $content.toggleClass("hideContent", "showContent");
    } else {
        linkText = "Show more";
        $content.toggleClass("showContent", "hideContent");
    };

    $this.text(linkText);
});
}