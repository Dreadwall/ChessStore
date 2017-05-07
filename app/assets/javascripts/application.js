// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

$('.input-number-increment').click(function() {
  var $input = $(this).parents('.input-number-group').find('.input-number');
  var val = parseInt($input.val(), 10);
  $input.val(val + 1);
});

$('.input-number-decrement').click(function() {
  var $input = $(this).parents('.input-number-group').find('.input-number');
  var val = parseInt($input.val(), 10);
  if(val > 0){
  	$input.val(val - 1);
  }	
});

$('.input-number').on('change', function() {
   var $input = $(this).parents('.input-number-group').find('.input-number');
   var val = parseInt($input.val(), 10);
   if(val < 0){
  	$input.val(0);
   }	
});


function myFunction(id) {
    var popup = document.getElementById("myPopup"+id);
    popup.classList.toggle("show");
}



function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function demo() {
  console.log('Taking a break...');
  await sleep(2000);
  console.log('Two second later');
}


async function add_cart_orderItem(id, obj) {  
  var $input = $(obj).parents('.input-number-group').find('.input-number');
  var val = parseInt($input.val(), 10);
  if(val > 0){
    $.ajax({
        type: "POST",
        url: "/add_item",
        data: { item_id:id, quantity: val},
      });
    $input.val(0);
    myFunction(id);
    await sleep(2000);
    myFunction(id);
  }
}


function remove_cart_Orderitem(id, obj) {
  $.ajax({
        type: "POST",
        url: "/remove_item",
        data: { item_id:id},
      });
}







$('#myflash').replaceWith('<%= j render("partials/flash") %>');


$(".alert-box" ).fadeOut(5000);
