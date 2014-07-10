#KSL
  
  
##What is this?
UNIX Like Shell Envitonment.  
UNIX風のシェル環境を提供します  
マルチプラットフォームに対応していますのでどんな環境でも動きます  
元々はKaiOSという名称でしたが、紛らわしいので名称を変えました  
正式名称はKai Shellです  
これはOSv用のブランチとなっています  
ライセンスをGPLv3からMITに変更しました  
  
  
##機能
###OSv版(現在公開されてる段階のもの)ではほとんどの機能が実装されていません)
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
2014/7/10  KSL 0.0.3 OSv用に移植及びプラグイン機構の実装を開始  
  
##開発環境/動作環境
 ArchLinux 3.15.2-1-ARCH x86_64  
ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-linux]  
  
  
##LICENSE  
The MIT LICENSE <http://opensource.org/licenses/MIT>
  
##WEB SITE
Blog <http://blog.alpha-kai-net.info>  
HP <http://alpha-kai-net.info>  
Twitter <http://twitter.com/alpha_kai_net>  
Github <https://github.com/alphaKAI>  
Mail to <alpha.kai.net@alpha-kai-net.info>  
  
  
Copyright (C) α改 @alpha_kai_NET 2012-214 http://alha-kai-net.nfo
