google.load("feeds", "1");
function initialize() {
 //RSSフィードの取得
 var blogURL = "http://natmark.hateblo.jp/";
 var feed = new google.feeds.Feed( blogURL+ "rss");
 //取得するフィード数
 feed.setNumEntries(5);
 //実際に読む込む
 feed.load(function(result) {
 //読み込めたか判別
  if (!result.error) {
   //表示部分を選択
   var container = document.getElementById("new_entries_feed");
   //変数の初期化
   var useFeed = "";
   //Feedの処理
   for (var i = 0; i < result.feed.entries.length; i++) {
    //Feedを一つ抽出
    var entry = result.feed.entries[i];
    //日付を抽出
    var pdate = new Date(entry.publishedDate);
    var strdate = (1900 + pdate.getYear()) + '年' + (pdate.getMonth() + 1) + '月' + pdate.getDate() + '日';
    //画像がない場合を考慮
    var no_image = "./Assets/img/hatena-no-image.jpg";
    //最初の画像を抽出
    //var first_image = (entry.content.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/) != null) ? entry.content.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/) : no_image.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/);
    var first_image = (entry.content.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/) != null) ? entry.content.match(/http(?:s|):{1}[\S_-]+\.(?:jpg|gif|png)/) : null;
    
    var image_uri = no_image;
    if(first_image != null){
        image_uri = first_image[0];
    }
    //リストに突っ込む
    //useFeed += '<div class="htbl_new_entry"><a href="' + entry.link + '"><img class="htbl_new_entry_img" src="' + first_image[0] + '"><div class="htbl_new_entry_text"><span class="entry_title">' + entry.title + '</span><span class="entry_date">' + strdate + '</span></div></a></div>';
    useFeed += '<div class="htbl_new_entry"><a href="' + entry.link + '"><img class="htbl_new_entry_img" src="' + image_uri + '"><div class="htbl_new_entry_text"><span class="entry_title">' + entry.title + '</span><span class="entry_date">' + strdate + '</span></div></a></div>';
   }
  //リストを表示させる
  container.innerHTML = '<div class="htbl_new_entries">' + useFeed + '</div>';
 }
 });
}
google.setOnLoadCallback(initialize);