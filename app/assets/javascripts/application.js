// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require_tree


 
/*global $*/
$(document).ready(function() {
    
    var homeHeadingFirstLine = $("#homeHeadingFirstLine");
    var homeHeadingSecondLine = $("#homeHeadingSecondLine");
    var homeHeadingThirdLine = $("#homeHeadingThirdLine");
    var homeHeadingFourthLine = $("#homeHeadingFourthLine");
    
    homeHeadingFirstLine.hide(); 
    homeHeadingSecondLine.hide(); 
    homeHeadingThirdLine.hide(); 
    homeHeadingFourthLine.hide();  
    
    homeHeadingFirstLine.fadeIn(1000,function(){
      homeHeadingSecondLine.fadeIn(1000,function(){
          homeHeadingThirdLine.fadeIn(1000,function(){
              homeHeadingFourthLine.fadeIn(1000,function(){
                  $('#sparklesBackground').css("background-image", "url('/assets/snowfall_transparent.gif')");
              })
          })
        })
    });	
})

