$(function () {
      $.get('https://api.github.com/users/natmark/subscriptions').then(function (repos) {
        $.each(repos,function(index,repo){
          //Star1つ以上のリポジトリ
          if(repo['stargazers_count'] > 0){
            //リポジトリStarをつけたUser一覧取得
            $.get(repo['stargazers_url']).then(function (users) {
                $.each(users,function(index,user){
                    //自分自身なら
                    if(user['login'] == "natmark"){
                      console.log('full_name:' + repo['full_name'])
                      //console.log(repo['created_at'])
                      console.log('updated_at:' + repo['updated_at'])
                      console.log('description:' + repo['description'])
                      console.log('url:' + repo['html_url'])
                      console.log('language:' + repo['language'])
                      //console.log(repo['stargazers_count'])
                      var content = '<section class="project">\n<div class="project-content">\n<h1 class="project-title">\n'
                      content += repo['full_name'] + '</h1>\n<p class="project-text">'
                      content += repo['description'] + '</p>\n</div>\n<div class="project-link">\n<div class="project-tag">\n<div class="tag">\n'
                      content += '<div class="label label-main label-info"><div class="label-text"><i class="fa fa-code fa-fw"></i></div>' + repo['language'] +'</div>\n</div>\n</div>'

                      content += '<a href="' + repo['html_url'] +'">Repo</a>\n</div>\n</section>';

                      $('div.projects').append(content);
                    }
                });
            });
          }
        });
      });
    });
