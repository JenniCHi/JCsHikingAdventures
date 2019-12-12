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

/*This code is responsible for the home page animation*/
/*global $*/
$(document).ready(function() {
    
    //Gets the animations I want to animate
    var homeHeadingFirstLine = $("#homeHeadingFirstLine");
    var homeHeadingSecondLine = $("#homeHeadingSecondLine");
    var homeHeadingThirdLine = $("#homeHeadingThirdLine");
    var homeHeadingFourthLine = $("#homeHeadingFourthLine");
    
    //Hides the elements first to I can animate them fading in
    homeHeadingFirstLine.hide(); 
    homeHeadingSecondLine.hide(); 
    homeHeadingThirdLine.hide(); 
    homeHeadingFourthLine.hide();  
    
    //This sequence of code ensure elements fade in one by one
    homeHeadingFirstLine.fadeIn(1000,function(){
      homeHeadingSecondLine.fadeIn(1000,function(){
          homeHeadingThirdLine.fadeIn(1000,function(){
              homeHeadingFourthLine.fadeIn(1000,function(){
                  //The snow falling on the home screen is achieved by this line
                  $('#sparklesBackground').css("background-image", "url('/assets/snowfall_transparent.gif')");
              })
          })
        })
    });	
})

