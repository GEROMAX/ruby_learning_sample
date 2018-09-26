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

* ファイル書き込みのバグ？  
  Windows環境`ruby 2.4.4p296 (2018-03-28 revision 63013) [x64-mingw32]`では、100MBクラスのファイルを一気に書き込もうとすると、データが破損する事象を確認した  
  以下のようなコードで回避できた  
  ```
  offset = 0
  while offset < dmp.size
    offset += IO.write(cache_file_name, dmp[offset..(offset + 999999)], offset, encoding: FILE_ENCODE)
  end
  ```
  なお、linux環境では未確認


## Rails
* gemfileにおけるローカルgemの指定方法  
`gem 'hoge_gem' , path: "/path/to/gem/directory/"`

* railsコンソール起動時のカレントディレクトリはアプリケーションのルートディレクトリを指す  
  ```
  /hoge/sample_app/  
  ∟app  
  ∟bin  
  ∟config  
  ```
  上記のような場合、`/hoge/sample_app`となる

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

* Completedログの見方  
  `Completed 200 OK in 8567ms (Views: 1543.8ms | ActiveRecord: 3175.6ms)`  
  上記のようなログの場合、それぞれactionの処理時間、Viewの処理時間、ActiveRecordの処理時間となる  
  ActiveRecordの処理時間は、発行したクエリの結果がfetchされるまでの様子(ActiveRecordオブジェクトの生成時間は含まない模様)  
  https://qiita.com/koshigoe/items/c0c4180518bf5f90451d  
  https://railsguides.jp/active_support_instrumentation.html#process-action-action-controller

### Rails チュートリアル引用
* 4.4.4 章  
`実は、Railsは確かにRubyで書かれていますが、既にRubyとは別物なのです。Railsのクラスは、普通のRubyオブジェクトと同様に振る舞うものもありますが、多くのクラスにはRailsの魔法の粉が振りかけられています。Railsは独特であり、Rubyとは切り離して学習する必要があります。`
* 5.1章  
`image_tagの効果を確かめるために、ブラウザから生成されたHTMLを見てみましょう。`  
  `  <img alt="Rails logo" src="/assets/rails-9308b8f92fea4c19a3a0d8385b494526.png" />`  
`ファイル名が重ならないようにするために、9308b8f92fea4c19a3a0d8385b494526という文字列 (実際の文字列はシステムごとに異なります) をRailsが追加していることがわかります。これは、例えば画像ファイルを新しい画像に更新したときに、ブラウザ内に保存されたキャッシュに意図的にヒットさせないようにするための仕組みです。`  
`alt属性は、画像がない場合に代わりに表示される文字列です。例えば視覚障害のあるユーザーが使うスクリーンリーダーでは、ここの属性が読み上げられて、そこに画像があることが示されます。`

## RSpec

### DEPRECATION WARNINGのテスト方法
* expect(ActiveSupport::Deprecation).to receive(:warn).with("hogehgoe")  
  do_warning_occur_process()  
[参考](https://morizyun.github.io/ruby/rails-function-rails-logger.html)

## Git
* gitのdiffが文字化けするとき  
[git diff での日本語の文字化け](http://maku77.github.io/git/settings/garbling.html)
  * ファイル名の文字化けを治す  
  `git config --global core.quotepath false`
  * 内容の文字化けを治す  
    `git config --global core.pager "LESSCHARSET=utf-8 less"`


* GHEのssl証明書をgitに読み込ませる方法  
  [Adding a corporate (or self-signed) certificate authority to git.exe’s store](https://blogs.msdn.microsoft.com/phkelley/2014/01/20/adding-a-corporate-or-self-signed-certificate-authority-to-git-exes-store/)

## デバッグ関連
* webページへのcurlコマンド自動生成
  * chromeのdeveloperツールのnetwoerkで通信を選んで、
    * 右クリック
    * copy
    * copy as cURLでコマンドでコマンド自動生成できる
  * ちなみにcopy as PowerShellでPS用コマンドも生成できる
  * マジ神機能！

* tcpの通信内容を見たいとき  
  tdpdumpってコマンドでできるらしい  
  ただし、トラフィックが増えるので本番環境ではまず使わないほうがいいらしい

* [HTTPリクエストを送信できるChromeアドオン](http://redmine.tabelog.local/projects/tabelog/wiki/TabelogAppliReplaceAPIValidation)
  * テストの時に役立つ

* ajaxのデバッグ
  クライアントからajaxのリクエストを送るには？  
  [Restlet Client](https://chrome.google.com/webstore/detail/restlet-client-rest-api-t/aejoelaoggembcahagimdiliamlcdmfm)を使ってajaxであることを示す以下のリクエストヘッダを設定し、当該のURLにgetなりpostなりする
    * X-Requested-With: XMLHttpRequest  
    これでrailsのxhr?をパスできる

* [ガラケーのUser-AgentをシミュレートできるChromeアドオン](https://chrome.google.com/webstore/detail/firemobilesimulator-for-g/mkihbloiacgiofaejgagokalpeflnmbe)  
  すごい便利

## PowerShell
* backspece押下時のBeep音の消し方  
  `Set-PSReadlineOption -BellStyle None`をプロファイルに追加する  
  [Windows 10 の PowerShell で Backspace の音を消す方法 + PowerShell のプロファイル](http://yaimairi.hateblo.jp/entry/2016/09/09/225733)