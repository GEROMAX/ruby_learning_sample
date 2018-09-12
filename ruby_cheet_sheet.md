# 虎の巻
Ruby/Railsの個人的Tipsを書き溜める。  
VSCodeとかPowerShellとかGitのこともついでに書く。

## 配列

### アクセス
* [1,2,3][-1] = 3  
-1は配列の末尾を意味する
* [1,2,3,4,5].first = 1
* [1,2,3,4,5].last = 5
* [1,2,3,4,5][1..3] = [2,3,4]
#### rails拡張で以下のような序数メソッドもある
[rails外で使う場合は"rails"と"active_support/core_ext"のrequireが必要](https://railsguides.jp/active_support_core_extensions.html)
* [1,2,3,4,5].second = 2
* [1,2,3,4,5].third = 3
* [1,2,3,4,5].fourth = 4
* [1,2,3,4,5].fifth = 5

### 長さ
* [1,2,3].length = 3

### 空チェック
* [].empty? = true

### 包含チェック
* [1,2,3].include?(2) = true

### 反転
* [1,2,3].reverse = [3,2,1]

### ソート
* [1,2,3].reverse.sort = [1,2,3]

### ランダマイズ
* [1,2,3].shuffle = [2,3,1]など

### 破壊的メソッド
sortやshuffleなど、新たな配列を返すメソッドはsort!など「!」付きメソッドの場合は元の配列自身が変更される

### 連結
* [1,2,3].join = "123"  
数値の場合は暗黙的に文字列に変換される

### 数値系
* [1,2,3].sum = 6
* [1,2,3].min = 1
* [1,2,3].max = 3

## ハッシュ
* {:name => "GEROMAX"} == {name: "GEROMAX"}  
後者はシンボルを使ったハッシュ定義のシンタックスシュガー

## Gem


## その他
* Object.inspect
要求されたオブジェクトを表現する文字列を返します。  
※シリアライズ結果と解釈可能か。。

* エラー ArgumentError: invalid byte sequence in UTF-8  
UTF-8からすると不正なバイト列が含まれた文字列にgsub等をすると発生する例外  
String#scrubで不正バイトを除去可能  
  * [Ruby の invalid byte sequence in UTF-8 例外を encode("UTF-8", "UTF-8") で回避するのはおかしいよ、という話](http://blog.livedoor.jp/sonots/archives/23652294.html)
  * [Ruby 2.1.0 に追加される不正なバイト列を除去する String#scrub の紹介](http://blog.livedoor.jp/sonots/archives/34702351.html)


## Rails
* gemfileにおけるローカルgemの指定方法  
`gem 'hoge_gem' , path: "/path/to/gem/directory/"`

* railsコンソールでの_pathとか_urlメソッドの確認方法  
`irb(main):001> app.hogehoge_path`  
`irb(main):001> app.hogehoge_url`  
http://interu.hatenablog.com/entry/20101215/1292416973

* render時のtext/plainの出所  
  ここかもしれない  
  https://github.com/rails/rails/blob/23f80cee1845f85ed3aad4b4fb3211cdadf53da8/actionpack/lib/action_dispatch/middleware/static.rb#L83

* railsコンソールでDBに直接クエリ発行  
`ActiveRecord::Base.connection.select_all("select 'hogehoge'")`

* ActiveRecordを試すときに便利なやつ  
https://medium.com/@r7kamura/activerecord%E3%82%92%E8%A9%A6%E3%81%99%E3%81%A8%E3%81%8D%E3%81%AB%E4%BE%BF%E5%88%A9%E3%81%AA%E3%82%84%E3%81%A4-f5a10a8c17d8

* さっと仕掛けるログ  
`logger.debug "[GEROMAX] PLACE:#{self.class.name}\##{__method__} ここやでトントン"`

### Rails チュートリアル 4.4.4 章引用
`実は、Railsは確かにRubyで書かれていますが、既にRubyとは別物なのです。Railsのクラスは、普通のRubyオブジェクトと同様に振る舞うものもありますが、多くのクラスにはRailsの魔法の粉が振りかけられています。Railsは独特であり、Rubyとは切り離して学習する必要があります。`

## RSpec

### DEPRECATION WARNINGのテスト方法
* expect(ActiveSupport::Deprecation).to receive(:warn).with("hogehgoe")  
  do_warning_occur_process()  
[参考](https://morizyun.github.io/ruby/rails-function-rails-logger.html)

## Git
* gitのdiffが文字化けするとき  
[git diff での日本語の文字化け](http://maku77.github.io/git/settings/garbling.html)
  * git config --global core.quotepath false  
  ファイル名の文字化けが治る
  * git config --global core.pager "LESSCHARSET=utf-8 less"  
  内容の文字化けが治る
  