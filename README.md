#KSL
  
  
##What is this?
UNIX Like Shell Envitonment.  
UNIX風のシェル環境を提供します  
マルチプラットフォームに対応していますのでどんな環境でも動きます  
現在はRubyで実装していますが、C言語での実装もそのうちします  
元々はKaiOSという名称でしたが、紛らわしいので名称を変えました  
正式名称はKai Shellです  
  
  
##機能
    echo 引数: echoです　リダイレクトなどは未実装  
    cat 引数: catです リダイレクトなどは未実装  
    cd 引数: cdです  
    date 引数(オプション): 現在時刻を表示します 任意のフォーマットに出力を変えることも可能  
    ls 引数(オプション): 引数がある場合はそのディレクトリの中を一覧表示します ない場合はカレントディレクトリを表示します  
    pwd: カレントディレクトリの絶対パスを表示します  
    base64 オプション 引数: 指定された引数をエンコード/デコードします 詳しくはbase64 -hで  
    match 引数1,引数2: 1の文字列の中で2のパターンにマッチする個数とマッチする場所を出力します  
    help: 実装されているコマンドの一覧を表示します  
    version: 現在のバージョンを表示します  
    .コマンド名: KaiOSに実装されていないコマンドでも本来のシェルに実装されていれば使うことができます  
    exit: KaiOSを終了させます  
    ディレクトリ名:ディレクトリ名だけ入力した場合に自動的にcdします  
    補完機能:カレントディレクトリにあるフォルダ名/ファイル名 及び実装されているコマンドをTABで補完します  
  
  
##VERSION
2013/11/18 KSL 0.0.3 KaiOSより改称  
  
  
##開発環境/動作環境
Arch Linux 3.11.6-1-ARCH x86_64  
ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-linux]  
  
  
##LICENSE  
GPLv3 LICENSE <http://www.gnu.org/licenses/gpl-3.0.html>  
  
  
##WEB SITE
Blog <http://blog.alpha-kai-net.info>  
HP <http://alpha-kai-net.info>  
Twitter <http://twitter.com/alpha_kai_net>  
Github <https://github.com/alphaKAI>  
Mail to <alpha.kai.net@alpha-kai-net.info>  
  
  
Copyleft (C) α改 @alpha_kai_NET 2012-2013 http://alha-kai-net.nfo
