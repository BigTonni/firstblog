// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){

});
var number = 0;

function add_tag_form(){
    input = $(".tag-name:last");
    name = input.attr('name');
    //console.log(name);
    var number =  Number(name.replace(/\D+/g,""))+1;
    cloned_input =  input.clone().val('').attr('name','post[tags_attributes]['+number+']');
    $(input).after(cloned_input);
    //console.log(number);
}
function remove_tag_form(){
    $('input#post_tags_attributes_0_name:last').remove();
}