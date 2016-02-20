$(document).ready(function(){
    $('.parallax').parallax();
});
var options = [
    {selector: '.class', offset: 200, callback: 'globalFunction()' },
    {selector: '.other-class', offset: 200, callback: 'globalFunction()' },
  ];
 Materialize.scrollFire(options);