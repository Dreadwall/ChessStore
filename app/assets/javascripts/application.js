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


function test(id, obj) {  
  var $input = $(obj).parents('.input-number-group').find('.input-number');
  var val = parseInt($input.val(), 10);
  if(val > 0){
    $.ajax({
        type: "POST",
        url: "/add_item",
        data: { id:id, quantity: val},
      });
    $input.val(0);
  }
}




$(".alert-box" ).fadeOut(5000);
