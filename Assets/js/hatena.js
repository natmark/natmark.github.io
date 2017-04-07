const DISPLAY_SIZE = 5;
$(function(){
    $.getJSON("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20rss%20where%20url%3D'http%3A%2F%2Fnatmark.hateblo.jp%2Frss'&format=json&diagnostics=true&callback=",
    function(json) {
        var container = document.getElementById('new_entries_feed');
        //変数の初期化
        var useFeed = "";
        var count = 0

        jQuery.each(json.query.results.item, function() {
          var item = $(this)[0];
          console.log(item)

          console.log(item.link);
          console.log(item.title);

          //画像がない場合を考慮
          var no_image = "./Assets/img/hatena-no-image.jpg";
          //最初の画像を抽出
          var first_image = (item.description.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/) != null) ? item.description.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/) : null;
          var image_uri = no_image;
          if(first_image != null){
            image_uri = first_image[0];
          }
          console.log(image_uri);

          //日付を抽出
          var pdate = new Date(item.pubDate);
          var strdate = (1900 + pdate.getYear()) + '年' + (pdate.getMonth() + 1) + '月' + pdate.getDate() + '日';
          console.log(strdate);

          if(count < DISPLAY_SIZE){
            //リストに突っ込む
            useFeed += '<div class="htbl_new_entry"><a href="' + item.link + '"><img class="htbl_new_entry_img" src="' + image_uri + '"><div class="htbl_new_entry_text"><span class="entry_title">' + item.title + '</span><span class="entry_date">' + strdate + '</span></div></a></div>';
          }
          count++;
        });
        //リストを表示させる
        container.innerHTML = '<div class="htbl_new_entries">' + useFeed + '</div>';
    });
});
