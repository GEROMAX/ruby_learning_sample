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

## その他
* Object.inspect
要求されたオブジェクトを表現する文字列を返します。  
※シリアライズ結果と解釈可能か。。


## Git
* gitのdiffが文字化けするとき  
[git diff での日本語の文字化け](http://maku77.github.io/git/settings/garbling.html)
  * git config --global core.quotepath false  
  ファイル名の文字化けが治る
  * git config --global core.pager "LESSCHARSET=utf-8 less"  
  内容の文字化けが治る
  