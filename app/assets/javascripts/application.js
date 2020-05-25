//ナビバーを下にスクロールしたら消えて少しでも上にスクロールしたらだす
$(window).on('load', function(){
  var menuHeight = 56;
  var startPos = 0;
  $(window).scroll(function(){
    var currentPos = $(this).scrollTop();
    if (currentPos > startPos) {
      if($(window).scrollTop() >= 200) {
        $("#navbar").css("top", "-" + menuHeight + "px");
      }
    } else {
      $("#navbar").css("top", 0 + "px");
    }
    startPos = currentPos;
  });
});

function keyUp() {
  document.getElementById('characnt').value=400 - document.getElementById('novel_text').value.length;
  if (document.getElementById('novel_text').value.length > 400) {
    document.getElementById("submit").disabled = true;
  }
  else {
    document.getElementById("submit").disabled = false;
  }
}