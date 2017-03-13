var ready;

ready = function() {
  initializeMaterializeElements();
  bindEventListeners();
};

$(document).ready(ready);
$(document).on('page:load', ready);


function initializeMaterializeElements(){
  console.log("initialized materialized elements");
}

function bindEventListeners(){
  console.log("bound listeners");
}